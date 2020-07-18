import 'package:agencia_scholz/app/src/data/cart_product_data.dart';
import 'package:agencia_scholz/app/src/data/product_data.dart';

class CartManager {
  List<CartProduct> items = [];

  void addToCart(ProductData product) {
    items.add(CartProduct.fromProduct(product));
  }
}
