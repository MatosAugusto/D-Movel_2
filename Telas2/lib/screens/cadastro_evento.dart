//import 'dart:math';

import 'package:flutter/material.dart';
import 'package:telas2/components/data_evento.dart';
import 'package:telas2/components/horario_evento.dart';
// import 'package:telas2/data/task_dao.dart';
// import 'package:telas2/components/task.dart';
import 'package:telas2/data/EventDAO.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CadastroEvento extends StatefulWidget {
  const CadastroEvento({super.key});

  @override
  State<CadastroEvento> createState() => _CadastroEventoState();
}

class _CadastroEventoState extends State<CadastroEvento> {
  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController hourController = TextEditingController();
  TextEditingController localController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController dayController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  // late String day;
  // late String month;
  // late String year;

  final _formKey = GlobalKey<FormState>();

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
          title: Text(AppLocalizations.of(context).cadastrar_evento),
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
                    controller: titleController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: AppLocalizations.of(context).titulo_evento,
                      fillColor: Colors.white70,
                      filled: true,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      DatePickerExample(
                        onDateSelected: (selectedDate) {
                          dateController.text = selectedDate;
                          print("Date selected: ${dateController.text}");
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      TimePickerExample(
                        onHourSelected: (selectedHour) {
                          hourController.text = selectedHour;
                          print("Hour selected: ${hourController.text}");
                        },
                      ), // Substitua o comentário pelo TimePickerExample
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: localController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: AppLocalizations.of(context).localizacao,
                      fillColor: Colors.white70,
                      filled: true,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: descriptionController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: AppLocalizations.of(context).descricao,
                      fillColor: Colors.white70,
                      filled: true,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: contactController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: AppLocalizations.of(context).contato,
                      fillColor: Colors.white70,
                      filled: true,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: nameController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: AppLocalizations.of(context).nomecontato,
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          String dateSplit = dateController.text;
                          List<String> dateParts = dateSplit.split('-');
                          //print(dateParts);
                          dayController.text = dateParts[2];
                          monthController.text = dateParts[1];
                          yearController.text = dateParts[0];
                          EventDAO().createEvent(
                              titleController.text,
                              dayController.text,
                              monthController.text,
                              yearController.text,
                              hourController.text,
                              localController.text,
                              descriptionController.text,
                              contactController.text,
                              nameController.text);

                          await Future.delayed(const Duration(milliseconds: 500));
                          Navigator.pop(context);
                        }
                      },
                      child:
                          Text(AppLocalizations.of(context).cadastrar_evento),
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
