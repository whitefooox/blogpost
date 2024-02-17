import 'package:blogpost/module/notification/domain/entity/notification_topic.dart';

abstract class INotificationStorage {
  void saveSetting(NotificationTopic topic, bool isEnable);
  Map<NotificationTopic, bool> getSettings();
}