class User {
  final int id;
  final String username;
  final String email;
  final String password;

  const User({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toMap(User user) {
    final Map<String, dynamic> mapaDeUsers = {};
    mapaDeUsers[username] = user.username;
    mapaDeUsers[email] = user.email;
    mapaDeUsers[password] = user.password;
    return mapaDeUsers;
  }
}
