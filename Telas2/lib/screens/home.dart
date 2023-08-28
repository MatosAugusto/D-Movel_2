import 'package:flutter/material.dart';
import 'package:telas2/data/EventDAO.dart';
//import 'package:telas2/data/task_dao.dart';
import 'package:telas2/screens/cadastro_evento.dart';
import 'package:telas2/components/barra_pesquisa.dart';
import 'package:telas2/components/meses_home.dart';
//import 'package:telas2/components/task.dart';
import 'package:telas2/screens/infos.dart';
import '../data/Event.dart';

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

  // Future<List<Event>> getTasksFuture() {
  //   if (pesq != '') {
  //     return EventDAO().fetchAllEventTitle(pesq);
  //   }
  //   return EventDAO().findByMonthAndYear(year, month);
  // }

  Future<List<Event>> getEventsFuture() {
    if (pesq != '') {
      return EventDAO().fetchAllEventTitle(pesq);
    }
    return EventDAO().findByMonthAndYear(year, month);
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
              child: FutureBuilder<List<Event>>(
                  future: getEventsFuture(),
                  builder: (context, snapshot) {
                    List<Event>? items = snapshot.data;
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
                                  //return Text(items[index].title);
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Stack(
                                      children: [
                                        Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                color: Colors.white,
                                              ),
                                              height: 100,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          width: 200,
                                                          child: Text(
                                                            items[index].title,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 24,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 200,
                                                          child: Text(
                                                            items[index].day +
                                                                "/" +
                                                                items[index]
                                                                    .month +
                                                                "/" +
                                                                items[index]
                                                                    .year, //ajustar para pegar dia, mês e ano
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 16,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 52,
                                                      width: 52,
                                                      child: ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (contextNew) =>
                                                                        Infos(
                                                                  titulo: items[
                                                                          index]
                                                                      .title,
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                          child: const Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Icon(Icons
                                                                  .arrow_right),
                                                            ],
                                                          )),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
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
