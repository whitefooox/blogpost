import 'package:blogpost/feautures/auth/domain/dependency/i_token_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenManager implements ITokenManager {

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String tokenKey = "token";
  
  @override
  Future<bool> hasToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(tokenKey);
  }
  
  @override
  void deleteToken() async {
    final SharedPreferences prefs = await _prefs;
    await prefs.remove(tokenKey);
  }
  
  @override
  void saveToken(String token) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setString(tokenKey, token);
  }
}