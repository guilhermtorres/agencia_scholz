import 'package:agencia_scholz/app/src/components/size_widget_components.dart';
import 'package:agencia_scholz/app/src/data/product_data.dart';
import 'package:agencia_scholz/app/src/models/cart_product_manager_model.dart';
import 'package:agencia_scholz/app/src/models/user_manager_model.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailView extends StatefulWidget {
  final Product product;
  const ProductDetailView(this.product);

  @override
  // ignore: no_logic_in_create_state
  _ProductDetailViewState createState() => _ProductDetailViewState(product);
}

class _ProductDetailViewState extends State<ProductDetailView> {
  final Product product;
  String type;
  _ProductDetailViewState(this.product);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: product,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            product.name,
          ),
          centerTitle: true,
          actions: <Widget>[
            Consumer<UserManager>(
              builder: (_, userManager, __) {
                if (userManager.adminEnabled) {
                  return IconButton(
                    icon: const Icon(
                      Icons.edit,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed(
                        '/edit_product',
                        arguments: product,
                      );
                    },
                  );
                } else {
                  return Container();
                }
              },
            )
          ],
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
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    product.name,
                    style: const TextStyle(
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
                    'R\$ ${product.basePrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 28,
                      color: Colors.red,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Qual setor você atua?',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: product.sizes.map(
                      (s) {
                        return SizeWidget(
                          size: s,
                        );
                      },
                    ).toList(),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  if (product.hasStock)
                    Consumer2<UserManager, Product>(builder: (_, userManager, product, __) {
                      return SizedBox(
                        height: 45,
                        child: RaisedButton(
                          onPressed: product.selectedSize != null
                              ? () {
                                  if (userManager.isLoggedIn) {
                                    context.read<CartManager>().addToCart(product);
                                    Navigator.of(context).pushNamed('/cart');
                                  } else {
                                    Navigator.of(context).pushNamed('/login');
                                  }
                                }
                              : null,
                          child: Text(
                            userManager.isLoggedIn ? 'Adicionar ao Carrinho' : 'Entre para Comprar',
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    }),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
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
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
