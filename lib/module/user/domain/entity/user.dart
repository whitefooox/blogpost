// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  final String? id;
  final String email;
  final String? name;
  final String? surname;
  final String? avatarImage;

  User({
    required this.email, 
    this.name, 
    this.surname, 
    this.avatarImage,
    this.id
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'name': name,
      'surname': surname,
      'avatarImage': avatarImage,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] != null ? map['id'] as String : null,
      email: map['email'] as String,
      name: map['name'] != null ? map['name'] as String : null,
      surname: map['surname'] != null ? map['surname'] as String : null,
      avatarImage: map['avatarImage'] != null ? map['avatarImage'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source) as Map<String, dynamic>);

  User copyWith({
    String? id,
    String? email,
    String? name,
    String? surname,
    String? avatarImage,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      avatarImage: avatarImage ?? this.avatarImage,
    );
  }

  @override
  String toString() {
    return 'User(id: $id, email: $email, name: $name, surname: $surname, avatarImage: $avatarImage)';
  }
}
