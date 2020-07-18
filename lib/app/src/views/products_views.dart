import 'package:agencia_scholz/app/src/components/product_tile_components.dart';
import 'package:agencia_scholz/app/src/components/search_dialog_components.dart';
import 'package:agencia_scholz/app/src/models/product_manager_model.dart';
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
              return Text(
                snapshot.data['title'] as String,
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
                    icon: Icon(Icons.search),
                    onPressed: () async {
                      final search = await showDialog<String>(context: context, builder: (_) => SearchDialog(productManager.search));
                      if (search != null) {
                        productManager.search = search;
                      }
                    },
                  );
                } else {
                  return IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () async {
                      productManager.search = '';
                    },
                  );
                }
              },
            )
          ],
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(
                  Icons.grid_on,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.list,
                ),
              ),
            ],
            indicatorColor: Theme.of(context).accentColor,
          ),
        ),
        body: Consumer<ProductManager>(
          builder: (_, productManager, __) {
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
          child: Icon(Icons.shopping_cart),
        ),
      ),
    );
  }
}
