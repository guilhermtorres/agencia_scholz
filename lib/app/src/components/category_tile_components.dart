import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {
  final DocumentSnapshot snapshot;
  CategoryTile(this.snapshot);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(10),
      leading: Container(
        child: Card(
          elevation: 5,
          child: Image.network(
            snapshot.data['icon'],
            scale: 5,
          ),
        ),
      ),
      title: Text(
        snapshot.data['title'],
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: Icon(
        Icons.keyboard_arrow_right,
        color: Theme.of(context).accentColor,
      ),
      onTap: () {},
    );
  }
}
