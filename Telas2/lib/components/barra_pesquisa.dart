import 'package:flutter/material.dart';
import 'package:telas2/components/task.dart';
import 'package:telas2/data/task_dao.dart';
import 'package:telas2/screens/infos.dart';

class BarraPesquisa extends StatefulWidget {
  const BarraPesquisa({super.key});

  @override
  State<BarraPesquisa> createState() => _BarraPesquisaState();
}

class _BarraPesquisaState extends State<BarraPesquisa> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.search),
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
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, query);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return Center(
        child: Text('Por favor, insira uma consulta de pesquisa.'),
      );
    }
    // Implemente a lógica de pesquisa e exiba os resultados reais aqui
    // Quando a pesquisa estiver concluída, chame Navigator.pop para voltar à tela anterior
    // Por exemplo:
    /*Future.delayed(Duration(milliseconds: 500), () {
      Navigator.pop(context);
    });*/

    close(context, query);

    return Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Center(
        child: Text('Sugestões de pesquisa'),
      );
    } else {
      // Chamar o método 'find' do DAO e obter as sugestões de tarefas
      final taskDao = TaskDAO();
      return FutureBuilder<List<Task>>(
        future: taskDao.find(query),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final suggestions = snapshot.data!;
            return ListView.builder(
              itemCount: suggestions.length,
              itemBuilder: (context, index) {
                final suggestion = suggestions[index];
                return ListTile(
                  title: Text(
                    suggestion.titulo,
                    style: TextStyle(
                      fontSize: 26.0,
                    ),
                  ),
                  onTap: () {
                    // Atualizar a consulta de pesquisa com o título da sugestão
                    query = suggestion.titulo;
                    // Realizar a pesquisa de resultados quando a sugestão for selecionada
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Infos(titulo: suggestion.titulo),
                      ),
                    );
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao buscar sugestões.'));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      );
    }
  }
}
