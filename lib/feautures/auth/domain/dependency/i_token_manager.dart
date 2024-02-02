abstract class ITokenManager {
  Future<bool> hasToken();
  void saveToken(String token);
  void deleteToken();
}