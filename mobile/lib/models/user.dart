class User {
  final int id;
  final String first_name;
  final String last_name;
  final String imageUrl;
  final String email;
  final String password;
  
  const User (this.id, this.first_name, this.last_name, this.imageUrl, this.email, this.password);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': first_name,
      'lastName': last_name,
      'imageUrl': imageUrl,
      'email': email
    };
  }

  @override
  String toString() {
    return 'User {id: $id,firstName: $first_name,lastName: $last_name,imageUrl: $imageUrl,email: $email}';
  }
}