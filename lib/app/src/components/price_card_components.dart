import 'package:agencia_scholz/app/src/models/cart_product_manager_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class PriceCard extends StatelessWidget {
  const PriceCard({this.buttonText, this.onPressed, this.showControls = false});
  final String buttonText;
  final bool showControls;

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final cartManager = context.watch<CartManager>();
    final productsPrice = cartManager.productsPrice;
    final deliveryPrice = cartManager.deliveryPrice;
    final totalPrice = cartManager.totalPrice;
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'Resumo do Pedido',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  'Subtotal',
                ),
                Text('R\$ ${productsPrice.toStringAsFixed(2)}')
              ],
            ),
            const Divider(),
            const SizedBox(
              height: 12,
            ),
            if (deliveryPrice != null) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    'Valor da Entrega',
                  ),
                  Text('R\$ ${deliveryPrice.toStringAsFixed(2)}')
                ],
              ),
              const Divider(),
            ],
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  'Total',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  'R\$ ${totalPrice.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              height: 45,
              child: RaisedButton(
                disabledColor: Theme.of(context).accentColor.withAlpha(100),
                disabledTextColor: Colors.grey[200],
                textColor: Colors.white,
                onPressed: onPressed,
                child: Text(
                  buttonText,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            if (showControls)
              const SizedBox(
                height: 10,
              ),
            if (showControls)
              SizedBox(
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
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
