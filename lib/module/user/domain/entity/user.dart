class User {
  final int id;
  final String email;
  final String? name;
  final String? surname;
  final String? avatarImage;

  User({
    required this.id,
    required this.email, 
    this.name, 
    this.surname, 
    this.avatarImage
  });
}