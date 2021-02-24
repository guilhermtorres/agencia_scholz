import 'package:agencia_scholz/app/src/models/address_model.dart';
import 'package:flutter/material.dart';

class ExportAddressDialog extends StatelessWidget {
  const ExportAddressDialog(this.address);

  final Address address;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Endereço de Entrega'),
      content: Text('${address.street}, ${address.number} ${address.complement}\n'
          '${address.district}\n'
          '${address.city}/${address.state}\n'
          '${address.zipCode}'),
      contentPadding: EdgeInsets.all(10),
      actions: [
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).accentColor,
          child: const Text(
            'Exportar para a galeria',
          ),
        )
      ],
    );
  }
}
