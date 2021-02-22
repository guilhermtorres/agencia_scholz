import 'package:agencia_scholz/app/src/components/order_product_tile_components.dart';
import 'package:agencia_scholz/app/src/data/order_data.dart';
import 'package:flutter/material.dart';

class OrderTile extends StatelessWidget {
  const OrderTile(this.order);

  final Order order;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(16),
      child: ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
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
                )
              ],
            ),
            Text(
              'Em transporte',
              style: TextStyle(
                color: Theme.of(context).accentColor,
                fontSize: 14,
              ),
            )
          ],
        ),
        children: [
          Column(
            children: order.items.map((e) {
              return OrderProductTile(e);
            }).toList(),
          )
        ],
      ),
    );
  }
}
