import 'package:agencia_scholz/app/src/components/adress_card_components.dart';
import 'package:agencia_scholz/app/src/components/price_card_components.dart';
import 'package:agencia_scholz/app/src/models/cart_product_manager_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdressView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Entrega'),
      ),
      body: ListView(
        children: <Widget>[
          AdressCard(),
          const SizedBox(
            height: 25,
          ),
          Consumer<CartManager>(builder: (_, cartManager, __) {
            return PriceCard(
              buttonText: 'Continuar para o Pagamento',
              onPressed: cartManager.isAdressValid ? () {} : null,
            );
          })
        ],
      ),
    );
  }
}
