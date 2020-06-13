import 'package:agencia_scholz/app/src/views/create_login_views.dart';
import 'package:flutter/material.dart';

class LoginViews extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Text(
            'Entrar',
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => CreateLoginViews(),
                ),
              );
            },
            child: Text(
              'Criar conta',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ],
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
                      hintText: '   E-mail',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (text) {
                      if (text.isEmpty || !text.contains('@')) return 'E-mail inválido!';
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
                    obscureText: true,
                    validator: (text) {
                      if (text.isEmpty || text.length < 6) return 'Senha Inválida!';
                    },
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: FlatButton(
                  onPressed: () {},
                  child: Text(
                    'Esqueci minha senha',
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  padding: EdgeInsets.zero,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 45,
                child: RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {}
                  },
                  child: Text(
                    'Entrar',
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
