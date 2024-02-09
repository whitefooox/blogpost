part of 'app_lock_bloc.dart';

enum AppLockStatus {
  locked,
  unlocked
}

enum AppLockProcessStatus {
  initial,
  success,
  failure
}

class AppLockState {
  final AppLockStatus appLockStatus;
  final bool usePin;
  final bool useFingerprint;
  final AppLockProcessStatus appLockProcessStatus;

  AppLockState({
    this.appLockStatus = AppLockStatus.unlocked,
    this.usePin = false,
    this.useFingerprint = false,
    this.appLockProcessStatus = AppLockProcessStatus.initial
  });

  AppLockState copyWith({
    AppLockStatus? appLockStatus,
    bool? usePin,
    bool? useFingerprint,
    AppLockProcessStatus? appLockProcessStatus
}) => AppLockState(
    appLockStatus: appLockStatus ?? this.appLockStatus,
    usePin: usePin ?? this.usePin,
    useFingerprint: useFingerprint ?? this.useFingerprint,
    appLockProcessStatus: appLockProcessStatus ?? this.appLockProcessStatus
  );
}
