import 'package:agencia_scholz/app/src/views/products_views.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {
  final DocumentSnapshot snapshot;
  CategoryTile(this.snapshot);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.2,
      child: ListTile(
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
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ProductView(snapshot),
            ),
          );
        },
      ),
    );
  }
}
