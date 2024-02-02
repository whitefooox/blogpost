import 'package:blogpost/feautures/auth/domain/dependency/i_token_manager.dart';
import 'package:blogpost/feautures/auth/domain/dependency/i_auth_service.dart';

class AuthInteractor {

  final ITokenManager tokenManager;
  final IAuthService authService;

  const AuthInteractor({
    required this.tokenManager,
    required this.authService
  });

  Future<bool> signIn(String email, String password) async {
    try {
      final token = await authService.signIn(email, password);
      if(token != null){
        tokenManager.saveToken(token);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> signUp(String email, String password) async {
    try {
      final token = await authService.signUp(email, password);
      if(token != null){
        tokenManager.saveToken(token);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> checkAuthorization() async {
    return tokenManager.hasToken();
  }
}