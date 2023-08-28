import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import 'Event.dart';

// class Event {
//   final int id;
//   final String title;
//   final String day;
//   final String month;
//   final String year;
//   final String hour;
//   final String local;
//   final String description;
//   final String contact;
//   final String contactname;

//   const Event({
//     required this.id,
//     required this.title,
//     required this.day,
//     required this.month,
//     required this.year,
//     required this.hour,
//     required this.local,
//     required this.description,
//     required this.contact,
//     required this.contactname,
//   });

//   factory Event.fromJson(Map<String, dynamic> json) {
//     return Event(
//       id: json['id'],
//       title: json['title'],
//       day: json['day'],
//       month: json['month'],
//       year: json['year'],
//       hour: json['hour'],
//       local: json['local'],
//       description: json['description'],
//       contact: json['contact'],
//       contactname: json['contactname'],
//     );
//   }

//   Map<String, dynamic> toMap(Event event) {
//     final Map<String, dynamic> mapaDeEventos = Map();
//     mapaDeEventos[title] = event.title;
//     mapaDeEventos[day] = event.day;
//     mapaDeEventos[month] = event.month;
//     mapaDeEventos[year] = event.year;
//     mapaDeEventos[hour] = event.hour;
//     mapaDeEventos[local] = event.local;
//     mapaDeEventos[description] = event.description;
//     mapaDeEventos[contact] = event.contact;
//     mapaDeEventos[contactname] = event.contactname;
//     return mapaDeEventos;
//   }
// }

class EventDAO {
  //Cria um evento
  Future<Event> createEvent(
      String title,
      String day,
      String month,
      String year,
      String hour,
      String local,
      String description,
      String contact,
      String contactname) async {
    const uuid = Uuid();
    String uuidv4 = uuid.v4();
    final response = await http.post(
      Uri.parse('http://10.0.2.2:3000/event'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'id': uuidv4,
        'title': title,
        'day': day,
        'month': month,
        'year': year,
        'hour': hour,
        'local': local,
        'description': description,
        'contact': contact,
        'contactname': contactname,
      }),
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return Event.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create event.');
    }
  }

  //Procurar todos os eventos
  Future<List<Event>> fetchAllEvent() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:3000/event'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final List<dynamic> eventsList = jsonDecode(response.body);
      return eventsList.map((eventMap) => Event.fromJson(eventMap)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load event');
    }
  }

  //Procurar todos os eventos com um titulo
  Future<List<Event>> fetchAllEventTitle(String title) async {
    print("O titulo pegou:" + title);
    final response =
        await http.get(Uri.parse('http://10.0.2.2:3000/event?title=$title'));
    print("Status response");
    print(response.statusCode);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      final List<dynamic> eventsList = jsonDecode(response.body);
      return eventsList.map((eventMap) => Event.fromJson(eventMap)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load event');
    }
  }

  //Procurar um evento pelo título
  Future<Event> fetchEvent(String title) async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:3000/event?title=$title'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Event.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load event');
    }
  }

  // Future<http.Response> updateAlbum(String title) {
  //   return http.put(
  //     Uri.parse('http://10.0.2.2:3000/event/'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(<String, String>{
  //       'title': title,
  //     }),
  //   );
  // }

  //Deletar um evento pelo id
  // Future<http.Response> deleteEvent(String id) async {
  //   final http.Response response = await http.delete(
  //     Uri.parse('https://jsonplaceholder.typicode.com/albums/$id'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //   );

  //   return response;
  // }

  // //Recuperar todos os eventos
  // Future<List<Event>> findAll() async {
  //   late Future<Event> futureEvent;
  //   futureEvent = fetchAllEvent();
  //   final List<Map<String, dynamic>> result = futureEvent;
  //   return toList(result);
  // }

  // //Lista de eventos
  // List<Event> toList(List<Map<String, dynamic>> mapaDeEventos) {
  //   final List<Event> events = [];
  //   for (Map<String, dynamic> linha in mapaDeEventos) {
  //     final Event event = Event(
  //       linha[title],
  //       linha[date],
  //       linha[hour],
  //       linha[local],
  //       linha[description],
  //       linha[contact],
  //       linha[contactname],
  //     );
  //     events.add(event);
  //   }
  //   return events;
  // }

//   Future<List<Event>> find(String nomeDoEvento) async {
//     late Future<Event> futureEvent;
//     futureEvent = fetchEvent(nomeDoEvento);
//     final List<Map<String, dynamic>> result = futureEvent;
//     return toList(result);
//   }

  Future<List<Event>> findByMonthAndYear(String year, String month) async {
    // final String dataInit = "$year-$month-01";
    // final String dataFinal = "$year-$month-${ultimoDia(month)}";

    final response = await http
        .get(Uri.parse('http://10.0.2.2:3000/event?month=$month&year=$year'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final List<dynamic> eventsList = jsonDecode(response.body);
      return eventsList.map((eventMap) => Event.fromJson(eventMap)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load event');
    }

    // final List<Map<String, dynamic>> result = await bancoDeDados.query(
    //   _tablename,
    //   where: '$date >= ? AND $date <= ?',
    //   whereArgs: [dataInit, dataFinal],
    // );
    //return toList(result);
  }

  // delete(String nomeDoEvento) async {
  //   late Future<Event> futureEvent;
  //   futureEvent = fetchEvent(nomeDoEvento);
  //   futureEvent = deleteEvent(nomeDoEvento);
  //   return futureEvent;
  // }
}

/*String ultimoDia(String month) {
  switch (month) {
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
}*/
