import 'package:agencia_scholz/app/src/data/product_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductManager extends ChangeNotifier {
  ProductManager() {
    loadAllProducts();
  }

  final Firestore firestore = Firestore.instance;

  List<ProductData> allProducts = [];

  String _search = '';
  String get search => _search;

  set search(String value) {
    _search = value;
    notifyListeners();
  }

  List<ProductData> get filteredProducts {
    final List<ProductData> filteredProducts = [];

    if (search.isEmpty) {
      filteredProducts.addAll(allProducts);
    } else {
      filteredProducts.addAll(allProducts.where((p) => p.title.toLowerCase().contains(search.toLowerCase())));
    }
    return filteredProducts;
  }

  Future<void> loadAllProducts() async {
    final QuerySnapshot snapProducts = await firestore.collection('sellerprod').getDocuments();

    allProducts = snapProducts.documents.map((d) => ProductData.fromDocument(d)).toList();

    notifyListeners();
  }

  ProductData findProductById(String id) {
    try {
      return allProducts.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }
}
