//import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:telas2/data/User.dart';
// import 'package:telas2/data/task_dao.dart';
// import 'package:telas2/components/task.dart';
import 'package:telas2/data/UserDAO.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CadastroUsuario extends StatefulWidget {
  const CadastroUsuario({super.key});

  @override
  State<CadastroUsuario> createState() => _CadastroUsuarioState();
}

class _CadastroUsuarioState extends State<CadastroUsuario> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final UserDAO _userDAO = UserDAO();
  User? _userData;

  @override
  void initState() {
    super.initState();
  }

  // void _fetchUserInfo() async {
  //   try {
  //     List<User> users = await _userDAO.fetchUser(emailController.toString());
  //     if (users.isNotEmpty) {
  //       setState(() {
  //         _userData = users.first;
  //         emailController.text = _userData?.email ?? "";
  //       });
  //     }
  //   } catch (e) {
  //     print("Erro ao buscar dados do evento: $e");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back)),
          title: Text(AppLocalizations.of(context).cadastrar_usuario),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: nameController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: AppLocalizations.of(context).nome_usuario,
                      fillColor: Colors.white70,
                      filled: true,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: emailController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: AppLocalizations.of(context).email_usuario,
                      fillColor: Colors.white70,
                      filled: true,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: AppLocalizations.of(context).senha_usuario,
                      fillColor: Colors.white70,
                      filled: true,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          print(emailController.text);
                          List<User> users =
                              await _userDAO.fetchUser(emailController.text);
                          if (users.isNotEmpty) {
                            setState(() {
                              Fluttertoast.showToast(
                                  msg: AppLocalizations.of(context)
                                      .usuario_cadastrado,
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.white,
                                  textColor: Colors.black,
                                  fontSize: 16.0);
                            });
                            Fluttertoast.showToast(
                                msg: AppLocalizations.of(context).email_existe,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.white,
                                textColor: Colors.black,
                                fontSize: 16.0);
                          } else {
                            Fluttertoast.showToast(
                                msg: AppLocalizations.of(context)
                                    .erro_cadastrar_usuario,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.white,
                                textColor: Colors.black,
                                fontSize: 16.0);
                          }
                        } catch (e) {
                          UserDAO().createUser(nameController.text,
                              emailController.text, passwordController.text);
                          await Future.delayed(
                              const Duration(milliseconds: 500));
                          Navigator.pop(context);
                        }

                        // if (_formKey.currentState!.validate()) {
                        //   retorno = UserDAO().createUser(nameController.text,
                        //       emailController.text, passwordController.text);
                        //   await Future.delayed(
                        //       const Duration(milliseconds: 500));

                        //   print("Retorno");
                        //   print(retorno as int);

                        //   if (retorno == zero) {
                        //     Navigator.pop(context);
                        //   } else if (retorno == um) {
                        //     //email já existe
                        //     print("Email já existe");
                        //     Fluttertoast.showToast(
                        //         msg: AppLocalizations.of(context).email_existe,
                        //         toastLength: Toast.LENGTH_SHORT,
                        //         gravity: ToastGravity.CENTER,
                        //         timeInSecForIosWeb: 1,
                        //         backgroundColor: Colors.white,
                        //         textColor: Colors.black,
                        //         fontSize: 16.0);
                        //   } else {
                        //     print("Erro ao cadastrar");
                        //     Fluttertoast.showToast(
                        //         msg: AppLocalizations.of(context).email_existe,
                        //         toastLength: Toast.LENGTH_SHORT,
                        //         gravity: ToastGravity.CENTER,
                        //         timeInSecForIosWeb: 1,
                        //         backgroundColor: Colors.white,
                        //         textColor: Colors.black,
                        //         fontSize: 16.0);
                        //   }
                        // }
                      },
                      child:
                          Text(AppLocalizations.of(context).cadastrar_usuario),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
