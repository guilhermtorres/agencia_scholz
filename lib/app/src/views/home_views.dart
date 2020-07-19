import 'package:agencia_scholz/app/src/components/custom_drawer_components.dart';
import 'package:agencia_scholz/app/src/models/page_manager_model.dart';
import 'package:agencia_scholz/app/src/models/user_manager_model.dart';
import 'package:agencia_scholz/app/src/views/admin_users_views.dart';
import 'package:agencia_scholz/app/src/views/initial_tab_views.dart';
import 'package:agencia_scholz/app/src/views/products_tab_views.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeViews extends StatelessWidget {
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(_pageController),
      child: Consumer<UserManager>(
        builder: (_, userManager, __) {
          return PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: <Widget>[
              Scaffold(
                body: HomeTab(),
                drawer: const CustomDrawer(),
              ),
              Scaffold(
                appBar: AppBar(
                  title: const Text(
                    'Produtos e Serviços',
                  ),
                  centerTitle: true,
                ),
                drawer: const CustomDrawer(),
                body: ProductsTab(),
              ),
              Scaffold(
                appBar: AppBar(
                  title: const Text(
                    'Meus Pedidos',
                  ),
                  centerTitle: true,
                ),
                drawer: const CustomDrawer(),
                body: Container(),
              ),
              Scaffold(
                appBar: AppBar(
                  title: const Text(
                    'Onde Estamos',
                  ),
                  centerTitle: true,
                ),
                drawer: const CustomDrawer(),
                body: Container(),
              ),
              if (userManager.adminEnabled) ...[
                AdminUsersViews(),
                Scaffold(
                  appBar: AppBar(
                    title: const Text(
                      'Pedidos',
                    ),
                    centerTitle: true,
                  ),
                  drawer: const CustomDrawer(),
                  body: Container(),
                ),
              ]
            ],
          );
        },
      ),
    );
  }
}
