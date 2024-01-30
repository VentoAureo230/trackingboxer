class User {
  final int id;
  final String firstName;
  final String lastName;
  final String profileUrl;
  final String email;
  final String password;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.profileUrl,
    required this.email,
    required this.password,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      firstName: map['first_name'],
      lastName: map['last_name'],
      profileUrl: map['profileUrl'],
      email: map['email'],
      password: map['password'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'profileUrl': profileUrl,
      'email': email,
      'password': password,
    };
  }
}
