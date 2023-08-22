import 'package:telas2/components/task.dart';
import 'package:telas2/data/database.dart';
import 'package:sqflite/sqflite.dart';

class TaskDAO {
  static const String tableSql = 'CREATE TABLE $_tablename('
      '$_title TEXT, '
      '$_date TEXT, '
      '$_hour TEXT, '
      '$_local TEXT, '
      '$_description TEXT, '
      '$_contact TEXT, '
      '$_name TEXT)';

  static const String _tablename = 'taskTable';
  static const String _title = 'title';
  static const String _date = 'date';
  static const String _hour = 'hour';
  static const String _local = 'local';
  static const String _description = 'description';
  static const String _contact = 'contact';
  static const String _name = 'name';

  save(Task tarefa) async {
    final Database bancoDeDados = await getDatabase();
    var itemExist = await find(tarefa.titulo);
    Map<String, dynamic> taskMap = toMap(tarefa);
    if (itemExist.isEmpty) {
      return await bancoDeDados.insert(_tablename, taskMap);
    } else {
      return await bancoDeDados.update(
        _tablename,
        taskMap,
        where: '$_title = ?',
        whereArgs: [tarefa.titulo],
      );
    }
  }

  Map<String, dynamic> toMap(Task tarefa) {
    final Map<String, dynamic> mapaDeTarefas = Map();
    mapaDeTarefas[_title] = tarefa.titulo;
    mapaDeTarefas[_date] = tarefa.data;
    mapaDeTarefas[_hour] = tarefa.hora;
    mapaDeTarefas[_local] = tarefa.local;
    mapaDeTarefas[_description] = tarefa.descricao;
    mapaDeTarefas[_contact] = tarefa.contato;
    mapaDeTarefas[_name] = tarefa.nome;
    return mapaDeTarefas;
  }

  Future<List<Task>> findAll() async {
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result =
    await bancoDeDados.query(_tablename);
    return toList(result);
  }

  List<Task> toList(List<Map<String, dynamic>> mapaDeTarefas) {
    final List<Task> tarefas = [];
    for (Map<String, dynamic> linha in mapaDeTarefas) {
      final Task tarefa = Task(
        linha[_title],
        linha[_date],
        linha[_hour],
        linha[_local],
        linha[_description],
        linha[_contact],
        linha[_name],
      );
      tarefas.add(tarefa);
    }
    return tarefas;
  }

  Future<List<Task>> find(String nomeDaTarefa) async {
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result = await bancoDeDados.query(
      _tablename,
      where: '$_title = ?',
      whereArgs: [nomeDaTarefa],
    );
    return toList(result);
  }

  Future<List<Task>> findByMonthAndYear(String year, String month) async {
    final Database bancoDeDados = await getDatabase();

    final String dataInit = year + "-" + month + "-01";
    final String dataFinal = year + "-" + month + "-" + ultimoDia(month);

    final List<Map<String, dynamic>> result = await bancoDeDados.query(
      _tablename,
      where: '$_date >= ? AND $_date <= ?',
      whereArgs: [dataInit, dataFinal],
    );

    return toList(result);
  }

  delete(String nomeDaTarefa) async {
    final Database bancoDeDados = await getDatabase();
    return await bancoDeDados.delete(
      _tablename,
      where: '$_title = ?',
      whereArgs: [nomeDaTarefa],
    );
  }
}

String ultimoDia(String month){
  switch(month){
    case "01":
      return "31";
    case "02":
      return "28";
    case "03":
      return "31";
    case "04":
      return "30";
    case "05":
      return "31";
    case "06":
      return "30";
    case "07":
      return "31";
    case "08":
      return "31";
    case "09":
      return "30";
    case "10":
      return "31";
    case "11":
      return "30";
    case "12":
      return "31";
  }
  return "";
}
