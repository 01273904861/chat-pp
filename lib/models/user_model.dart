class UserModel {
  final String name;
  final String number;
  final String id;
  final String image;
  final String username;
  final String email;


  UserModel(
      {required this.name,
      required this.number,
      required this.username,
      required this.id,
      required this.email,
      required this.image});

  factory UserModel.from(userJson) {
    return UserModel(
        name: userJson['name'],
        number: userJson['number'],
        id: userJson['id'],
        email: userJson['email'],
        username: userJson['username'],
        image: 'image');
  }
}
