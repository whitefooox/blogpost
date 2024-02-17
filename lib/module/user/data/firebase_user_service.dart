import 'dart:developer';

import 'package:blogpost/module/user/domain/dependency/i_user_service.dart';
import 'package:blogpost/module/user/domain/entity/user.dart' as domain;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseUserService implements IUserService {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final String nameUsersCollection = "users";

  FirebaseUserService();

  @override
  Future<void> createUser(domain.User user) async {
    DocumentSnapshot doc = await _firebaseFirestore.collection(nameUsersCollection).doc(user.id!).get();
    if (!doc.exists) {
      _firebaseFirestore.collection(nameUsersCollection).doc(user.id!).set(user.toMap());
    }
  }
  
  @override
  Future<void> deleteUser() async {
    try {
      await _firebaseFirestore.collection(nameUsersCollection).doc(_firebaseAuth.currentUser!.uid).delete();
      await _firebaseAuth.currentUser!.delete();
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<domain.User> getUser() async {
    var user = domain.User(email: _firebaseAuth.currentUser!.email!);
    final snapshot = await _firebaseFirestore.collection(nameUsersCollection).doc(_firebaseAuth.currentUser!.uid).get();
    if(snapshot.exists){
      user = domain.User.fromMap(snapshot.data()!);
    }
    return user;
  }
  
  @override
  Future<void> updateUser(domain.User user) async {
    try {
      await _firebaseFirestore.collection(nameUsersCollection).doc(user.id).update(user.toMap());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}