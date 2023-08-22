import 'package:flutter/material.dart';
import 'package:telas2/data/task_dao.dart';
import 'package:telas2/screens/cadastro_evento.dart';
import 'package:telas2/components/barra_pesquisa.dart';
import 'package:telas2/components/meses_home.dart';
import 'package:telas2/components/task.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime selectedDate = DateTime.now();
  String month = '';
  String year = '';
  String pesq = '';

  @override
  void initState() {
    super.initState();
    year = selectedDate.year.toString();
    month = selectedDate.month.toString().padLeft(2, '0');
  }

  void updateMonthAndYear(String newYear, String newMonth) {
    // Atualize o estado do widget Home com os novos valores de mês e ano
    setState(() {
      month = newMonth;
      year = newYear;
    });
  }

  Future<List<Task>> getTasksFuture() {
    if(pesq != ''){
      return TaskDAO().find(pesq);
    }
    return TaskDAO().findByMonthAndYear(year, month);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: const Text('Pesquisar Eventos'),
        actions: [
          BarraPesquisa(),
        ],
      ),
      body: Column(
        children: [
          MonthYearSelector(
            onDateChanged: (newYear, newMonth) {
              updateMonthAndYear(newYear, newMonth);
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder<List<Task>>(
                  future: getTasksFuture(),
                  builder: (context, snapshot) {
                    List<Task>? items = snapshot.data;
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return const Center(
                          child: Column(
                            children: [
                              CircularProgressIndicator(),
                              Text('Carregando')
                            ],
                          ),
                        );

                      case ConnectionState.waiting:
                        return const Center(
                          child: Column(
                            children: [
                              CircularProgressIndicator(),
                              Text('Carregando')
                            ],
                          ),
                        );

                      case ConnectionState.active:
                        return const Center(
                          child: Column(
                            children: [
                              CircularProgressIndicator(),
                              Text('Carregando')
                            ],
                          ),
                        );

                      case ConnectionState.done:
                        if (snapshot.hasData && items != null) {
                          if (items.isNotEmpty) {
                            return ListView.builder(
                                itemCount: items.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final Task tarefa = items[index];
                                  return tarefa;
                                });
                          }
                        }
                        return const Text('');
                    }
                  }),
            ),
          ),
          const SizedBox(
            height: 60,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (contextNew) => CadastroEvento(),
            ),
          ).then((value) => setState(() {}));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
