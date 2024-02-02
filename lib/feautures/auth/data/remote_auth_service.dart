import 'package:blogpost/feautures/auth/domain/dependency/i_auth_service.dart';
import 'package:blogpost/feautures/auth/domain/exception/auth_exception.dart';

class RemoteAuthService implements IAuthService {
  @override
  Future<String?> signIn(String email, String password) async {
    await Future.delayed(Duration(seconds: 3));
    if(email == "test@test.test" && password == "12345678"){
      return "this_is_test_token";
    } else if(email == "test@test.test"){
      throw AuthException(message: "Error in auth service");
    } else {
      return null;
    }
  }

  @override
  Future<String?> signUp(String email, String password) async {
    await Future.delayed(Duration(seconds: 3));
    if(email == "test@test.test" && password == "12345678"){
      return "this_is_test_token";
    } else if(email == "test@test.test"){
      throw AuthException(message: "Error in auth service");
    } else {
      return null;
    }
  }
}