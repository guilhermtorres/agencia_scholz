import 'package:agencia_scholz/app/src/models/cart_product_manager_model.dart';
import 'package:flutter/material.dart';

class CheckoutManager extends ChangeNotifier {
  CartManager cartManager;
  // ignore: use_setters_to_change_properties
  void updateCart(CartManager cartManager) {
    this.cartManager = cartManager;
  }
}
