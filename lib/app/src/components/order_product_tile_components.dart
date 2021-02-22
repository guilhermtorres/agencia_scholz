import 'package:agencia_scholz/app/src/data/cart_product_data.dart';
import 'package:flutter/material.dart';

class OrderProductTile extends StatelessWidget {
  const OrderProductTile(this.cartProduct);

  final CartProduct cartProduct;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed('/product', arguments: cartProduct.product);
        },
        child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                SizedBox(
                  height: 60,
                  width: 60,
                  child: Image.network(
                    cartProduct.product.images.first,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cartProduct.product.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      Text(
                        cartProduct.size,
                        style: const TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      Text(
                        'R\$ ${(cartProduct.fixedPrice ?? cartProduct.unitPrice).toStringAsFixed(2)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).accentColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '${cartProduct.quantity}',
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            )));
  }
}
