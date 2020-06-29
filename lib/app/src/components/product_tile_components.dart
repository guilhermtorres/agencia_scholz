import 'package:agencia_scholz/app/src/data/product_data.dart';
import 'package:agencia_scholz/app/src/views/product_detail_view.dart';
import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {
  final String tipo;
  final ProductData product;

  const ProductTile(this.tipo, this.product);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductDetailView(product)));
      },
      child: Card(
        child: tipo == 'grid'
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 0.8,
                    child: Image.network(
                      product.images[0] as String,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.fitHeight,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          children: <Widget>[
                            Text(
                              product.title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'R\$ ${product.price.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).accentColor,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Row(
                children: <Widget>[
                  Flexible(
                    child: Image.network(
                      product.images[0] as String,
                      fit: BoxFit.cover,
                      height: 200,
                    ),
                  ),
                  Flexible(
                    child: FittedBox(
                      fit: BoxFit.fitHeight,
                      child: Container(
                        padding: const EdgeInsets.all(25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  product.title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'R\$ ${product.price.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).accentColor,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
