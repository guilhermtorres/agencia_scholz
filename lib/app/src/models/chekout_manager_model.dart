import 'package:agencia_scholz/app/src/data/product_data.dart';
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

  void checkout({Function onStockFail}) async {
    try {
      await _decrementStock();
    } catch (e) {
      onStockFail(e);
      debugPrint(e.toString());
    }
    _getOrderId().then((value) => print(value));
  }

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

  Future<void> _decrementStock() {
// 1. Ler todos os estoques
// 2. decremento localmente os estoques
// 3. salvar os estoques no firebase

    return firestore.runTransaction((tx) async {
      final List<ProductData> productsToUpdate = [];
      final List<ProductData> productsWithouStock = [];

      for (final cartProduct in cartManager.items) {
        ProductData product;
        if (productsToUpdate.any((p) => p.id == cartProduct.productId)) {
          product = productsToUpdate.firstWhere((p) => p.id == cartProduct.productId);
        } else {
          final doc = await tx.get(firestore.document('products/${cartProduct.productId}'));
          product = ProductData.fromDocument(doc);
        }

        cartProduct.product = product;

        final size = product.findSize(cartProduct.size);
        if (size.stock - cartProduct.quantity < 0) {
          productsWithouStock.add(product);
          // FALHAR
        } else {
          size.stock -= cartProduct.quantity;
          productsToUpdate.add(product);
        }
      }
      if (productsWithouStock.isNotEmpty) {
        return Future.error('${productsWithouStock.length} produto(s) sem estoque! :(');
      }

      for (final product in productsToUpdate) {
        tx.update(
          firestore.document(
            'products/${product.id}',
          ),
          {'sizes': product.exportSizeList()},
        );
      }
    });
  }
}
