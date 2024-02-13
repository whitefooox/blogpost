class Comment {
  final String postId;
  final String name;
  final String surname;
  final DateTime createdAt;
  final String text;

  Comment({
    required this.postId,
    required this.name, 
    required this.surname, 
    required this.createdAt, 
    required this.text
  });
}