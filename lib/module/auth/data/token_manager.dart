import 'package:blogpost/module/auth/domain/dependency/i_token_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenManager implements ITokenManager {

  final SharedPreferences _prefs;
  String tokenKey = "token";

  TokenManager(this._prefs);
  
  @override
  bool hasToken() {
    return _prefs.containsKey(tokenKey);
  }
  
  @override
  void deleteToken() async {
    await _prefs.remove(tokenKey);
  }
  
  @override
  void saveToken(String token) async {
    await _prefs.setString(tokenKey, token);
  }
}