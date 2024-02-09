import 'dart:developer';

import 'package:blogpost/module/entry/domain/dependency/i_biometry_service.dart';
import 'package:local_auth/local_auth.dart';

class BiometryService implements IBiometryService {
  final LocalAuthentication auth = LocalAuthentication();

  @override
  Future<bool> checkAvailableFingerprint() async {
    try {
      return await auth.canCheckBiometrics;
    } catch (e) {
      log("Error in [biometry service][checkAvailableFingerprint]");
      return false;
    }
  }
  
  @override
  Future<bool> authenticateWithFingerprint() async {
    try {
      return await auth.authenticate(
        localizedReason: 'Log in to the application',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
    } catch (e) {
      return false;
    }
  }
}