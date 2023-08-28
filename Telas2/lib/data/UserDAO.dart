import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import 'User.dart';

//Classe DAO de usuario
class UserDAO {
  //Cria um user
  Future<User> createUser(String name, String email, String password) async {
    const uuid = Uuid();
    String uuidv4 = uuid.v4();
    final response = await http.post(
      Uri.parse('http://10.0.2.2:3000/user'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'id': uuidv4,
        'name': name,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return User.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 409) {
      //Email já cadastrado
      return User.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create user.');
    }
  }

  // //Procurar todos os users
  // Future<List<User>> fetchAllUser() async {
  //   final response = await http.get(Uri.parse('http://10.0.2.2:3000/user'));

  //   if (response.statusCode == 200) {
  //     // If the server did return a 200 OK response,
  //     // then parse the JSON.
  //     final List<dynamic> usersList = jsonDecode(response.body);
  //     return usersList.map((userMap) => User.fromJson(userMap)).toList();
  //   } else {
  //     // If the server did not return a 200 OK response,
  //     // then throw an exception.
  //     throw Exception('Failed to load user');
  //   }
  // }

  // //Procurar todos os users com um titulo
  // Future<List<User>> fetchAllUserTitle(String name) async {
  //  // print("O nome pegou:" + name);
  //   final response =
  //       await http.get(Uri.parse('http://10.0.2.2:3000/user?name=$name'));
  //   print("Status response");
  //   print(response.statusCode);
  //   if (response.statusCode == 200) {
  //     // If the server did return a 200 OK response,
  //     // then parse the JSON.

  //     final List<dynamic> usersList = jsonDecode(response.body);
  //     return usersList.map((userMap) => User.fromJson(userMap)).toList();
  //   } else {
  //     // If the server did not return a 200 OK response,
  //     // then throw an exception.
  //     throw Exception('Failed to load user');
  //   }
  // }

  // //Procurar um user pelo email
  // Future<User> fetchUser(String email) async {
  //   final response =
  //       await http.get(Uri.parse('http://10.0.2.2:3000/user?email=$email'));

  //   if (response.statusCode == 200) {
  //     // If the server did return a 200 OK response,
  //     // then parse the JSON.
  //     return User.fromJson(jsonDecode(response.body));
  //   } else {
  //     // If the server did not return a 200 OK response,
  //     // then throw an exception.
  //     throw Exception('Failed to load user');
  //   }
  // }

  // Future<http.Response> updateAlbum(String name) {
  //   return http.put(
  //     Uri.parse('http://10.0.2.2:3000/user/'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(<String, String>{
  //       'name': name,
  //     }),
  //   );
  // }

  //Deletar um usero pelo id
  // Future<http.Response> deleteUser(String id) async {
  //   final http.Response response = await http.delete(
  //     Uri.parse('https://jsonplaceholder.typicode.com/albums/$id'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //   );

  //   return response;
  // }

  // //Recuperar todos os useros
  // Future<List<User>> findAll() async {
  //   late Future<User> futureUser;
  //   futureUser = fetchAllUser();
  //   final List<Map<String, dynamic>> result = futureUser;
  //   return toList(result);
  // }

  // //Lista de useros
  // List<User> toList(List<Map<String, dynamic>> mapaDeUsers) {
  //   final List<User> users = [];
  //   for (Map<String, dynamic> linha in mapaDeUsers) {
  //     final User user = User(
  //       linha[name],
  //       linha[date],
  //       linha[hour],
  //       linha[local],
  //       linha[description],
  //       linha[contact],
  //       linha[contactname],
  //     );
  //     users.add(user);
  //   }
  //   return users;
  // }

//   Future<List<User>> find(String nomeDoUser) async {
//     late Future<User> futureUser;
//     futureUser = fetchUser(nomeDoUser);
//     final List<Map<String, dynamic>> result = futureUser;
//     return toList(result);
//   }

  Future<List<User>> findByEmailAndPassword(
      String email, String password) async {
    final response = await http.get(
        Uri.parse('http://10.0.2.2:3000/user?email=$email&password=$password'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final List<dynamic> usersList = jsonDecode(response.body);
      return usersList.map((userMap) => User.fromJson(userMap)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load user');
    }
  }
}
