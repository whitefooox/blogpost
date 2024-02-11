import 'package:bloc/bloc.dart';
import 'package:blogpost/module/entry/domain/interactor/lock_interactor.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'app_lock_event.dart';
part 'app_lock_state.dart';

class AppLockBloc extends Bloc<AppLockEvent, AppLockState> {
  
  final lockInteractor = GetIt.instance.get<LockInteractor>();
  
  AppLockBloc() : super(AppLockState()) {
    on<AppLockAppLoadedEvent>(_appLoaded);
    on<AppLockEnablePinEvent>(_enablePin);
    on<AppLockActivateLockEvent>(_activateLock);
    on<AppLockUnlockWithPinEvent>(_pinUnlock);
    on<AppLockResetSettingsEvent>(_resetSettings);
  }

  void _resetSettings(
    AppLockResetSettingsEvent event,
    Emitter<AppLockState> emit
  ){
    lockInteractor.disablePin();
    lockInteractor.disableFingerprint();
    emit(state.copyWith(useFingerprint: false, usePin: false));
  }

  void _pinUnlock(
    AppLockUnlockWithPinEvent event,
    Emitter<AppLockState> emit
  ){
    final result = lockInteractor.authenticateWithPin(event.pin);
    emit(state.copyWith(
      appLockStatus: result ? AppLockStatus.unlocked : AppLockStatus.locked,
      appLockProcessStatus: result ? AppLockProcessStatus.success : AppLockProcessStatus.failure
    ));
  }

  void _activateLock(
    AppLockActivateLockEvent event,
    Emitter<AppLockState> emit
  ) {
    emit(state.copyWith(appLockStatus: AppLockStatus.locked,appLockProcessStatus: AppLockProcessStatus.initial));
  }

  void _appLoaded(
    AppLockAppLoadedEvent event,
    Emitter<AppLockState> emit
  ){
    final usePin = lockInteractor.hasPin();
    final useFingerprint = lockInteractor.hasFingerprint();
    emit(state.copyWith(
      usePin: usePin,
      useFingerprint: useFingerprint,
    ));
  }

  void _enablePin(
    AppLockEnablePinEvent event,
    Emitter<AppLockState> emit
  ){
    lockInteractor.enablePin(event.pin);
    emit(state.copyWith(usePin: true));
  }
}
