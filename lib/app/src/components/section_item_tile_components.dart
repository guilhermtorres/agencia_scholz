import 'package:agencia_scholz/app/src/data/section_item_data.dart';
import 'package:agencia_scholz/app/src/models/product_manager_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class ItemTile extends StatelessWidget {
  const ItemTile(this.item);

  final SectionItem item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          if (item.product != null) {
            final product = context.read<ProductManager>().findProductById(item.product);
            if (product != null) {
              Navigator.of(context).pushNamed('/product', arguments: product);
            }
          }
        },
        child: FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: item.image,
          fit: BoxFit.cover,
        ));
  }
}
