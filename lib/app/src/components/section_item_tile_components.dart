import 'dart:io';
import 'package:agencia_scholz/app/src/data/product_data.dart';
import 'package:agencia_scholz/app/src/data/section_data.dart';
import 'package:agencia_scholz/app/src/data/section_item_data.dart';
import 'package:agencia_scholz/app/src/models/home_manager_model.dart';
import 'package:agencia_scholz/app/src/models/product_manager_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class ItemTile extends StatelessWidget {
  const ItemTile(this.item);

  final SectionItem item;

  @override
  Widget build(BuildContext context) {
    final homeManager = context.watch<HomeManager>();

    return InkWell(
      onTap: () {
        if (item.product != null) {
          final product = context.read<ProductManager>().findProductById(item.product);
          if (product != null) {
            Navigator.of(context).pushNamed('/product', arguments: product);
          }
        }
      },
      onLongPress: homeManager.editing
          ? () {
              showDialog(
                context: context,
                builder: (_) {
                  final product = context.read<ProductManager>().findProductById(item.product);
                  return AlertDialog(
                    content: product != null
                        ? ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Image.network(product.images.first as String),
                            title: Text(
                              product.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                            subtitle: Text(
                              'R\$ ${product.basePrice.toStringAsFixed(2)}',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          )
                        : null,
                    title: Text(
                      'Editar Item',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () {
                          context.read<Section>().removeItem(item);
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Excluir',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                      FlatButton(
                          onPressed: () async {
                            if (product != null) {
                              item.product = null;
                            } else {
                              final ProductData product = await Navigator.of(context).pushNamed('/select_product') as ProductData;
                              item.product = product?.id;
                            }
                            Navigator.of(context).pop();
                          },
                          child: product != null
                              ? Text(
                                  'Desvincular ao produto',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                )
                              : Text(
                                  'Vincular a um produto',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).accentColor,
                                  ),
                                )),
                    ],
                  );
                },
              );
            }
          : null,
      child: AspectRatio(
        aspectRatio: 1,
        child: item.image is String
            ? FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: item.image as String,
                fit: BoxFit.cover,
              )
            : Image.file(
                item.image as File,
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
