import 'package:agencia_scholz/app/src/components/cep_input_field_components.dart';
import 'package:flutter/material.dart';

class AdressCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Endereço de Entrega',
                textAlign: TextAlign.start,
                style: TextStyle(color: Theme.of(context).accentColor, fontWeight: FontWeight.bold, fontSize: 18),
              ),
              CepInputField(),
            ],
          ),
        ),
      ),
    );
  }
}
