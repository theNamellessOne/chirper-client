class User {
  final String username;
  final String firstName;

  final String password;
  final String? lastName;

  const User({
    required this.username,
    required this.password,
    required this.firstName,
    this.lastName,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      password: json['password'],
      firstName: json['firstName'],
      lastName: json['lastName'],
    );
  }
}
