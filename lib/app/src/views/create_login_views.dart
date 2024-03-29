import 'package:agencia_scholz/app/src/models/user_manager_model.dart';
import 'package:agencia_scholz/app/src/data/user_data.dart';
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
        title: const Text(
          'Criar Conta',
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(left: 40, top: 40, right: 40),
          child: Consumer<UserManager>(
            builder: (_, userManager, __) {
              return ListView(
                children: <Widget>[
                  const SizedBox(
                    height: 30,
                  ),
                  Image.asset(
                    'assets/images/Logotipo-4.png',
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: TextFormField(
                        onSaved: (name) => user.name = name,
                        enabled: !userManager.loading,
                        autocorrect: false,
                        decoration: const InputDecoration(
                          hintText: '   Nome Completo',
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        validator: (name) {
                          if (name.isEmpty) {
                            return 'Campo Obrigatório';
                          } else if (name.trim().split(' ').length <= 1) return 'Preencha seu nome completo!';
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
                  const SizedBox(
                    height: 20,
                  ),
                  Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: TextFormField(
                        enabled: !userManager.loading,
                        onSaved: (email) => user.email = email,
                        autocorrect: false,
                        decoration: const InputDecoration(
                          hintText: '   E-mail',
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (email) {
                          if (email.isEmpty) {
                            return 'Campo Obrigatório!';
                          } else if (!emailValid(email)) return 'E-mail inválido!';
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
                        enabled: !userManager.loading,
                        onSaved: (pass) => user.password = pass,
                        decoration: const InputDecoration(
                          hintText: '   Senha',
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        validator: (pass) {
                          if (pass.isEmpty) {
                            return 'Campo Obrigatório!';
                          } else if (pass.length < 6) return 'Senha muito curta!';
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
                        enabled: !userManager.loading,
                        onSaved: (pass) => user.confirmPassword = pass,
                        decoration: const InputDecoration(
                          hintText: '   Repita a Senha',
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        validator: (pass) {
                          if (pass.isEmpty) {
                            return 'Campo Obrigatório!';
                          } else if (pass.length < 6) return 'Senha muito curta!';
                          return null;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    height: 45,
                    child: RaisedButton(
                      onPressed: userManager.loading
                          ? null
                          : () {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                if (user.password != user.confirmPassword) {
                                  scaffoldKey.currentState.showSnackBar(const SnackBar(
                                    content: Text('As senhas precisam ser iguais!'),
                                    backgroundColor: Colors.red,
                                  ));
                                  return;
                                }
                                userManager.signUp(
                                  user: user,
                                  onSucess: () {
                                    Navigator.of(context).pop();
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
                      child: userManager.loading
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            )
                          : const Text(
                              'Cadastrar Conta',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
