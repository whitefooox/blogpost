import 'package:blogpost/module/entry/domain/dependency/i_biometry_repository.dart';
import 'package:blogpost/module/entry/domain/dependency/i_biometry_service.dart';
import 'package:blogpost/module/entry/domain/dependency/i_pin_repository.dart';

class LockInteractor {

  final IPinRepository _pinRepository;
  final IBiometryService _biometryService;
  final IBiometryRepository _biometryRepository;

  LockInteractor(
    this._pinRepository, 
    this._biometryService,
    this._biometryRepository
  );

  void enablePin(String pin){
    _pinRepository.savePin(pin);
  }

  void disablePin(){
    _pinRepository.deletePin();
  }

  bool authenticateWithPin(String pin){
    return pin == _pinRepository.getPin();
  }

  bool hasPin(){
    return _pinRepository.hasPin();
  }

  void enableFingerprint(){
    _biometryRepository.saveUseBiometry();
  }

  void disableFingerprint(){
    _biometryRepository.deleteUseBiometry();
  }

  Future<bool> authenticateWithFingerprint() async {
    return await _biometryService.authenticateWithFingerprint();
  }

  bool hasFingerprint(){
    return _biometryRepository.hasUseBiometry();
  }

  Future<bool> checkAvailableFingerprint() async {
    return await _biometryService.checkAvailableFingerprint();
  }
}