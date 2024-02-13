import 'package:blogpost/module/post/domain/entity/comment.dart';

class Post {
  final String id;
  final String title;
  final String image;
  final int authorId;
  final String authorName;
  final String authorAvatar;
  final DateTime date;
  final int likesCount;
  final bool isLiked; //поставлен лайк или нет
  final int commentsCount;
  final List<Comment>? comments;
  final String? textContent;

  Post({
    required this.id,
    required this.title, 
    required this.image, 
    required this.authorId,
    required this.authorName, 
    required this.authorAvatar, 
    required this.date, 
    required this.isLiked,
    required this.likesCount, 
    required this.commentsCount,
    this.textContent,
    this.comments
  });

  Post copyWith({
    String? id,
    String? title,
    String? image,
    int? authorId,
    String? authorName,
    String? authorAvatar,
    DateTime? date,
    int? likesCount,
    bool? isLiked,
    int? commentsCount,
    List<Comment>? comments,
    String? textContent,
  }) {
    return Post(
      id: id ?? this.id,
      title: title ?? this.title,
      image: image ?? this.image,
      authorId: authorId ?? this.authorId,
      authorName: authorName ?? this.authorName,
      authorAvatar: authorAvatar ?? this.authorAvatar,
      date: date ?? this.date,
      likesCount: likesCount ?? this.likesCount,
      isLiked: isLiked ?? this.isLiked,
      commentsCount: commentsCount ?? this.commentsCount,
      comments: comments ?? this.comments,
      textContent: textContent ?? this.textContent,
    );
  }
}
