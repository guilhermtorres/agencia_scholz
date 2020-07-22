import 'package:agencia_scholz/app/src/components/custom_icon_button_components.dart';
import 'package:agencia_scholz/app/src/components/edit_item_size_components.dart';
import 'package:agencia_scholz/app/src/data/product_data.dart';
import 'package:agencia_scholz/app/src/models/item_size_model.dart';
import 'package:flutter/material.dart';

class SizesForm extends StatelessWidget {
  const SizesForm(this.product);

  final ProductData product;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                'Tamanhos',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            CustomIconButton(
              iconData: Icons.add,
              color: Theme.of(context).accentColor,
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        FormField<List<ItemSize>>(
          initialValue: product.sizes,
          builder: (state) {
            return Column(
              children: state.value.map((size) {
                return EditItemSize(size: size);
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}
