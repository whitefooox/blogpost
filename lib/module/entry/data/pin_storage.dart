import 'package:blogpost/module/entry/domain/dependency/i_pin_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PinStorage implements IPinRepository {
  final SharedPreferences _prefs;
  String pinKey = "pin";

  PinStorage(this._prefs);
  
  @override
  void deletePin() async {
    await _prefs.remove(pinKey);
  }
  
  @override
  String? getPin() {
    return _prefs.getString(pinKey);
  }
  
  @override
  void savePin(String pin) async {
    await _prefs.setString(pinKey, pin);
  }
  
  @override
  bool hasPin() {
    return _prefs.containsKey(pinKey);
  }
}