import 'package:agencia_scholz/app/src/data/product_data.dart';
import 'package:agencia_scholz/app/src/models/item_size_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CartProduct {
  CartProduct.fromProduct(this.product) {
    productId = product.id;
    quantity = 1;
    size = product.selectedSize.name;
  }

  CartProduct.fromDocument(DocumentSnapshot document) {
    productId = document.data['pid'] as String;
    quantity = document.data['quantity'] as int;
    size = document.data['size'] as String;

    firestore.document('sellerprod/$productId').get().then((doc) => product = ProductData.fromDocument(doc));
  }

  final Firestore firestore = Firestore.instance;

  String productId;
  int quantity;
  String size;

  ProductData product;

  ItemSize get itemSize {
    if (product == null) return null;
    return product.findSize(size);
  }

  num get unitPrice {
    if (product == null) return 0;
    return itemSize?.price ?? 0;
  }
}
