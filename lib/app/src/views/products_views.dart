import 'package:agencia_scholz/app/src/components/custom_drawer_components.dart';
import 'package:agencia_scholz/app/src/components/product_tile_components.dart';
import 'package:agencia_scholz/app/src/data/product_data.dart';
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
          title: Text(
            snapshot.data['title'] as String,
          ),
          centerTitle: true,
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
                      productManager.allProducts[index],
                    );
                  },
                  itemCount: productManager.allProducts.length,
                ),
                ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: productManager.allProducts.length,
                  itemBuilder: (context, index) {
                    return ProductTile(
                      'list',
                      productManager.allProducts[index],
                    );
                  },
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
