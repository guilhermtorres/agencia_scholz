import 'package:agencia_scholz/app/src/models/cart_product_manager_model.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class CepInputField extends StatelessWidget {
  final TextEditingController cepController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: cepController,
          decoration: InputDecoration(
            isDense: true,
            labelText: 'CEP',
            hintText: 'Insira aqui seu CEP ex:22.755-200',
            hintStyle: TextStyle(
              color: Colors.black,
              fontStyle: FontStyle.italic,
            ),
            border: InputBorder.none,
          ),
          inputFormatters: [
            WhitelistingTextInputFormatter.digitsOnly,
            CepInputFormatter(),
          ],
          keyboardType: TextInputType.number,
          validator: (cep) {
            if (cep.isEmpty) {
              return 'Campo Obrigatório';
            } else if (cep.length != 10) return 'CEP Inválido';
            return null;
          },
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 45,
          child: RaisedButton(
            disabledColor: Theme.of(context).accentColor.withAlpha(100),
            onPressed: () {
              if (Form.of(context).validate()) {
                context.read<CartManager>().getAddress(cepController.text);
              }
            },
            child: Text(
              'Buscar CEP',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        )
      ],
    );
  }
}
