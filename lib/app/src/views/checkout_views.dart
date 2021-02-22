import 'package:agencia_scholz/app/src/components/price_card_components.dart';
import 'package:agencia_scholz/app/src/models/cart_product_manager_model.dart';
import 'package:agencia_scholz/app/src/models/chekout_manager_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutView extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<CartManager, CheckoutManager>(
      create: (_) => CheckoutManager(),
      update: (_, cartManager, checkoutManager) => checkoutManager..updateCart(cartManager),
      lazy: false,
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: const Text('Pagamento'),
          centerTitle: true,
        ),
        body: Consumer<CheckoutManager>(
          builder: (_, checkoutManager, __) {
            if (checkoutManager.loading) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.greenAccent[400]),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      'Processando seu pagamento...',
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
              );
            }
            return ListView(
              children: [
                PriceCard(
                  buttonText: 'Finalizar Pedido',
                  onPressed: () {
                    checkoutManager.checkout(
                        onStockFail: (e) {},
                        onSuccess: () {
                          Navigator.of(context).popUntil((route) => route.settings.name == '/home_views');
                        });
                  },
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
