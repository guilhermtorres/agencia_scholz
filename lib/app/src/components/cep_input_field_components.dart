import 'package:agencia_scholz/app/src/components/custom_icon_button_components.dart';
import 'package:agencia_scholz/app/src/models/address_model.dart';
import 'package:agencia_scholz/app/src/models/cart_product_manager_model.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class CepInputField extends StatefulWidget {
  const CepInputField(this.address);
  final Address address;

  @override
  _CepInputFieldState createState() => _CepInputFieldState();
}

class _CepInputFieldState extends State<CepInputField> {
  final TextEditingController cepController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final cartManager = context.watch<CartManager>();

    if (widget.address.zipCode == null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            enabled: !cartManager.loading,
            controller: cepController,
            decoration: const InputDecoration(
              isDense: true,
              labelText: 'CEP',
              hintText: 'Insira aqui seu CEP ex: 22.755-200',
              hintStyle: TextStyle(
                color: Colors.black,
                fontStyle: FontStyle.italic,
              ),
              border: InputBorder.none,
            ),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
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
          if (cartManager.loading)
            LinearProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.greenAccent[400]),
              backgroundColor: Colors.transparent,
            ),
          SizedBox(
            height: 45,
            child: RaisedButton(
              disabledColor: Theme.of(context).accentColor.withAlpha(100),
              onPressed: !cartManager.loading
                  ? () {
                      if (Form.of(context).validate()) {
                        try {
                          context.read<CartManager>().getAddress(cepController.text);
                        } catch (e) {
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text(
                              "$e",
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            backgroundColor: Colors.red,
                          ));
                        }
                      }
                    }
                  : null,
              child: const Text(
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
    } else {
      return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'CEP: ${widget.address.zipCode}',
              style: TextStyle(
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            CustomIconButton(
              iconData: Icons.edit,
              color: Theme.of(context).accentColor,
              onTap: () {
                context.read<CartManager>().removeAddress();
              },
              size: 20,
            )
          ],
        ),
      );
    }
  }
}
