import 'package:blogpost/module/auth/domain/dependency/i_token_manager.dart';
import 'package:blogpost/module/auth/domain/dependency/i_auth_service.dart';

class AuthInteractor {

  final ITokenManager _tokenManager;
  final IAuthService _authService;

  const AuthInteractor(this._tokenManager, this._authService);

  Future<bool> signIn(String email, String password) async {
    try {
      final token = await _authService.signIn(email, password);
      if(token != null){
        _tokenManager.saveToken(token);
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
      final token = await _authService.signUp(email, password);
      if(token != null){
        _tokenManager.saveToken(token);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
    _tokenManager.deleteToken();
  }

  bool checkAuthorization() {
    return _tokenManager.hasToken();
  }
}