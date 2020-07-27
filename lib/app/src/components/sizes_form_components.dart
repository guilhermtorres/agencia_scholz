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
        const SizedBox(
          height: 5,
        ),
        FormField<List<ItemSize>>(
          initialValue: product.sizes,
          validator: (sizes) {
            if (sizes.isEmpty) return 'Insira um tamanho';
            return null;
          },
          builder: (state) {
            return Column(
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
                      onTap: () {
                        state.value.add(ItemSize());
                        state.didChange(state.value);
                      },
                    ),
                  ],
                ),
                Column(
                  children: state.value.map((size) {
                    return EditItemSize(
                      key: ObjectKey(size),
                      size: size,
                      onRemove: () {
                        state.value.remove(size);
                        state.didChange(state.value);
                      },
                      onMoveUp: size != state.value.first
                          ? () {
                              final index = state.value.indexOf(size);
                              state.value.remove(size);
                              state.value.insert(index - 1, size);
                              state.didChange(state.value);
                            }
                          : null,
                      onMoveDown: size != state.value.last
                          ? () {
                              final index = state.value.indexOf(size);
                              state.value.remove(size);
                              state.value.insert(index + 1, size);
                              state.didChange(state.value);
                            }
                          : null,
                    );
                  }).toList(),
                ),
                if (state.hasError)
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      state.errorText,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  )
              ],
            );
          },
        ),
      ],
    );
  }
}
