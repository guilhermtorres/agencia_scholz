import 'dart:io';
import 'package:agencia_scholz/app/src/models/item_size_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class ProductData extends ChangeNotifier {
  ProductData({this.id, this.name, this.description, this.images, this.sizes, this.type}) {
    images = images ?? [];
    sizes = sizes ?? [];
  }

  String id;

  String name;
  String description;

  double price;

  List images = [];
  List type;
  List<ItemSize> sizes;

  List<dynamic> newImages;

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  ItemSize _selectedSize;
  ItemSize get selectedSize => _selectedSize;

  set selectedSize(ItemSize value) {
    _selectedSize = value;
    notifyListeners();
  }

  ProductData.fromDocument(DocumentSnapshot snapshot) {
    id = snapshot.documentID;
    name = snapshot.data['name'] as String;
    description = snapshot.data['description'] as String;
    price = snapshot.data['price'] as double;
    images = snapshot.data['images'] as List<dynamic>;
    sizes = (snapshot.data['sizes'] as List<dynamic> ?? []).map((s) => ItemSize.fromMap(s as Map<String, dynamic>)).toList();
  }

  final Firestore firestore = Firestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  DocumentReference get firestoreRef => firestore.document('sellerprod/$id');
  StorageReference get storageRef => storage.ref().child('icones produtos e serviços').child('items').child('id');

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

  List<Map<String, dynamic>> exportSizeList() {
    return sizes.map((size) => size.toMap()).toList();
  }

  Future<void> save() async {
    loading = true;

    final Map<String, dynamic> data = {
      'name': name,
      'description': description,
      'sizes': exportSizeList(),
    };

    if (id == null) {
      final doc = await firestore.collection('sellerprod').add(data);
      id = doc.documentID;
    } else {
      await firestoreRef.updateData(data);
    }
    final List<String> updateImages = [];

    for (final newImage in newImages) {
      if (images.contains(newImage)) {
        updateImages.add(newImage as String);
      } else {
        final StorageUploadTask task = storageRef.child(Uuid().v1()).putFile(newImage as File);
        final StorageTaskSnapshot snapshot = await task.onComplete;
        final String url = await snapshot.ref.getDownloadURL() as String;
        updateImages.add(url);
      }
    }

    for (final image in images) {
      if (!newImages.contains(image)) {
        try {
          final ref = await storage.getReferenceFromUrl(image as String);
          await ref.delete();
        } catch (e) {
          debugPrint('Falha ao deletar $image');
        }
      }
    }

    await firestoreRef.updateData({'images': updateImages});

    images = updateImages;
    loading = false;
  }

  ProductData clone() {
    return ProductData(
      id: id,
      name: name,
      type: type,
      description: description,
      images: List.from(images),
      sizes: sizes.map((size) => size.clone()).toList(),
    );
  }
}
