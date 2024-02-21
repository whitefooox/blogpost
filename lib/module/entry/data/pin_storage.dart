import 'package:blogpost/module/entry/domain/dependency/i_pin_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PinStorage implements IPinRepository {
  final SharedPreferences _prefs;
  final String _pinKey = "pin";

  PinStorage(this._prefs);
  
  @override
  void deletePin() async {
    await _prefs.remove(_pinKey);
  }
  
  @override
  String? getPin() {
    return _prefs.getString(_pinKey);
  }
  
  @override
  void savePin(String pin) async {
    await _prefs.setString(_pinKey, pin);
  }
  
  @override
  bool hasPin() {
    return _prefs.containsKey(_pinKey);
  }
}