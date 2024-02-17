import 'package:blogpost/module/notification/domain/dependency/i_notification_service.dart';
import 'package:blogpost/module/notification/domain/dependency/i_notification_storage.dart';
import 'package:blogpost/module/notification/domain/entity/notification_topic.dart';

class NotificationInteractor {

  final INotificationService _notificationService;
  final INotificationStorage _notificationStorage;

  NotificationInteractor(
    this._notificationService,
    this._notificationStorage
  );

  Map<NotificationTopic, bool> getSettings(){
    return _notificationStorage.getSettings();
  }

  void subscribe(NotificationTopic topic){
    _notificationService.subscribe(topic);
    _notificationStorage.saveSetting(topic, true);
  }

  void unsubscribe(NotificationTopic topic){
     _notificationService.unsubscribe(topic);
    _notificationStorage.saveSetting(topic, false);
  }
}