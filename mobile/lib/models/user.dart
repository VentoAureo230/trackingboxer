class User {
  final int? id;
  final String firstName;
  final String lastName;
  final String profileUrl;
  final String? email;
  final String? password;

  User({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.profileUrl,
    this.email,
    this.password,
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
  var map = {
    'first_name': firstName,
    'last_name': lastName,
    'profileUrl': profileUrl,
    'email': email,
    'password': password,
  };

  if (id != null && id != 0) {
    map['id'] = id as String;
  }

  return map;
}
}