import 'package:agencia_scholz/app/src/components/order_product_tile_components.dart';
import 'package:agencia_scholz/app/src/data/order_data.dart';
import 'package:flutter/material.dart';

class ConfirmationViews extends StatelessWidget {
  const ConfirmationViews(this.order);

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          child: Text(
            'Pedido ${order.formattedId} Confirmado! :)',
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(16),
          child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.formattedId,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                    Text(
                      'R\$ ${order.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: order.items.map((e) {
                  return OrderProductTile(e);
                }).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
