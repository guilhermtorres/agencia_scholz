import 'package:agencia_scholz/app/src/components/custom_drawer_components.dart';
import 'package:agencia_scholz/app/src/models/admin_orders_manager.dart';
import 'package:agencia_scholz/app/src/models/admin_users_manager.dart';
import 'package:agencia_scholz/app/src/models/page_manager_model.dart';
import 'package:alphabet_list_scroll_view/alphabet_list_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminUsersViews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text('Usuários'),
        centerTitle: true,
      ),
      body: Consumer<AdminUsersManager>(
        builder: (_, adminUsersManager, __) {
          return AlphabetListScrollView(
            keyboardUsage: true,
            highlightTextStyle: const TextStyle(color: Colors.white, fontSize: 25),
            showPreview: true,
            strList: adminUsersManager.names,
            indexedHeight: (index) => 80,
            itemBuilder: (_, index) {
              return ListTile(
                title: Text(
                  adminUsersManager.users[index].name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  adminUsersManager.users[index].email,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  context.read<AdminOrdersManager>().setUserFilter(adminUsersManager.users[index]);
                  context.read<PageManager>().setPage(5);
                },
              );
            },
          );
        },
      ),
    );
  }
}
