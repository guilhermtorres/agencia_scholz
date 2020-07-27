import 'package:agencia_scholz/app/src/models/item_size_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ProductData extends ChangeNotifier {
  ProductData({this.id, this.title, this.category, this.description, this.images, this.sizes, this.type}) {
    images = images ?? [];
    sizes = sizes ?? [];
  }
  String category;
  String id;

  String title;
  String description;

  double price;

  List images;
  List type;
  List<ItemSize> sizes;

  List<dynamic> newImages;

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

  num get basePrice {
    num lowest = double.infinity;
    for (final size in sizes) {
      if (size.price < lowest && size.hasStock) {
        lowest = size.price;
      }
    }
    return lowest;
  }

  ItemSize findSize(String title) {
    try {
      return sizes.firstWhere((s) => s.name == title);
    } catch (e) {
      return null;
    }
  }

  ProductData clone() {
    return ProductData(
      id: id,
      title: title,
      description: description,
      images: List.from(images),
      sizes: sizes.map((size) => size.clone()).toList(),
    );
  }
}
