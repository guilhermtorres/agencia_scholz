import 'package:agencia_scholz/app/src/components/cart_tile_components.dart';
import 'package:agencia_scholz/app/src/models/cart_product_manager_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Carrinho',
        ),
        centerTitle: true,
      ),
      body: Consumer<CartManager>(builder: (_, cartManager, __) {
        return Column(
          children: cartManager.items.map((cartProduct) => CartTile(cartProduct)).toList(),
        );
      }),
    );
  }
}
