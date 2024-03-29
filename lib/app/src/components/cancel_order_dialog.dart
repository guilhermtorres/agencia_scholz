import 'package:agencia_scholz/app/src/data/order_data.dart';
import 'package:flutter/material.dart';

class CancelOrderDialog extends StatelessWidget {
  const CancelOrderDialog(this.order);

  final Order order;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Cancelar ${order.formattedId}?'),
      content: const Text('Esta ação não poderá ser desfeita!'),
      actions: [
        FlatButton(
          onPressed: () {
            order.cancel();
            Navigator.of(context).pop();
          },
          textColor: Colors.red,
          child: const Text(
            'Cancelar Pedido',
          ),
        )
      ],
    );
  }
}
