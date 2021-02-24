import 'package:agencia_scholz/app/src/components/custom_icon_button_components.dart';
import 'package:agencia_scholz/app/src/components/empty_card_components.dart';
import 'package:agencia_scholz/app/src/components/order_tile_components.dart';
import 'package:agencia_scholz/app/src/data/order_data.dart';
import 'package:agencia_scholz/app/src/models/admin_orders_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class AdminOrdersViews extends StatefulWidget {
  @override
  _AdminOrdersViewsState createState() => _AdminOrdersViewsState();
}

class _AdminOrdersViewsState extends State<AdminOrdersViews> {
  final PanelController panelController = PanelController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AdminOrdersManager>(
        builder: (_, ordersManager, __) {
          final filteredOrders = ordersManager.filteredOrders;

          return SlidingUpPanel(
            controller: panelController,
            body: Column(
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
                  ),
                const SizedBox(
                  height: 120,
                ),
              ],
            ),
            minHeight: 40,
            maxHeight: 250,
            panel: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    if (panelController.isPanelClosed) {
                      panelController.open();
                    } else {
                      panelController.close();
                    }
                  },
                  child: Container(
                    color: Colors.white,
                    height: 40,
                    alignment: Alignment.center,
                    child: Text(
                      'Filtros',
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: Status.values.map((s) {
                      return CheckboxListTile(
                        activeColor: Theme.of(context).accentColor,
                        title: Text(Order.getStatusText(s)),
                        dense: true,
                        value: ordersManager.statusFilter.contains(s),
                        onChanged: (v) {
                          ordersManager.setStatusFilter(enabled: v, status: s);
                        },
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
