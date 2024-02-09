part of 'app_lock_bloc.dart';

@immutable
sealed class AppLockEvent {}

class AppLockAppLoadedEvent extends AppLockEvent {}

class AppLockEnablePinEvent extends AppLockEvent {
  final String pin;

  AppLockEnablePinEvent(this.pin);
}

class AppLockActivateLockEvent extends AppLockEvent {}

class AppLockUnlockWithPinEvent extends AppLockEvent {
  final String pin;

  AppLockUnlockWithPinEvent(this.pin);
}

class AppLockUnlockWithFingerprintEvent extends AppLockEvent {}