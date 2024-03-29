import 'package:agencia_scholz/app/src/components/empty_card_components.dart';
import 'package:agencia_scholz/app/src/components/login_card_components.dart';
import 'package:agencia_scholz/app/src/components/order_tile_components.dart';
import 'package:agencia_scholz/app/src/models/orders_manager_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersViews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<OrdersManager>(
      builder: (_, ordersManager, __) {
        if (ordersManager.user == null) {
          return LoginCard();
        }
        if (ordersManager.orders.isEmpty) {
          return const EmptyCard(
            title: 'Nenhum pedido encontrado! \n :(',
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
