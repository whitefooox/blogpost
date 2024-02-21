import 'package:blogpost/module/entry/domain/dependency/i_biometry_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BiometryStorage implements IBiometryRepository {
  final SharedPreferences _prefs; 
  final String _biometryKey = "useBiometry";

  BiometryStorage(this._prefs);
  
  @override
  void deleteUseBiometry() async {
    await _prefs.remove(_biometryKey);
  }
  
  @override
  bool hasUseBiometry() {
    return _prefs.containsKey(_biometryKey);
  }
  
  @override
  void saveUseBiometry() async {
    await _prefs.setBool(_biometryKey, true);
  }
}