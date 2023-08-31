// import 'package:flutter/material.dart';
// import 'package:Eventos/data/task_dao.dart';
// import 'package:Eventos/components/task.dart';

// class Infos extends StatefulWidget {
//   final String titulo;

//   const Infos({required this.titulo, super.key});

//   @override
//   State<Infos> createState() => _InfosState();
// }

// class _InfosState extends State<Infos> {
//   final TaskDAO _taskDAO = TaskDAO();
//   late Task _task = Task("", "", "", "", "", "", ""); // Cria uma tarefa vazia
//   bool _dataLoaded = false;

//   final TextEditingController titleController = TextEditingController();
//   final TextEditingController dateController = TextEditingController();
//   final TextEditingController hourController = TextEditingController();
//   final TextEditingController localController = TextEditingController();
//   final TextEditingController descriptionController = TextEditingController();
//   final TextEditingController contactController = TextEditingController();
//   final TextEditingController nameController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _fetchTaskInfo();
//   }

//   void _fetchTaskInfo() async {
//     List<Task> tasks = await _taskDAO.find(widget.titulo);
//     if (tasks.isNotEmpty) {
//       setState(() {
//         _task = tasks.first;
//         titleController.text = _task.titulo;
//         dateController.text = _task.data;
//         hourController.text = _task.hora;
//         localController.text = _task.local;
//         descriptionController.text = _task.descricao;
//         contactController.text = _task.contato;
//         nameController.text = _task.nome;

//         _dataLoaded = true;
//       });
//     }
//   }

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/EventDAO.dart';
import '../data/Event.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../data/TicketDAO.dart';

class Infos extends StatefulWidget {
  final String titulo;

  const Infos({required this.titulo, super.key});

  @override
  State<Infos> createState() => _InfosState();
}

class _InfosState extends State<Infos> {
  final EventDAO _eventDAO = EventDAO();
  Event? _eventData; // Usando Event ao invés de Map
  bool _dataLoaded = false;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController hourController = TextEditingController();
  final TextEditingController localController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController contactnameController = TextEditingController();
  late SharedPreferences prefs;
  String _userEmail = '';
  String _username = '';
  bool isLogin = false;

  @override
  void initState() {
    super.initState();
    _fetchEventInfo();
    _loadUser();
  }

  void _fetchEventInfo() async {
    try {
      List<Event> events = await _eventDAO.fetchAllEventTitle(widget.titulo);
      if (events.isNotEmpty) {
        setState(() {
          _eventData = events.first;
          titleController.text = _eventData?.title ?? "";
          dateController.text =
              "${_eventData?.day}/${_eventData?.month}/${_eventData?.year}";
          hourController.text = _eventData?.hour ?? "";
          localController.text = _eventData?.local ?? "";
          descriptionController.text = _eventData?.description ?? "";
          contactController.text = _eventData?.contact ?? "";
          contactnameController.text = _eventData?.contactname ?? "";

          _dataLoaded = true;
        });
      }
    } catch (e) {
      print("Erro ao buscar dados do evento: $e");
    }
  }

  Future<void> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isLogin = (prefs.getBool('isLogin') ?? false);
      print(isLogin);
      print(prefs.getString('username'));
      print(prefs.getString('email'));
      _userEmail = prefs.getString('email') ?? '';
      _username = prefs.getString('username') ?? '';
    });
  }
  // void _loadUser() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   setState() {
  //     isLogin = (prefs.getBool('isLogin') == true ? true : false);
  //     _userEmail = prefs.getString('email') ?? '';
  //     print(prefs.getString('email'));
  //     _username = prefs.getString('username') ?? '';
  //   }
  // }

  void _buyTicket() {
    // Assuming you have a TicketDAO with a createTicket method
    TicketDAO ticketDAO = TicketDAO();
    if (_eventData != null) {
      ticketDAO.createTicket(
          _eventData!.title,
          _eventData!.day,
          _eventData!.month,
          _eventData!.year,
          _eventData!.hour,
          _eventData!.contact,
          _eventData!.contactname,
          _userEmail,
          _username);
    }
  }

  @override
  Widget build(BuildContext context) {
    //_loadUser();
    print("Informações do Evento");
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(AppLocalizations.of(context).informacoes_evento),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (_dataLoaded)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    readOnly: true,
                    enabled: false,
                    controller: titleController,
                    style: const TextStyle(color: Colors.black),
                    // Text color
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context).titulo_evento,
                      floatingLabelAlignment: FloatingLabelAlignment.center,
                      border: const OutlineInputBorder(),
                      fillColor: Colors.white70,
                      filled: true,
                    ),
                  ),
                ),
              if (_dataLoaded)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    readOnly: true,
                    enabled: false,
                    controller: dateController,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context).data_evento,
                      floatingLabelAlignment: FloatingLabelAlignment.center,
                      border: const OutlineInputBorder(),
                      fillColor: Colors.white70,
                      filled: true,
                    ),
                  ),
                ),
              if (_dataLoaded)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    readOnly: true,
                    enabled: false,
                    controller: hourController,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context).hora_evento,
                      floatingLabelAlignment: FloatingLabelAlignment.center,
                      border: const OutlineInputBorder(),
                      fillColor: Colors.white70,
                      filled: true,
                    ),
                  ),
                ),
              if (_dataLoaded)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    readOnly: true,
                    enabled: false,
                    controller: localController,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context).localizacao,
                      floatingLabelAlignment: FloatingLabelAlignment.center,
                      border: const OutlineInputBorder(),
                      fillColor: Colors.white70,
                      filled: true,
                    ),
                  ),
                ),
              if (_dataLoaded)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    readOnly: true,
                    enabled: false,
                    controller: descriptionController,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context).descricao,
                      floatingLabelAlignment: FloatingLabelAlignment.center,
                      border: const OutlineInputBorder(),
                      fillColor: Colors.white70,
                      filled: true,
                    ),
                  ),
                ),
              if (_dataLoaded)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    readOnly: true,
                    enabled: false,
                    controller: contactController,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context).contato,
                      floatingLabelAlignment: FloatingLabelAlignment.center,
                      border: const OutlineInputBorder(),
                      fillColor: Colors.white70,
                      filled: true,
                    ),
                  ),
                ),
              if (_dataLoaded)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    readOnly: true,
                    enabled: false,
                    controller: contactnameController,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context).nomecontato,
                      floatingLabelAlignment: FloatingLabelAlignment.center,
                      border: const OutlineInputBorder(),
                      fillColor: Colors.white70,
                      filled: true,
                    ),
                  ),
                ),
              /* Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: imageController,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Imagem',
                            fillColor: Colors.white70,
                            filled: true,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 500,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 2, color: Colors.blue),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            /*child: Image.network(
                              imageController.text,
                              errorBuilder: (BuildContext context, Object exception,
                                  StackTrace? stackTrace) {
                                return Image.asset('assets/images/nophoto.png');
                              },
                              fit: BoxFit.cover,
                            ),*/
                          ),
                        ),
                      ),*/ // Inserção de imagem só se der tempo
              if (_dataLoaded && isLogin)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      _buyTicket();
                      Navigator.pop(context);
                    },
                    child: Text(AppLocalizations.of(context).comprar_ingresso),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
