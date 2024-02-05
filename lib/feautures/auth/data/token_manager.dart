import 'package:blogpost/feautures/auth/domain/dependency/i_token_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenManager implements ITokenManager {

  final SharedPreferences prefs;
  String tokenKey = "token";

  TokenManager({
    required this.prefs
  });
  
  @override
  bool hasToken() {
    return prefs.containsKey(tokenKey);
  }
  
  @override
  void deleteToken() async {
    await prefs.remove(tokenKey);
  }
  
  @override
  void saveToken(String token) async {
    await prefs.setString(tokenKey, token);
  }
}