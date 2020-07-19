import 'package:agencia_scholz/app/src/data/section_item_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Section {
  Section.fromDocument(DocumentSnapshot document) {
    name = document.data['name'] as String;
    type = document.data['type'] as String;
    items = (document.data['items'] as List).map((i) => SectionItem.fromMap(i as Map<String, dynamic>)).toList();
  }

  String name;
  String type;
  List<SectionItem> items;
}
