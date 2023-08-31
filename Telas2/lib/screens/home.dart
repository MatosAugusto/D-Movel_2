import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Eventos/data/EventDAO.dart';
//import 'package:Eventos/data/task_dao.dart';
import 'package:Eventos/screens/cadastro_evento.dart';
import 'package:Eventos/components/barra_pesquisa.dart';
import 'package:Eventos/components/meses_home.dart';
//import 'package:Eventos/components/task.dart';
import 'package:Eventos/screens/infos.dart';
import '../data/Event.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  bool isLogin = false;
  late final SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    checkUserLoginState();
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

  Future<void> checkUserLoginState() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isLogin = (prefs.getBool('isLogin') ?? false);
    });
  }

  Future<List<Event>> getEventsFuture() {
    if (pesq != '') {
      return EventDAO().fetchAllEventTitle(pesq);
    }
    return EventDAO().findByMonthAndYear(year, month);
  }

  @override
  Widget build(BuildContext context) {
    return isLogin != null
        ? isLogin == true
            ? Scaffold(
                appBar: AppBar(
                  leading: Container(),
                  title: Text(AppLocalizations.of(context).pesquisar_evento),
                  actions: const [
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
                                  return Center(
                                    child: Column(
                                      children: [
                                        const CircularProgressIndicator(),
                                        Text(AppLocalizations.of(context)
                                            .carregando)
                                      ],
                                    ),
                                  );

                                case ConnectionState.waiting:
                                  return Center(
                                    child: Column(
                                      children: [
                                        const CircularProgressIndicator(),
                                        Text(AppLocalizations.of(context)
                                            .carregando)
                                      ],
                                    ),
                                  );

                                case ConnectionState.active:
                                  return Center(
                                    child: Column(
                                      children: [
                                        const CircularProgressIndicator(),
                                        Text(AppLocalizations.of(context)
                                            .carregando)
                                      ],
                                    ),
                                  );

                                case ConnectionState.done:
                                  if (snapshot.hasData && items != null) {
                                    if (items.isNotEmpty) {
                                      return ListView.builder(
                                          itemCount: items.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            //return Text(items[index].title);
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Stack(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4),
                                                          color: Colors.white,
                                                        ),
                                                        height: 100,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
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
                                                                      items[index]
                                                                          .title,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            24,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 200,
                                                                    child: Text(
                                                                      "${items[index].day}/${items[index].month}/${items[index].year}", //ajustar para pegar dia, mês e ano
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 52,
                                                                width: 52,
                                                                child:
                                                                    ElevatedButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator
                                                                              .push(
                                                                            context,
                                                                            MaterialPageRoute(
                                                                              builder: (contextNew) => Infos(
                                                                                titulo: items[index].title,
                                                                              ),
                                                                            ),
                                                                          );
                                                                        },
                                                                        child:
                                                                            const Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceEvenly,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.end,
                                                                          children: [
                                                                            Icon(Icons.arrow_right),
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
                        builder: (contextNew) => const CadastroEvento(),
                      ),
                    ).then((value) => setState(() {}));
                  },
                  child: const Icon(Icons.add),
                ),
              )
            : Scaffold(
                appBar: AppBar(
                  leading: Container(),
                  title: Text(AppLocalizations.of(context).pesquisar_evento),
                  actions: const [
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
                                  return Center(
                                    child: Column(
                                      children: [
                                        const CircularProgressIndicator(),
                                        Text(AppLocalizations.of(context)
                                            .carregando)
                                      ],
                                    ),
                                  );

                                case ConnectionState.waiting:
                                  return Center(
                                    child: Column(
                                      children: [
                                        const CircularProgressIndicator(),
                                        Text(AppLocalizations.of(context)
                                            .carregando)
                                      ],
                                    ),
                                  );

                                case ConnectionState.active:
                                  return Center(
                                    child: Column(
                                      children: [
                                        const CircularProgressIndicator(),
                                        Text(AppLocalizations.of(context)
                                            .carregando)
                                      ],
                                    ),
                                  );

                                case ConnectionState.done:
                                  if (snapshot.hasData && items != null) {
                                    if (items.isNotEmpty) {
                                      return ListView.builder(
                                          itemCount: items.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            //return Text(items[index].title);
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Stack(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4),
                                                          color: Colors.white,
                                                        ),
                                                        height: 100,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
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
                                                                      items[index]
                                                                          .title,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            24,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 200,
                                                                    child: Text(
                                                                      "${items[index].day}/${items[index].month}/${items[index].year}", //ajustar para pegar dia, mês e ano
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 52,
                                                                width: 52,
                                                                child:
                                                                    ElevatedButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator
                                                                              .push(
                                                                            context,
                                                                            MaterialPageRoute(
                                                                              builder: (contextNew) => Infos(
                                                                                titulo: items[index].title,
                                                                              ),
                                                                            ),
                                                                          );
                                                                        },
                                                                        child:
                                                                            const Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceEvenly,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.end,
                                                                          children: [
                                                                            Icon(Icons.arrow_right),
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
              )
        : Scaffold(
            appBar: AppBar(
              leading: Container(),
              title: Text(AppLocalizations.of(context).pesquisar_evento),
              actions: const [
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
                              return Center(
                                child: Column(
                                  children: [
                                    const CircularProgressIndicator(),
                                    Text(
                                        AppLocalizations.of(context).carregando)
                                  ],
                                ),
                              );

                            case ConnectionState.waiting:
                              return Center(
                                child: Column(
                                  children: [
                                    const CircularProgressIndicator(),
                                    Text(
                                        AppLocalizations.of(context).carregando)
                                  ],
                                ),
                              );

                            case ConnectionState.active:
                              return Center(
                                child: Column(
                                  children: [
                                    const CircularProgressIndicator(),
                                    Text(
                                        AppLocalizations.of(context).carregando)
                                  ],
                                ),
                              );

                            case ConnectionState.done:
                              if (snapshot.hasData && items != null) {
                                if (items.isNotEmpty) {
                                  return ListView.builder(
                                      itemCount: items.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
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
                                                          BorderRadius.circular(
                                                              4),
                                                      color: Colors.white,
                                                    ),
                                                    height: 100,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
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
                                                                  items[index]
                                                                      .title,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        24,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 200,
                                                                child: Text(
                                                                  "${items[index].day}/${items[index].month}/${items[index].year}", //ajustar para pegar dia, mês e ano
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        16,
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
                                                            child:
                                                                ElevatedButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator
                                                                          .push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                          builder: (contextNew) =>
                                                                              Infos(
                                                                            titulo:
                                                                                items[index].title,
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                    child:
                                                                        const Column(
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
          );
  }
}
