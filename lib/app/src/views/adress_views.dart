import 'package:agencia_scholz/app/src/components/adress_card_components.dart';
import 'package:flutter/material.dart';

class AdressView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Entrega'),
      ),
      body: ListView(
        children: <Widget>[
          AdressCard(),
        ],
      ),
    );
  }
}
