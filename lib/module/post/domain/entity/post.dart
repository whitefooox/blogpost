import 'package:blogpost/module/post/domain/entity/comment.dart';

class Post {
  final int id;
  final String title;
  final String image;
  final String authorName;
  final String authorAvatar;
  final DateTime date;
  final int likesCount;
  final int commentsCount;
  final List<Comment>? comments;
  final String? textContent;

  Post({
    required this.id,
    required this.title, 
    required this.image, 
    required this.authorName, 
    required this.authorAvatar, 
    required this.date, 
    required this.likesCount, 
    required this.commentsCount,
    this.textContent,
    this.comments
  });
}