import 'package:agencia_scholz/app/src/components/images_form_components.dart';
import 'package:agencia_scholz/app/src/components/sizes_form_components.dart';
import 'package:agencia_scholz/app/src/data/product_data.dart';
import 'package:flutter/material.dart';

class EditProductView extends StatelessWidget {
  EditProductView(ProductData p)
      : editing = p != null,
        product = p != null ? p.clone() : ProductData();

  final ProductData product;
  final bool editing;

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(editing ? 'Editar Produto' : 'Criar Produto'),
        centerTitle: true,
      ),
      body: Form(
        key: formkey,
        child: ListView(
          children: <Widget>[
            ImagesForm(product),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextFormField(
                    validator: (name) {
                      if (name.length < 6) return 'Título muito curto';
                      return null;
                    },
                    onSaved: (title) => product.title = title,
                    initialValue: product.title,
                    decoration: const InputDecoration(
                      hintText: 'Título do Produto',
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      'A partir de',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Text(
                    'R\$ ...',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(
                      'Descrição',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                  TextFormField(
                    initialValue: product.description,
                    style: const TextStyle(fontSize: 16),
                    decoration: const InputDecoration(
                      hintText: 'Descrição',
                      border: InputBorder.none,
                    ),
                    maxLines: null,
                    validator: (desc) {
                      if (desc.length < 10) {
                        return 'Descrição muito curta';
                      }
                      return null;
                    },
                    onSaved: (desc) => product.description = desc,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizesForm(product),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 45,
                    child: RaisedButton(
                      disabledColor: Theme.of(context).accentColor.withAlpha(100),
                      onPressed: () {
                        if (formkey.currentState.validate()) {
                          formkey.currentState.save();
                        }
                      },
                      child: const Text(
                        'Salvar alterações',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
