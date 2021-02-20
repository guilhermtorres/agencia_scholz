import 'package:agencia_scholz/app/src/components/custom_drawer_components.dart';
import 'package:agencia_scholz/app/src/components/product_tile_components.dart';
import 'package:agencia_scholz/app/src/components/search_dialog_components.dart';
import 'package:agencia_scholz/app/src/models/product_manager_model.dart';
import 'package:agencia_scholz/app/src/models/user_manager_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductView extends StatelessWidget {
  final DocumentSnapshot snapshot;

  const ProductView(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Consumer<ProductManager>(builder: (_, productManager, __) {
            if (productManager.search.isEmpty) {
              return const Text(
                'Produtos',
              );
            } else {
              return LayoutBuilder(builder: (_, constraints) {
                return GestureDetector(
                  onTap: () async {
                    final search = await showDialog<String>(context: context, builder: (_) => SearchDialog(productManager.search));
                    if (search != null) {
                      productManager.search = search;
                    }
                  },
                  child: Container(
                    width: constraints.biggest.width,
                    child: Text(
                      productManager.search,
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              });
            }
          }),
          centerTitle: true,
          actions: <Widget>[
            Consumer<ProductManager>(
              builder: (_, productManager, __) {
                if (productManager.search.isEmpty) {
                  return IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () async {
                      final search = await showDialog<String>(context: context, builder: (_) => SearchDialog(productManager.search));
                      if (search != null) {
                        productManager.search = search;
                      }
                    },
                  );
                } else {
                  return IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () async {
                      productManager.search = '';
                    },
                  );
                }
              },
            ),
            Consumer<UserManager>(
              builder: (_, userManager, __) {
                if (userManager.adminEnabled) {
                  return IconButton(
                    icon: const Icon(
                      Icons.add,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed(
                        '/edit_product',
                      );
                    },
                  );
                } else {
                  return Container();
                }
              },
            )
          ],
          bottom: TabBar(
            // ignore: prefer_const_literals_to_create_immutables
            tabs: <Widget>[
              const Tab(
                icon: Icon(
                  Icons.grid_on,
                ),
              ),
              const Tab(
                icon: Icon(
                  Icons.list,
                ),
              ),
            ],
            indicatorColor: Theme.of(context).accentColor,
          ),
        ),
        drawer: const CustomDrawer(),
        body: Consumer<ProductManager>(
          builder: (_, productManager, __) {
            // ignore: unused_local_variable
            final filteredProducts = productManager.filteredProducts;
            return TabBarView(
              children: [
                GridView.builder(
                  padding: const EdgeInsets.all(10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    childAspectRatio: 0.65,
                  ),
                  itemBuilder: (context, index) {
                    return ProductTile(
                      'grid',
                      productManager.filteredProducts[index],
                    );
                  },
                  itemCount: productManager.filteredProducts.length,
                ),
                ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: productManager.filteredProducts.length,
                  itemBuilder: (context, index) {
                    return ProductTile(
                      'list',
                      productManager.filteredProducts[index],
                    );
                  },
                )
              ],
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
          onPressed: () {
            Navigator.of(context).pushNamed('/cart');
          },
          child: const Icon(Icons.shopping_cart),
        ),
      ),
    );
  }
}
