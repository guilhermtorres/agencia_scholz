import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData {
  String category;
  String id;

  String title;
  String description;

  double price;

  List images;
  List type;

  ProductData.fromDocument(DocumentSnapshot snapshot) {
    id = snapshot.documentID;
    title = snapshot.data['title'] as String;
    description = snapshot.data['description'] as String;
    price = snapshot.data['price'] as double;
    images = snapshot.data['images'] as List<dynamic>;
    type = snapshot.data['type'] as List<dynamic>;
  }
}
