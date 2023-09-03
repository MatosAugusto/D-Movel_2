import 'package:flutter/material.dart';
// import 'package:Eventos/components/task.dart';
// import 'package:Eventos/data/task_dao.dart';
import 'package:Eventos/screens/infos.dart';
import '../data/Event.dart';
import '../data/EventDAO.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BarraPesquisa extends StatefulWidget {
  const BarraPesquisa({super.key});

  @override
  State<BarraPesquisa> createState() => _BarraPesquisaState();
}

class _BarraPesquisaState extends State<BarraPesquisa> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.search),
      onPressed: () {
        showSearch(context: context, delegate: SearchBarDelegate());
      },
    );
  }
}

class SearchBarDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, query);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return Center(
        child: Text(AppLocalizations.of(context).insira_consulta),
      );
    }
    // Implemente a lógica de pesquisa e exiba os resultados reais aqui
    // Quando a pesquisa estiver concluída, chame Navigator.pop para voltar à tela anterior
    // Por exemplo:
    /*Future.delayed(Duration(milliseconds: 500), () {
      Navigator.pop(context);
    });*/

    close(context, query);

    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Center(
        child: Text(AppLocalizations.of(context).sugestao_pesquisa),
      );
    } else {
      print("A query:$query");
      // Chamar o método 'find' do DAO e obter as sugestões de eventos
      final eventDAO = EventDAO();
      return FutureBuilder<List<Event>>(
        future: eventDAO.fetchAllEventTitle(query),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final suggestions = snapshot.data!;
            return ListView.builder(
              itemCount: suggestions.length,
              itemBuilder: (context, index) {
                final suggestion = suggestions[index];
                return ListTile(
                  title: Text(
                    suggestion.title,
                    style: const TextStyle(
                      fontSize: 26.0,
                    ),
                  ),
                  onTap: () {
                    // Atualizar a consulta de pesquisa com o título da sugestão
                    query = suggestion.title;
                    // Realizar a pesquisa de resultados quando a sugestão for selecionada
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Infos(titulo: suggestion.title),
                      ),
                    );
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
                child: Text(AppLocalizations.of(context).erro_sugestao));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      );
    }
  }
}
