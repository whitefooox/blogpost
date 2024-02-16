// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Comment {
  final String postId;
  final String? name;
  final String? surname;
  final DateTime createdAt;
  final String text;
  Comment({
    required this.postId,
    this.name,
    this.surname,
    required this.createdAt,
    required this.text,
  });

  Comment copyWith({
    String? postId,
    String? name,
    String? surname,
    DateTime? createdAt,
    String? text,
  }) {
    return Comment(
      postId: postId ?? this.postId,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      createdAt: createdAt ?? this.createdAt,
      text: text ?? this.text,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'postId': postId,
      'name': name,
      'surname': surname,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'text': text,
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      postId: map['postId'] as String,
      name: map['name'] != null ? map['name'] as String : null,
      surname: map['surname'] != null ? map['surname'] as String : null,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      text: map['text'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Comment.fromJson(String source) => Comment.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Comment(postId: $postId, name: $name, surname: $surname, createdAt: $createdAt, text: $text)';
  }

  @override
  bool operator ==(covariant Comment other) {
    if (identical(this, other)) return true;
  
    return 
      other.postId == postId &&
      other.name == name &&
      other.surname == surname &&
      other.createdAt == createdAt &&
      other.text == text;
  }

  @override
  int get hashCode {
    return postId.hashCode ^
      name.hashCode ^
      surname.hashCode ^
      createdAt.hashCode ^
      text.hashCode;
  }
}
