import 'package:agencia_scholz/app/src/models/user_manager_model.dart';
import 'package:agencia_scholz/app/src/models/user_model.dart';
import 'package:agencia_scholz/app/src/utils/validators_utils.dart';
import 'package:agencia_scholz/app/src/views/create_login_views.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginViews extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
        key: formKey,
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
                    controller: emailController,
                    autocorrect: false,
                    decoration: InputDecoration(
                      hintText: '   E-mail',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (email) {
                      if (!emailValid(email)) return 'E-mail inválido!';
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
                    controller: passController,
                    decoration: InputDecoration(
                      hintText: '   Senha',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    obscureText: true,
                    validator: (pass) {
                      if (pass.isEmpty || pass.length < 6) return 'Senha Inválida!';
                      return null;
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
                    if (formKey.currentState.validate()) {
                      context.read<UserManager>().signIn(
                          user: User(
                            email: emailController.text,
                            password: passController.text,
                          ),
                          onFail: (e) {
                            print(e);
                          });
                    }
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
