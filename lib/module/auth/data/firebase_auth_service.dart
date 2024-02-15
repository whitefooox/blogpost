import 'dart:developer';

import 'package:blogpost/core/exception/app_exception.dart';
import 'package:blogpost/module/auth/domain/dependency/i_auth_service.dart';
import 'package:blogpost/module/user/domain/dependency/i_user_service.dart';
import 'package:blogpost/module/user/domain/entity/user.dart' as domain;
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService implements IAuthService {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final IUserService _firebaseUserService;

  FirebaseAuthService(this._firebaseUserService);

  @override
  Future<void> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      log(e.toString());
      throw AppException(message: "Error in auth service");
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<void> signUp(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      await _firebaseUserService.createUser(domain.User(
        email: email, 
        id: _firebaseAuth.currentUser!.uid,
      ));
    } catch (e) {
      log(e.toString());
      throw AppException(message: "Error in auth service");
    }
  }
  
  @override
  bool checkAuthorization() {
    return (_firebaseAuth.currentUser != null);
  } 
}