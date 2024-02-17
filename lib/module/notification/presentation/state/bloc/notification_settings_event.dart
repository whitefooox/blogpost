part of 'notification_settings_bloc.dart';

@immutable
sealed class NotificationSettingsEvent {}

class NotificationSettingsLoadEvent implements NotificationSettingsEvent {}

class NotificationSettingsUpdateSettingEvent implements NotificationSettingsEvent {
  final NotificationTopic topic;
  final bool isEnable;

  NotificationSettingsUpdateSettingEvent({
    required this.topic,
    required this.isEnable
  });
}
