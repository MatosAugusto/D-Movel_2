import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import 'Ticket.dart';

//Classe DAO de ticket
class TicketDAO {
  //Cria um ticket
  Future<Ticket> createTicket(
      String title,
      String day,
      String month,
      String year,
      String hour,
      String contact,
      String contactname,
      String email,
      String username) async {
    const uuid = Uuid();
    String uuidv4 = uuid.v4();
    final response = await http.post(
      Uri.parse('http://10.0.2.2:3000/ticket'),
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
        'contact': contact,
        'contactname': contactname,
        'email': email,
        'username': username
      }),
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return Ticket.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create ticket.');
    }
  }

  // //Procurar todos os tickets
  // Future<List<Ticket>> fetchAllTicket() async {
  //   final response = await http.get(Uri.parse('http://10.0.2.2:3000/ticket'));

  //   if (response.statusCode == 200) {
  //     // If the server did return a 200 OK response,
  //     // then parse the JSON.
  //     final List<dynamic> ticketsList = jsonDecode(response.body);
  //     return ticketsList.map((ticketMap) => Ticket.fromJson(ticketMap)).toList();
  //   } else {
  //     // If the server did not return a 200 OK response,
  //     // then throw an exception.
  //     throw Exception('Failed to load ticket');
  //   }
  // }

  // //Procurar todos os tickets com um titulo
  // Future<List<Ticket>> fetchAllTicketTitle(String title) async {
  //  // print("O nome pegou:" + title);
  //   final response =
  //       await http.get(Uri.parse('http://10.0.2.2:3000/ticket?title=$title'));
  //   print("Status response");
  //   print(response.statusCode);
  //   if (response.statusCode == 200) {
  //     // If the server did return a 200 OK response,
  //     // then parse the JSON.

  //     final List<dynamic> ticketsList = jsonDecode(response.body);
  //     return ticketsList.map((ticketMap) => Ticket.fromJson(ticketMap)).toList();
  //   } else {
  //     // If the server did not return a 200 OK response,
  //     // then throw an exception.
  //     throw Exception('Failed to load ticket');
  //   }
  // }

  // //Procurar um ticket pelo day
  // Future<Ticket> fetchTicket(String day) async {
  //   final response =
  //       await http.get(Uri.parse('http://10.0.2.2:3000/ticket?day=$day'));

  //   if (response.statusCode == 200) {
  //     // If the server did return a 200 OK response,
  //     // then parse the JSON.
  //     return Ticket.fromJson(jsonDecode(response.body));
  //   } else {
  //     // If the server did not return a 200 OK response,
  //     // then throw an exception.
  //     throw Exception('Failed to load ticket');
  //   }
  // }

  // Future<http.Response> updateAlbum(String title) {
  //   return http.put(
  //     Uri.parse('http://10.0.2.2:3000/ticket/'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(<String, String>{
  //       'title': title,
  //     }),
  //   );
  // }

  //Deletar um ticketo pelo id
  // Future<http.Response> deleteTicket(String id) async {
  //   final http.Response response = await http.delete(
  //     Uri.parse('https://jsonplaceholder.typicode.com/albums/$id'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //   );

  //   return response;
  // }

  // //Recuperar todos os ticketos
  // Future<List<Ticket>> findAll() async {
  //   late Future<Ticket> futureTicket;
  //   futureTicket = fetchAllTicket();
  //   final List<Map<String, dynamic>> result = futureTicket;
  //   return toList(result);
  // }

  // //Lista de ticketos
  // List<Ticket> toList(List<Map<String, dynamic>> mapaDeTickets) {
  //   final List<Ticket> tickets = [];
  //   for (Map<String, dynamic> linha in mapaDeTickets) {
  //     final Ticket ticket = Ticket(
  //       linha[title],
  //       linha[date],
  //       linha[hour],
  //       linha[local],
  //       linha[description],
  //       linha[contact],
  //       linha[contacttitle],
  //     );
  //     tickets.add(ticket);
  //   }
  //   return tickets;
  // }

//   Future<List<Ticket>> find(String nomeDoTicket) async {
//     late Future<Ticket> futureTicket;
//     futureTicket = fetchTicket(nomeDoTicket);
//     final List<Map<String, dynamic>> result = futureTicket;
//     return toList(result);
//   }

  //Retorna uma lista de tickets
  //TODO: Selecionar as datas corretas aqui também
  Future<List<Ticket>> findByEmail(String email) async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:3000/ticket?email=$email'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final List<dynamic> ticketsList = jsonDecode(response.body);
      return ticketsList
          .map((ticketMap) => Ticket.fromJson(ticketMap))
          .toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load ticket');
    }
  }
}
