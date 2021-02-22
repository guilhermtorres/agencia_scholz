import 'package:agencia_scholz/app/src/data/order_data.dart';
import 'package:agencia_scholz/app/src/data/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class OrdersManager extends ChangeNotifier {
  User user;

  List<Order> orders = [];

  final Firestore firestore = Firestore.instance;

  void updateUser(User user) {
    this.user = user;

    if (user != null) {
      _listenToOrders();
    }
  }

  void _listenToOrders() {
    firestore.collection('orders').where('user', isEqualTo: user.id).snapshots().listen((event) {
      orders.clear();
      for (final doc in event.documents) {
        orders.add(Order.fromDocument(doc));
      }
    });
  }
}
