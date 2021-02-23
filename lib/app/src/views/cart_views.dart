import 'package:agencia_scholz/app/src/components/cart_tile_components.dart';
import 'package:agencia_scholz/app/src/components/empty_card_components.dart';
import 'package:agencia_scholz/app/src/components/login_card_components.dart';
import 'package:agencia_scholz/app/src/components/price_card_components.dart';
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
      body: Consumer<CartManager>(
        builder: (_, cartManager, __) {
          if (cartManager.user == null) {
            return LoginCard();
          }

          if (cartManager.items.isEmpty) {
            return const EmptyCard(
              iconData: Icons.remove_shopping_cart,
              title: 'Nenhum produto no carrinho!\n :(',
            );
          }

          return ListView(
            children: <Widget>[
              Column(
                children: cartManager.items.map((cartProduct) => CartTile(cartProduct)).toList(),
              ),
              const SizedBox(
                height: 25,
              ),
              PriceCard(
                showControls: true,
                buttonText: 'Continuar para Entrega',
                onPressed: cartManager.isCartValid
                    ? () {
                        Navigator.of(context).pushNamed('/adress');
                      }
                    : null,
              ),
            ],
          );
        },
      ),
    );
  }
}
