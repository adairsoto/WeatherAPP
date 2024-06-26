class User {
  final int? id;
  final String username;
  final String password;

  const User({this.id, required this.username, required this.password});

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'],
    username: json['username'],
    password: json['password']
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'username': username,
    'password': password,
  };
}