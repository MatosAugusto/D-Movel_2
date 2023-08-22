import 'package:flutter/material.dart';
import 'package:telas2/data/task_dao.dart';
import 'package:telas2/components/task.dart';

class Infos extends StatefulWidget {
  final String titulo;

  const Infos({required this.titulo, super.key});

  @override
  State<Infos> createState() => _InfosState();
}

class _InfosState extends State<Infos> {
  final TaskDAO _taskDAO = TaskDAO();
  late Task _task = Task("", "", "", "", "", "", ""); // Cria uma tarefa vazia
  bool _dataLoaded = false;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController hourController = TextEditingController();
  final TextEditingController localController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchTaskInfo();
  }

  void _fetchTaskInfo() async {
    List<Task> tasks = await _taskDAO.find(widget.titulo);
    if (tasks.isNotEmpty) {
      setState(() {
        _task = tasks.first;
        titleController.text = _task.titulo;
        dateController.text = _task.data;
        hourController.text = _task.hora;
        localController.text = _task.local;
        descriptionController.text = _task.descricao;
        contactController.text = _task.contato;
        nameController.text = _task.nome;

        _dataLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Informações do Evento");
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('Informações do Evento'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if(_dataLoaded)
                Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  textAlign: TextAlign.center,
                  readOnly: true,
                  enabled: false,
                  controller: titleController,
                  style: TextStyle(color: Colors.black),
                  // Text color
                  decoration: const InputDecoration(
                    labelText: 'Titulo do Evento',
                    floatingLabelAlignment: FloatingLabelAlignment.center,
                    border: OutlineInputBorder(),
                    fillColor: Colors.white70,
                    filled: true,
                  ),
                ),
              ),
              if(_dataLoaded)
                Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  textAlign: TextAlign.center,
                  readOnly: true,
                  enabled: false,
                  controller: dateController,
                  style: TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    labelText: 'Data do Evento',
                    floatingLabelAlignment: FloatingLabelAlignment.center,
                    border: OutlineInputBorder(),
                    fillColor: Colors.white70,
                    filled: true,
                  ),
                ),
              ),
              if(_dataLoaded)
                Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  textAlign: TextAlign.center,
                  readOnly: true,
                  enabled: false,
                  controller: hourController,
                  style: TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    labelText: 'Hora do Evento',
                    floatingLabelAlignment: FloatingLabelAlignment.center,
                    border: OutlineInputBorder(),
                    fillColor: Colors.white70,
                    filled: true,
                  ),
                ),
              ),
              if(_dataLoaded)
                Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  textAlign: TextAlign.center,
                  readOnly: true,
                  enabled: false,
                  controller: localController,
                  style: TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    labelText: 'Localização',
                    floatingLabelAlignment: FloatingLabelAlignment.center,
                    border: OutlineInputBorder(),
                    fillColor: Colors.white70,
                    filled: true,
                  ),
                ),
              ),
              if(_dataLoaded)
                Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  textAlign: TextAlign.center,
                  readOnly: true,
                  enabled: false,
                  controller: descriptionController,
                  style: TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    labelText: 'Descricao',
                    floatingLabelAlignment: FloatingLabelAlignment.center,
                    border: OutlineInputBorder(),
                    fillColor: Colors.white70,
                    filled: true,
                  ),
                ),
              ),
              if(_dataLoaded)
                Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  textAlign: TextAlign.center,
                  readOnly: true,
                  enabled: false,
                  controller: contactController,
                  style: TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    labelText: 'Contato',
                    floatingLabelAlignment: FloatingLabelAlignment.center,
                    border: OutlineInputBorder(),
                    fillColor: Colors.white70,
                    filled: true,
                  ),
                ),
              ),
              if(_dataLoaded)
                Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  textAlign: TextAlign.center,
                  readOnly: true,
                  enabled: false,
                  controller: nameController,
                  style: TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    labelText: 'Nome do Contato',
                    floatingLabelAlignment: FloatingLabelAlignment.center,
                    border: OutlineInputBorder(),
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
            ],
          ),
        ),
      ),
    );
  }
}
