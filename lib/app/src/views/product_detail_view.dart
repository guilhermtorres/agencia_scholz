import 'package:agencia_scholz/app/src/data/product_data.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

class ProductDetailView extends StatefulWidget {
  final ProductData product;
  ProductDetailView(this.product);

  @override
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
        title: Container(
          child: Text(
            product.title,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 0.9,
            child: Carousel(
              images: product.images.map((url) {
                return NetworkImage(url);
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
            padding: EdgeInsets.all(16),
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
                Text(
                  'R\$ ${product.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.red,
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 3,
                ),
                SizedBox(
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
                    children: product.type.map((typ) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            type = typ;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: typ == type ? Theme.of(context).primaryColor : Colors.transparent,
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            border: Border.all(
                              color: Theme.of(context).primaryColor,
                              width: 2,
                            ),
                          ),
                          width: 100,
                          alignment: Alignment.center,
                          child: Text(
                            typ,
                            style: TextStyle(
                              color: typ == type ? Colors.white : Colors.black,
                              fontWeight: typ == type ? FontWeight.bold : FontWeight.w600,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(vertical: 4),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      childAspectRatio: 0.5,
                    ),
                  ),
                ),
                SizedBox(
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
                SizedBox(
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
                SizedBox(
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
