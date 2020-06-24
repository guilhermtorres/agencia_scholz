import 'package:agencia_scholz/app/src/models/user_manager_model.dart';
import 'package:agencia_scholz/app/src/models/user_model.dart';
import 'package:agencia_scholz/app/src/utils/validators_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateLoginViews extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final User user = User();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Container(
          child: const Text(
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
                height: 30,
              ),
              Container(
                child: Image.asset(
                  'assets/images/Logotipo-4.png',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: TextFormField(
                    onSaved: (name) => user.name = name,
                    autocorrect: false,
                    decoration: InputDecoration(
                      hintText: '   Nome Completo',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    validator: (name) {
                      if (name.isEmpty)
                        return 'Campo Obrigatório';
                      else if (name.trim().split(' ').length <= 1) return 'Preencha seu nome completo!';
                      return null;
                    },
                  ),
                ),
              ),
              // SizedBox(
              //   height: 20,
              // ),
              // Card(
              //   elevation: 5,
              //   child: Padding(
              //     padding: const EdgeInsets.only(left: 5),
              //     child: TextFormField(
              //       autocorrect: false,
              //       decoration: InputDecoration(
              //         hintText: '   Endereço',
              //         hintStyle: TextStyle(
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //       validator: (text) {
              //         if (text.isEmpty) return 'Endereço inválido!';
              //         return null;
              //       },
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 20,
              ),
              Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: TextFormField(
                    onSaved: (email) => user.email = email,
                    autocorrect: false,
                    decoration: InputDecoration(
                      hintText: '   E-mail',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (email) {
                      if (email.isEmpty)
                        return 'Campo Obrigatório!';
                      else if (!emailValid(email)) return 'E-mail inválido!';
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
                    onSaved: (pass) => user.password = pass,
                    decoration: InputDecoration(
                      hintText: '   Senha',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    validator: (pass) {
                      if (pass.isEmpty)
                        return 'Campo Obrigatório!';
                      else if (pass.length < 6) return 'Senha muito curta!';
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
                    onSaved: (pass) => user.confirmPassword = pass,
                    decoration: InputDecoration(
                      hintText: '   Repita a Senha',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    validator: (pass) {
                      if (pass.isEmpty)
                        return 'Campo Obrigatório!';
                      else if (pass.length < 6) return 'Senha muito curta!';
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
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      if (user.password != user.confirmPassword) {
                        scaffoldKey.currentState.showSnackBar(SnackBar(
                          content: const Text('As senhas precisam ser iguais!'),
                          backgroundColor: Colors.red,
                        ));
                        return;
                      }
                      context.read<UserManager>().signUp(
                            user: user,
                            onSucess: () {
                              debugPrint('sucesso!');
                              // TODO: POP.
                            },
                            onFail: (e) {
                              scaffoldKey.currentState.showSnackBar(
                                SnackBar(
                                  content: Text('Falha ao cadastrar:  $e '),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            },
                          );
                    }
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
