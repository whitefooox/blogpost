abstract class IPinRepository {
  void savePin(String pin);
  void deletePin();
  Future<String?> getPin();
}