import 'dart:developer';

import 'package:blogpost/module/entry/domain/dependency/i_biometry_service.dart';
import 'package:local_auth/local_auth.dart';

class BiometryService implements IBiometryService {
  final LocalAuthentication _auth = LocalAuthentication();

  @override
  Future<bool> checkAvailableFingerprint() async {
    try {
      return await _auth.canCheckBiometrics;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
  
  @override
  Future<bool> authenticateWithFingerprint() async {
    try {
      return await _auth.authenticate(
        localizedReason: 'Log in to the application',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}