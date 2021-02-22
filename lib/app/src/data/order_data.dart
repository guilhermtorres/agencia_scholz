import 'package:agencia_scholz/app/src/data/cart_product_data.dart';
import 'package:agencia_scholz/app/src/models/address_model.dart';
import 'package:agencia_scholz/app/src/models/cart_product_manager_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  Order.fromCartManager(CartManager cartManager) {
    items = List.from(cartManager.items);
    price = cartManager.totalPrice;
    userId = cartManager.user.id;
    address = cartManager.address;
  }

  final Firestore firestore = Firestore.instance;

  Future<void> save() async {
    firestore.collection('orders').document(orderId).setData({
      'items': items.map((e) => e.toOrderItemMap()).toList(),
      'price': price,
      'user': userId,
      'address': address.toMap(),
    });
  }

  String orderId;

  List<CartProduct> items;
  num price;

  String userId;

  Address address;

  Timestamp date;
}
