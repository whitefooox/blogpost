import 'package:blogpost/module/auth/domain/dependency/i_auth_service.dart';

class AuthInteractor {

  final IAuthService _authService;

  const AuthInteractor(this._authService);

  Future<void> signIn(String email, String password) async {
    try {
      await _authService.signIn(email, password);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signUp(String email, String password) async {
    try {
      await _authService.signUp(email, password);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
  }

  bool checkAuthorization() {
    return _authService.checkAuthorization();
  }
}