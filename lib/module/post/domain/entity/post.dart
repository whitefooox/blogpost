// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'package:blogpost/module/post/domain/entity/comment.dart';

class Post {
  final String id;
  final String title;
  final String imageUrl;
  final String? authorId;
  final String? authorName;
  final String? authorAvatar;
  final DateTime? createdAt;
  final int? likesCount;
  final bool? isLiked;
  final bool? isPublished;
  final int? commentsCount;
  final String? content;
  Post({
    required this.id,
    required this.title,
    required this.imageUrl,
    this.authorId,
    this.authorName,
    this.authorAvatar,
    this.createdAt,
    this.likesCount,
    this.isLiked,
    this.isPublished,
    this.commentsCount,
    this.content,
  });

  Post copyWith({
    String? id,
    String? title,
    String? imageUrl,
    String? authorId,
    String? authorName,
    String? authorAvatar,
    DateTime? createdAt,
    int? likesCount,
    bool? isLiked,
    bool? isPublished,
    int? commentsCount,
    String? content,
  }) {
    return Post(
      id: id ?? this.id,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      authorId: authorId ?? this.authorId,
      authorName: authorName ?? this.authorName,
      authorAvatar: authorAvatar ?? this.authorAvatar,
      createdAt: createdAt ?? this.createdAt,
      likesCount: likesCount ?? this.likesCount,
      isLiked: isLiked ?? this.isLiked,
      isPublished: isPublished ?? this.isPublished,
      commentsCount: commentsCount ?? this.commentsCount,
      content: content ?? this.content,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'imageUrl': imageUrl,
      'authorId': authorId,
      'authorName': authorName,
      'authorAvatar': authorAvatar,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'likesCount': likesCount,
      'isLiked': isLiked,
      'isPublished': isPublished,
      'commentsCount': commentsCount,
      'content': content,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['id'] as String,
      title: map['title'] as String,
      imageUrl: map['imageUrl'] as String,
      authorId: map['authorId'] != null ? map['authorId'] as String : null,
      authorName: map['authorName'] != null ? map['authorName'] as String : null,
      authorAvatar: map['authorAvatar'] != null ? map['authorAvatar'] as String : null,
      createdAt: map['createdAt'] != null ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int) : null,
      likesCount: map['likesCount'] != null ? map['likesCount'] as int : null,
      isLiked: map['isLiked'] != null ? map['isLiked'] as bool : null,
      isPublished: map['isPublished'] != null ? map['isPublished'] as bool : null,
      commentsCount: map['commentsCount'] != null ? map['commentsCount'] as int : null,
      content: map['content'] != null ? map['content'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) => Post.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Post(id: $id, title: $title, imageUrl: $imageUrl, authorId: $authorId, authorName: $authorName, authorAvatar: $authorAvatar, createdAt: $createdAt, likesCount: $likesCount, isLiked: $isLiked, isPublished: $isPublished, commentsCount: $commentsCount, content: $content)';
  }

  @override
  bool operator ==(covariant Post other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.title == title &&
      other.imageUrl == imageUrl &&
      other.authorId == authorId &&
      other.authorName == authorName &&
      other.authorAvatar == authorAvatar &&
      other.createdAt == createdAt &&
      other.likesCount == likesCount &&
      other.isLiked == isLiked &&
      other.isPublished == isPublished &&
      other.commentsCount == commentsCount &&
      other.content == content;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      imageUrl.hashCode ^
      authorId.hashCode ^
      authorName.hashCode ^
      authorAvatar.hashCode ^
      createdAt.hashCode ^
      likesCount.hashCode ^
      isLiked.hashCode ^
      isPublished.hashCode ^
      commentsCount.hashCode ^
      content.hashCode;
  }
}
