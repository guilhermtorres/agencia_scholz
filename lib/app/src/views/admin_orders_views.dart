import 'package:agencia_scholz/app/src/components/custom_icon_button_components.dart';
import 'package:agencia_scholz/app/src/components/empty_card_components.dart';
import 'package:agencia_scholz/app/src/components/order_tile_components.dart';
import 'package:agencia_scholz/app/src/models/admin_orders_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminOrdersViews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AdminOrdersManager>(
        builder: (_, ordersManager, __) {
          final filteredOrders = ordersManager.filteredOrders;

          return Column(
            children: [
              if (ordersManager.userFilter != null)
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Pedidos de ${ordersManager.userFilter.name}',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).accentColor),
                        ),
                      ),
                      CustomIconButton(
                        iconData: Icons.close,
                        color: Theme.of(context).accentColor,
                        onTap: () {
                          ordersManager.setUserFilter(null);
                        },
                      )
                    ],
                  ),
                ),
              if (filteredOrders.isEmpty)
                const Expanded(
                  child: EmptyCard(
                    title: 'Nenhuma venda realizada! \n :(',
                    iconData: Icons.add_shopping_cart_sharp,
                  ),
                )
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredOrders.length,
                    itemBuilder: (_, index) {
                      return OrderTile(
                        filteredOrders.reversed.toList()[index],
                        showControls: true,
                      );
                    },
                  ),
                )
            ],
          );
        },
      ),
    );
  }
}
