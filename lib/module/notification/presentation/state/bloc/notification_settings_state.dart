// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'notification_settings_bloc.dart';

class NotificationSettingsState {
  final Map<NotificationTopic, bool> settings;

  NotificationSettingsState({
    this.settings = const {},
  });

  NotificationSettingsState copyWith({
    Map<NotificationTopic, bool>? settings,
  }) {
    return NotificationSettingsState(
      settings: settings ?? this.settings,
    );
  }
}
