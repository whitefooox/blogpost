abstract class IBiometryService {
  Future<bool> checkAvailableFingerprint();
  Future<bool> authenticateWithFingerprint();
}