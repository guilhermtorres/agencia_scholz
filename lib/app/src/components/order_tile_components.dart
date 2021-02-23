import 'package:agencia_scholz/app/src/components/order_product_tile_components.dart';
import 'package:agencia_scholz/app/src/data/order_data.dart';
import 'package:flutter/material.dart';

class OrderTile extends StatelessWidget {
  const OrderTile(this.order, {this.showControls = false});

  final Order order;
  final bool showControls;
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
              order.statusText,
              style: TextStyle(
                color: order.status == Status.canceled ? Colors.red : Theme.of(context).accentColor,
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
          ),
          if (showControls && order.status != Status.canceled)
            SizedBox(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  RaisedButton(
                    onPressed: () {},
                    textColor: Colors.white,
                    color: Colors.red,
                    child: const Text('Cancelar'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  RaisedButton(
                    onPressed: order.back,
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                    child: const Text('Recuar Pedido'),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  RaisedButton(
                    onPressed: order.advance,
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                    child: const Text('Avançar Pedido'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  RaisedButton(
                    onPressed: () {},
                    textColor: Colors.white,
                    color: Theme.of(context).accentColor,
                    child: const Text('Endereço do cliente'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
