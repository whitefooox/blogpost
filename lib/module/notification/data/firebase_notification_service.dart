import 'dart:developer';

import 'package:blogpost/module/notification/domain/dependency/i_notification_service.dart';
import 'package:blogpost/module/notification/domain/entity/notification_topic.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async{
  //log(message.notification!.title!);
}

class FirebaseNotificationService implements INotificationService {
  static final _firebaseMessaging = FirebaseMessaging.instance;

  static Future<void> init() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission();
    if(settings.authorizationStatus == AuthorizationStatus.authorized){
      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
      log((await _firebaseMessaging.getToken())!);
    }
  }  

  @override
  Future<void> subscribe(NotificationTopic topic) async {
    await _firebaseMessaging.subscribeToTopic(topic.name);
  }

  @override
  Future<void> unsubscribe(NotificationTopic topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic.name);
  }
}