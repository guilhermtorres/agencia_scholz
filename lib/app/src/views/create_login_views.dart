import 'package:flutter/material.dart';

class CreateLoginViews extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Text(
            'Criar Conta',
          ),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(left: 40, top: 40, right: 40),
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Container(
                child: Image.asset(
                  'assets/images/Logotipo-4.png',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: TextFormField(
                    autocorrect: false,
                    decoration: InputDecoration(
                      hintText: '   Nome Completo',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    validator: (text) {
                      if (text.isEmpty) return 'Nome inválido!';
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: TextFormField(
                    autocorrect: false,
                    decoration: InputDecoration(
                      hintText: '   Endereço',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    validator: (text) {
                      if (text.isEmpty) return 'Endereço inválido!';
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: TextFormField(
                    autocorrect: false,
                    decoration: InputDecoration(
                      hintText: '   E-mail',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (text) {
                      if (text.isEmpty || !text.contains('@')) return 'E-mail inválido!';
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: '   Senha',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    validator: (text) {
                      if (text.isEmpty || text.length < 6) return 'Senha Inválida!';
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 45,
                child: RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {}
                  },
                  child: Text(
                    'Cadastrar Conta',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
