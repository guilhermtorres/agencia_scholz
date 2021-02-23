import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:agencia_scholz/app/src/data/cart_product_data.dart';
import 'package:agencia_scholz/app/src/models/address_model.dart';
import 'package:agencia_scholz/app/src/models/cart_product_manager_model.dart';

enum Status { canceled, preparing, transporting, delivered }

class Order {
  Order.fromCartManager(CartManager cartManager) {
    items = List.from(cartManager.items);
    price = cartManager.totalPrice;
    userId = cartManager.user.id;
    address = cartManager.address;
    status = Status.preparing;
  }

  Order.fromDocument(DocumentSnapshot doc) {
    orderId = doc.documentID;

    items = (doc.data['items'] as List<dynamic>).map((e) {
      return CartProduct.fromMap(e as Map<String, dynamic>);
    }).toList();

    price = doc.data['price'] as num;
    userId = doc.data['user'] as String;
    address = Address.fromMap(doc.data['address'] as Map<String, dynamic>);
    date = doc.data['date'] as Timestamp;

    status = Status.values[doc.data['status'] as int];
  }

  final Firestore firestore = Firestore.instance;

  void updateFromDocument(DocumentSnapshot doc) {
    status = Status.values[doc.data['status'] as int];
  }

  Future<void> save() async {
    firestore.collection('orders').document(orderId).setData({
      'items': items.map((e) => e.toOrderItemMap()).toList(),
      'price': price,
      'user': userId,
      'address': address.toMap(),
      'date': Timestamp.now(),
      'status': status.index,
    });
  }

  Function() get back {
    return status.index >= Status.transporting.index
        ? () {
            status = Status.values[status.index - 1];
            firestore.collection('orders').document(orderId).updateData({'status': status.index});
          }
        : null;
  }

  Function() get advance {
    return status.index <= Status.transporting.index
        ? () {
            status = Status.values[status.index + 1];
            firestore.collection('orders').document(orderId).updateData({'status': status.index});
          }
        : null;
  }

  void cancel() {
    status = Status.canceled;
    firestore.collection('orders').document(orderId).updateData({'status': status.index});
  }

  String orderId;

  List<CartProduct> items;
  num price;

  String userId;

  Address address;

  Status status;

  Timestamp date;

  String get formattedId => '#${orderId.padLeft(6, '0')}';

  String get statusText => getStatusText(status);

  static String getStatusText(Status status) {
    switch (status) {
      case Status.canceled:
        return 'Cancelado';
      case Status.preparing:
        return 'Em preparação';
      case Status.transporting:
        return 'Em transporte';
      case Status.delivered:
        return 'Entregue';
      default:
        return '';
    }
  }

  @override
  String toString() {
    return 'Order(orderId: $orderId, items: $items, price: $price, userId: $userId, address: $address, date: $date)';
  }
}
