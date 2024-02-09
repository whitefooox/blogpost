abstract class IPinRepository {
  bool hasPin();
  void savePin(String pin);
  void deletePin();
  String? getPin();
}