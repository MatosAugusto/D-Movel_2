import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telas2/screens/cadastro_usuario.dart';
import 'package:telas2/data/UserDAO.dart';
import 'package:telas2/data/User.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  DateTime selectedDate = DateTime.now();
  late SharedPreferences prefs;
  bool isLogin = false;
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

  Future<void> checkUserLoginState() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isLogin = (prefs.getBool('isLogin') ?? false);
    });
  }

  void alterUser() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isLogin = (prefs.getBool('isLogin') == false ? true : false);
      prefs.setBool('isLogin', isLogin);
      print(prefs.getBool('isLogin'));
      prefs.setString('username', nameController.text);
      prefs.setString('email', emailController.text);
      prefs.setString('password', passwordController.text);
      print(prefs.getString('username'));
    });
  }

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
          title: Text(AppLocalizations.of(context).entrar),
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
                        print(emailController.text);
                        print(passwordController.text);
                        try {
                          List<User> users =
                              await _userDAO.findByEmailAndPassword(
                                  emailController.text,
                                  passwordController.text);
                          //print("Achou");
                          if (users.isNotEmpty) {
                            setState(() {
                              _userData = users.first;
                              nameController.text = _userData?.username ?? "";
                              emailController.text = _userData?.email ?? "";
                              passwordController.text =
                                  _userData?.password ?? "";
                              print(nameController.text);
                              Navigator.pop(context);
                            });
                            alterUser();
                          }
                        } catch (e) {
                          Fluttertoast.showToast(
                              msg: AppLocalizations.of(context)
                                  .email_nao_cadastrado,
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.white,
                              textColor: Colors.black,
                              fontSize: 16.0);
                        }
                      },
                      child: Text(AppLocalizations.of(context).entrar),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (contextNew) => const CadastroUsuario(),
                          ),
                        );
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
