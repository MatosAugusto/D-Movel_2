import 'package:flutter/material.dart';
import 'package:telas2/screens/home.dart';
import 'package:telas2/screens/perfil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    // Coloque aqui os widgets das telas que deseja exibir
    const Home(),
    const Text('Ingressos'),
    const Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.home,
              color: Colors.red,
            ),
            label: AppLocalizations.of(context).inicio,
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.airplane_ticket,
              color: Colors.red,
            ),
            label: AppLocalizations.of(context).ingressos,
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.person,
              color: Colors.red,
            ),
            label: AppLocalizations.of(context).perfil,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red,
        onTap: _onItemTapped,
      ),
    );
  }
}
