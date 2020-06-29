import 'package:agencia_scholz/app/src/models/user_manager_model.dart';
import 'package:agencia_scholz/app/src/models/user_model.dart';
import 'package:agencia_scholz/app/src/utils/validators_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginViews extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Container(
          child: const Text(
            'Entrar',
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/create_login_views');
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
        child: Consumer<UserManager>(builder: (_, userManager, __) {
          return ListView(
            padding: const EdgeInsets.only(left: 20, top: 40, right: 20),
            shrinkWrap: true,
            children: <Widget>[
              const SizedBox(
                height: 50,
              ),
              Container(
                child: Image.asset(
                  'assets/images/Logotipo-4.png',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: TextFormField(
                    controller: emailController,
                    enabled: !userManager.loading,
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
              const SizedBox(
                height: 20,
              ),
              Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: TextFormField(
                    controller: passController,
                    enabled: !userManager.loading,
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
                  padding: EdgeInsets.zero,
                  child: Text(
                    'Esqueci minha senha',
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 45,
                child: RaisedButton(
                  onPressed: userManager.loading
                      ? null
                      : () {
                          if (formKey.currentState.validate()) {
                            userManager.signIn(
                              user: User(
                                email: emailController.text,
                                password: passController.text,
                              ),
                              onFail: (e) {
                                scaffoldKey.currentState.showSnackBar(
                                  SnackBar(
                                    content: Text('Falha ao entrar:  $e '),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              },
                              onSucess: () {
                                debugPrint('sucesso!');
                                //TODO: FECHAR TELA DE LOGIN!
                              },
                            );
                          }
                        },
                  disabledColor: Theme.of(context).accentColor.withAlpha(100),
                  child: userManager.loading
                      ? CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        )
                      : Text(
                          'Entrar',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
