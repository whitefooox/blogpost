// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CreatePostModel {
  final String title;
  final String content;
  final bool isPublished;
  final String imageUrl;
  CreatePostModel({
    required this.title,
    required this.content,
    required this.isPublished,
    required this.imageUrl,
  });

  CreatePostModel copyWith({
    String? title,
    String? content,
    bool? isPublished,
    String? imageUrl,
  }) {
    return CreatePostModel(
      title: title ?? this.title,
      content: content ?? this.content,
      isPublished: isPublished ?? this.isPublished,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'content': content,
      'isPublished': isPublished,
      'imageUrl': imageUrl,
    };
  }

  factory CreatePostModel.fromMap(Map<String, dynamic> map) {
    return CreatePostModel(
      title: map['title'] as String,
      content: map['content'] as String,
      isPublished: map['isPublished'] as bool,
      imageUrl: map['imageUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CreatePostModel.fromJson(String source) => CreatePostModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CreatePostModel(title: $title, content: $content, isPublished: $isPublished, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(covariant CreatePostModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.title == title &&
      other.content == content &&
      other.isPublished == isPublished &&
      other.imageUrl == imageUrl;
  }

  @override
  int get hashCode {
    return title.hashCode ^
      content.hashCode ^
      isPublished.hashCode ^
      imageUrl.hashCode;
  }
}
