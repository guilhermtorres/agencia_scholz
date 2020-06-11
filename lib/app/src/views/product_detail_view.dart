import 'package:agencia_scholz/app/src/data/product_data.dart';
import 'package:flutter/material.dart';

class ProductDetailView extends StatefulWidget {
  final ProductData product;
  ProductDetailView(this.product);

  @override
  _ProductDetailViewState createState() => _ProductDetailViewState(product);
}

class _ProductDetailViewState extends State<ProductDetailView> {
  final ProductData product;
  _ProductDetailViewState(this.product);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Text(
            product.title,
          ),
        ),
        centerTitle: true,
      ),
    );
  }
}
