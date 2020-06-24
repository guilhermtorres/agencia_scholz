import 'package:agencia_scholz/app/src/components/custom_drawer_components.dart';
import 'package:agencia_scholz/app/src/models/page_manager_model.dart';
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
      child: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          Scaffold(
            body: HomeTab(),
            drawer: CustomDrawer(_pageController),
          ),
          Scaffold(
            appBar: AppBar(
              title: Container(
                child: Text(
                  'Produtos e Serviços',
                ),
              ),
              centerTitle: true,
            ),
            drawer: CustomDrawer(_pageController),
            body: ProductsTab(),
          ),
          Container(color: Colors.yellow),
          Container(
            color: Colors.blue,
          )
        ],
      ),
    );
  }
}
