import 'package:agencia_scholz/app/src/models/cart_product_manager_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CheckoutManager extends ChangeNotifier {
  CartManager cartManager;
  final Firestore firestore = Firestore.instance;
  // ignore: use_setters_to_change_properties
  void updateCart(CartManager cartManager) {
    this.cartManager = cartManager;
  }

  void checkout() {
    _decrementStock();
    _getOrderId().then((value) => print(value));
  }
// 1. Ler todos os estoques
// 2. decremento localmente os estoques
// 3. salvar os estoques no firebase

  Future<int> _getOrderId() async {
    final ref = firestore.document('aux/ordercounter');

    try {
      final result = await firestore.runTransaction((tx) async {
        final doc = await tx.get(ref);
        final orderId = doc.data['current'] as int;
        await tx.update(ref, {'current': orderId + 1});
        return {'orderId': orderId};
      }, timeout: const Duration(seconds: 10));
      return result['orderId'] as int;
    } catch (e) {
      debugPrint(e.toString());
      return Future.error('Falha ao gerar número do pedido');
    }
  }

  void _decrementStock() {}
}
