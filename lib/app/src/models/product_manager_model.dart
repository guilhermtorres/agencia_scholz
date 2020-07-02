import 'package:agencia_scholz/app/src/data/product_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductManager extends ChangeNotifier {
  ProductManager() {
    loadAllProducts();
  }

  final Firestore firestore = Firestore.instance;

  List<ProductData> allProducts = [];

  Future<void> loadAllProducts() async {
    final QuerySnapshot snapProducts = await firestore.collection('products').getDocuments();

    // allProducts = snapProducts.documents.map((d) => ProductData.fromDocument(d)).toList();

    notifyListeners();
  }
}
