import 'package:blogpost/module/notification/domain/entity/notification_topic.dart';

abstract class INotificationService {
  void subscribe(NotificationTopic topic);
  void unsubscribe(NotificationTopic topic);
}