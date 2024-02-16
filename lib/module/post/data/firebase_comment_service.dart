import 'dart:developer';

import 'package:blogpost/core/exception/app_exception.dart';
import 'package:blogpost/module/post/domain/dependency/i_comment_service.dart';
import 'package:blogpost/module/post/domain/entity/comment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:blogpost/module/user/domain/entity/user.dart' as domain;

class FirebaseCommentService implements ICommentService {

  final _firebaseAuth = FirebaseAuth.instance;
  final _firebaseFirestore = FirebaseFirestore.instance;

  final String namePostCollection = 'posts';
  final String nameUsersCollection = 'users';
  final String nameCommentsCollection = 'comments';

  Future<domain.User?> _getUser() async {
    try {
      var user = domain.User(email: _firebaseAuth.currentUser!.email!);
      final snapshot = await _firebaseFirestore.collection(nameUsersCollection).doc(_firebaseAuth.currentUser!.uid).get();
      if(snapshot.exists){
        user = domain.User.fromMap(snapshot.data()!);
      }
      return user;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  @override
  Future<void> addComment(String postId, String text) async {
    try {
      final user = await _getUser();
      await _firebaseFirestore.collection(nameCommentsCollection).add(Comment(
        postId: postId, 
        createdAt: DateTime.now(), 
        text: text,
        name: user!.name,
        surname: user.surname
      ).toMap());
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<List<Comment>> getComments(String postId) async {
    try {
      final querySnapshot = await _firebaseFirestore.collection(nameCommentsCollection).where('postId', isEqualTo: postId).get();
      final comments = querySnapshot.docs.map((doc) {
        return Comment.fromMap(doc.data());
      }).toList();
      return comments..sort((a, b) => a.createdAt.compareTo(b.createdAt));
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
  
  /*
  Stream<List<Comment>> getStreamComments(String postId) {
    final streamOfShapshots = _firebaseFirestore.collection(nameCommentsCollection).where('postId', isEqualTo: postId).snapshots();
    return streamOfShapshots.map((shapshot) {
      return shapshot.docs.map((doc) {
        return Comment.fromMap(doc.data());
      }).toList();
    });
  }
  */
}