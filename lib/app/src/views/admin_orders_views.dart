import 'package:agencia_scholz/app/src/components/empty_card_components.dart';
import 'package:agencia_scholz/app/src/components/order_tile_components.dart';
import 'package:agencia_scholz/app/src/models/admin_orders_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminOrdersViews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<AdminOrdersManager>(
      builder: (_, ordersManager, __) {
        if (ordersManager.orders.isEmpty) {
          return const EmptyCard(
            title: 'Nenhuma venda realizada! \n :(',
            iconData: Icons.add_shopping_cart_sharp,
          );
        }
        return ListView.builder(
          itemCount: ordersManager.orders.length,
          itemBuilder: (_, index) {
            return OrderTile(ordersManager.orders.reversed.toList()[index]);
          },
        );
      },
    ));
  }
}
