import 'package:blogpost/module/entry/domain/dependency/i_pin_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PinStorage implements IPinRepository {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String pinKey = "pin";
  
  @override
  void deletePin() async {
    final SharedPreferences prefs = await _prefs;
    await prefs.remove(pinKey);
  }
  
  @override
  Future<String?> getPin() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(pinKey);
  }
  
  @override
  void savePin(String pin) {
    // TODO: implement savePin
  }
}