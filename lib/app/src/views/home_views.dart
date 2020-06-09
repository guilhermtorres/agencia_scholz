import 'package:flutter/material.dart';

class HomeViews extends StatelessWidget {
  const HomeViews({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 5,
        title: Text('Agência Scholz'),
      ),
      body: Center(
        child: Text('App Agência Scholz'),
      ),
    );
  }
}
