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
                buttonText: 'Continuar para Entrega',
                onPressed: cartManager.isCartValid
                    ? () {
                        Navigator.of(context).pushNamed('/adress');
                      }
                    : null,
              ),
              Padding(
                padding: const EdgeInsets.all(25),
                child: Card(
                  elevation: 5,
                  child: SizedBox(
                    height: 45,
                    child: RaisedButton(
                      elevation: 8,
                      color: Colors.white,
                      disabledColor: Theme.of(context).accentColor.withAlpha(100),
                      disabledTextColor: Colors.grey[200],
                      textColor: Theme.of(context).accentColor,
                      onPressed: () {
                        Navigator.of(context).popUntil((route) => route.settings.name == '/home_views');
                      },
                      child: const Text(
                        'Continuar comprando...',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
