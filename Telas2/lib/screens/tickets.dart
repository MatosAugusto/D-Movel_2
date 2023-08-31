import 'package:flutter/material.dart';
import '../data/Ticket.dart';
import '../data/TicketDAO.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Tickets extends StatefulWidget {
  const Tickets({super.key});

  @override
  State<Tickets> createState() => _TicketsState();
}

class _TicketsState extends State<Tickets> {
  late SharedPreferences prefs;
  String _userEmail = ''; // Para armazenar o email do usuário logado
  final TicketDAO _ticketDAO = TicketDAO();
  late Future<List<Ticket>> _tickets;
  bool isLogin = false;

  @override
  void initState() {
    super.initState();
    _loadUserEmail(); // Carrega o email do usuário logado
    //_loadTickets(); // Carrega a lista de ingressos
  }

  void _loadUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isLogin = (prefs.getBool('isLogin') == true ? true : false);
      prefs.setBool('isLogin', isLogin);
      _userEmail = prefs.getString('email') ?? '';
    });
  }

  void _loadTickets() {
    _tickets = _ticketDAO
        .findByEmail(_userEmail); // Busca os ingressos do usuário pelo email
  }

  @override
  Widget build(BuildContext context) {
    if (isLogin) {
      _loadTickets();
    }

    return isLogin == true
        ? Scaffold(
            appBar: AppBar(
              title: Text(AppLocalizations.of(context).meus_ingressos),
            ),
            body: FutureBuilder<List<Ticket>>(
              future: _tickets,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                      child: Text(AppLocalizations.of(context).erro_ingresso));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                      // child: Text(AppLocalizations.of(context)
                      //     .ingresso_nao_encontrado));
                      child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: const Icon(Icons.airplane_ticket),
                        title: Text(AppLocalizations.of(context)
                            .ingresso_nao_encontrado),
                      ),
                    ],
                  ));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      Ticket ticket = snapshot.data![index];
                      return ListTile(
                        title: Text(ticket.title),
                        subtitle: Text(
                            "${AppLocalizations.of(context).data_evento}: ${ticket.day}/${ticket.month}/${ticket.year} - ${AppLocalizations.of(context).hora_evento}: ${ticket.hour}"),
                        trailing: IconButton(
                          onPressed: () {
                            //
                          },
                          icon: const Icon(Icons.info),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text(AppLocalizations.of(context).meus_ingressos),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.airplane_ticket),
                    title: Text(
                        AppLocalizations.of(context).ingresso_nao_encontrado),
                  ),
                ],
              ),
            ),
          );
  }
}
