class User {
  final int id;
  final String firstName;
  final String lastName;
  final String imageUrl;
  
  const User (this.id, this.firstName, this.lastName, this.imageUrl);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'imageUrl': imageUrl,
    };
  }

  @override
  String toString() {
    return 'User {id: $id,firstName: $firstName,lastName: $lastName,imageUrl: $imageUrl}';
  }
}