import 'package:agencia_scholz/app/src/models/product_manager_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectProductView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Vincular Produto'),
        ),
        body: Consumer<ProductManager>(
          builder: (_, productManager, __) {
            return ListView.builder(
              itemCount: productManager.allProducts.length,
              itemBuilder: (_, index) {
                final product = productManager.allProducts[index];
                return ListTile(
                  onTap: () {
                    Navigator.of(context).pop(product);
                  },
                  contentPadding: const EdgeInsets.all(20),
                  leading: Image.network(product.images.first as String),
                  title: Text(
                    product.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  subtitle: Text('A Partir de R\$ ${product.basePrice.toStringAsFixed(2)}'),
                );
              },
            );
          },
        ));
  }
}
