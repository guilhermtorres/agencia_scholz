import 'package:agencia_scholz/app/src/models/item_size_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ProductData extends ChangeNotifier {
  String category;
  String id;

  String title;
  String description;

  double price;

  List images;
  List type;
  List<ItemSize> sizes;

  ItemSize _selectedSize;
  ItemSize get selectedSize => _selectedSize;

  set selectedSize(ItemSize value) {
    _selectedSize = value;
    notifyListeners();
  }

  ProductData.fromDocument(DocumentSnapshot snapshot) {
    id = snapshot.documentID;
    title = snapshot.data['name'] as String;
    description = snapshot.data['description'] as String;
    price = snapshot.data['price'] as double;
    images = snapshot.data['images'] as List<dynamic>;
    type = snapshot.data['type'] as List<dynamic>;
    sizes = (snapshot.data['sizes'] as List<dynamic> ?? []).map((s) => ItemSize.fromMap(s as Map<String, dynamic>)).toList();
  }
  int get totalStock {
    int stock = 0;
    for (final size in sizes) {
      stock += size.stock;
    }
    return stock;
  }

  bool get hasStock {
    return totalStock > 0;
  }
}
