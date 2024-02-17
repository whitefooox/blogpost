import 'package:blogpost/module/notification/domain/dependency/i_notification_storage.dart';
import 'package:blogpost/module/notification/domain/entity/notification_topic.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationStorage implements INotificationStorage {

  final SharedPreferences _prefs;

  NotificationStorage(this._prefs);
  
  @override
  Map<NotificationTopic, bool> getSettings() {
    Map<NotificationTopic, bool> settings = {};
    for (var topic in NotificationTopic.values) {
      settings.addAll({
        topic: _prefs.getBool(topic.name) ?? false
      });
    }
    return settings;
  }
  
  @override
  Future<void> saveSetting(NotificationTopic topic, bool isEnable) async {
    await _prefs.setBool(topic.name, isEnable);
  }
}