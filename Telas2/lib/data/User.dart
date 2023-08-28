class User {
  final int id;
  final String name;
  final String email;
  final String password;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toMap(User event) {
    final Map<String, dynamic> mapaDeUsers = Map();
    mapaDeUsers[name] = event.name;
    mapaDeUsers[email] = event.email;
    mapaDeUsers[password] = event.password;
    return mapaDeUsers;
  }
}