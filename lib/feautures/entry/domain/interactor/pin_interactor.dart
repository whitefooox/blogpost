import 'package:blogpost/feautures/entry/domain/dependency/i_pin_repository.dart';

class PinInteractor {

  final IPinRepository pinRepository;

  PinInteractor({
    required this.pinRepository
  });

  void enablePin(String pin){
    pinRepository.savePin(pin);
  }

  void disablePin(){
    pinRepository.deletePin();
  }

  bool authenticateWithPin(String pin){
    return pin == pinRepository.getPin();
  }
}