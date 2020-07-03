import 'package:agencia_scholz/app/src/data/product_data.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

class ProductDetailView extends StatefulWidget {
  final ProductData product;
  const ProductDetailView(this.product);

  @override
  // ignore: no_logic_in_create_state
  _ProductDetailViewState createState() => _ProductDetailViewState(product);
}

class _ProductDetailViewState extends State<ProductDetailView> {
  final ProductData product;
  String type;
  _ProductDetailViewState(this.product);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          product.title,
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 0.9,
            child: Carousel(
              images: product.images.map((url) {
                return NetworkImage(url as String);
              }).toList(),
              dotSize: 5,
              dotSpacing: 15,
              dotBgColor: Colors.transparent,
              dotIncreasedColor: Theme.of(context).primaryColor,
              dotColor: Theme.of(context).accentColor,
              autoplay: false,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  product.title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 3,
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  'A Partir de',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[400],
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'R\$ ${product.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.red,
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 3,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Qual setor você atua?',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 120,
                  child: GridView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      childAspectRatio: 0.5,
                    ),
                    children: product.type.map((typ) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            type = typ as String;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: typ == type ? Theme.of(context).primaryColor : Colors.transparent,
                            borderRadius: const BorderRadius.all(Radius.circular(4)),
                            border: Border.all(
                              color: Theme.of(context).primaryColor,
                              width: 2,
                            ),
                          ),
                          width: 100,
                          alignment: Alignment.center,
                          child: Text(
                            typ as String,
                            style: TextStyle(
                              color: typ == type ? Colors.white : Colors.black,
                              fontWeight: typ == type ? FontWeight.bold : FontWeight.w600,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 45,
                  child: RaisedButton(
                    onPressed: type != null ? () {} : null,
                    child: Text(
                      'Adicionar ao Carrinho',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'O que inclui nosso serviço?',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  product.description,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
