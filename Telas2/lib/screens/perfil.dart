import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:telas2/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  DateTime selectedDate = DateTime.now();
  bool isLogin = false;
  late String username = "Username";
  late String email = "email@email.com";
  late String password = "";
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    checkUserLoginState();
  }

  // void checkUserLoginState() async {
  //   prefs = await SharedPreferences.getInstance();
  //   print(prefs.getString('username'));

  //   setState(() {
  //     if (prefs.getString('email') != null) {
  //       username = prefs.getString('username')!;
  //       email = prefs.getString('email')!;
  //       password = prefs.getString('password')!;
  //       isLogin = true;
  //     }
  //   });
  // }

  Future<void> checkUserLoginState() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isLogin = (prefs.getBool('isLogin') == true ? true : false);
      username = (prefs.getString('username') ?? "Username");
      email = (prefs.getString('email') ?? "email@email.com");
      password = (prefs.getString('password') ?? "");
    });
  }

  void alterUser() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isLogin = (prefs.getBool('isLogin') == false ? true : false);
      prefs.setBool('isLogin', isLogin);
      print(prefs.getBool('isLogin'));
      username = (prefs.getString('username') ?? "Username");
      email = (prefs.getString('email') ?? "email@email.com");
      password = (prefs.getString('password') ?? "");
      print(prefs.getString('username'));
    });
  }

  void removeUser() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isLogin = (prefs.getBool('isLogin') == true ? false : false);
      prefs.setBool('isLogin', isLogin);
      print(prefs.getBool('isLogin'));
      prefs.remove("username");
      prefs.remove("email");
      prefs.remove("password");
      username = (prefs.getString('username') ?? "Username");
      email = (prefs.getString('email') ?? "email@email.com");
      password = (prefs.getString('password') ?? "");
      print(prefs.getString('email'));
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //throw UnimplementedError();
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
    print("email:$email");
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).perfil),
      ),
      body: ListView(
        children: <Widget>[
          if (isLogin == true)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: Text(username),
                    subtitle: Text(email),
                  ),
                  const ListTile(
                    leading: Icon(Icons.lock),
                    title: Text('Change password'),
                  ),
                  const ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Settings'),
                  ),
                  ElevatedButton(
                    style: style,
                    onPressed: removeUser,
                    child: Text(AppLocalizations.of(context).sair),
                  ),
                ],
              ),
            ),
          if (isLogin == false)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: Text(AppLocalizations.of(context).perfil),
                    subtitle: Text(email),
                  ),
                  ListTile(
                    leading: const Icon(Icons.lock),
                    title: Text(AppLocalizations.of(context).mudar_senha),
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: Text(AppLocalizations.of(context).configuracoes),
                  ),
                  ElevatedButton(
                    style: style,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (contextNew) => const Login(),
                        ),
                      );
                      alterUser;
                    },
                    child: Text(AppLocalizations.of(context).entrar),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
