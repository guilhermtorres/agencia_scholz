import 'package:agencia_scholz/app/src/components/price_card_components.dart';
import 'package:agencia_scholz/app/src/models/cart_product_manager_model.dart';
import 'package:agencia_scholz/app/src/models/chekout_manager_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<CartManager, CheckoutManager>(
      create: (_) => CheckoutManager(),
      update: (_, cartManager, checkoutManager) => checkoutManager..updateCart(cartManager),
      lazy: false,
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Pagamento'),
            centerTitle: true,
          ),
          body: Consumer(builder: (_, checkoutManager, __) {
            return ListView(
              children: [
                PriceCard(
                  buttonText: 'Finalizar Pedido',
                  onPressed: () {
                    checkoutManager.checkout();
                  },
                )
              ],
            );
          })),
    );
  }
}
