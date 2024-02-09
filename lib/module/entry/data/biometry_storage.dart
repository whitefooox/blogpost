import 'package:blogpost/module/entry/domain/dependency/i_biometry_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BiometryStorage implements IBiometryRepository {
  final SharedPreferences _prefs; 
  String biometryKey = "useBiometry";

  BiometryStorage(this._prefs);
  
  @override
  void deleteUseBiometry() async {
    await _prefs.remove(biometryKey);
  }
  
  @override
  bool hasUseBiometry() {
    return _prefs.containsKey(biometryKey);
  }
  
  @override
  void saveUseBiometry() async {
    await _prefs.setBool(biometryKey, true);
  }
}