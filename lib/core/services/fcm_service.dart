import 'dart:developer';
import 'package:dev_coinku/core/services/push_fcm_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../features/notification/screens/notification_screen.dart';
import 'notification_service.dart';

class FcmService {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final storage = GetStorage();

  Future<void> initFCM() async {
    await Firebase.initializeApp();
    await _firebaseMessaging.requestPermission();
    await _firebaseMessaging.setAutoInitEnabled(true);

    final fCMToken = await _firebaseMessaging.getToken();
    // await storage.write('fcmToken', fCMToken);
    log('FCM Token: $fCMToken');

    initPushNotifications();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('Got a message whilst in the foreground!');
      log('Message data: ${message.data}');

      if (message.notification != null) {
        log('Message also contained a notification: ${message.notification}');
        NotificationService.showInstantNotification(
          title: message.notification!.title ?? 'No Title',
          body: message.notification!.body ?? 'No Body',
        );
      }
    });
  }

  Future handleMessage(RemoteMessage? message) async {
    if (message == null) return;

    await Get.toNamed(
      NotificationScreen.route,
      arguments: message.data,
    );
  }

  @pragma('vm:entry-point')
  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    log("Handling a background message: ${message.messageId}");
  }

  Future<void> initPushNotifications() async {
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }

  Future<void> subscribeToTopic(String topic) async {
    try {
      await _firebaseMessaging.subscribeToTopic(topic);
      log('Subscribed to topic: $topic');
    } catch (e) {
      log('Failed to subscribe to topic: $topic. Error: $e');
    }
  }

  Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _firebaseMessaging.unsubscribeFromTopic(topic);
      log('Unsubscribed from topic: $topic');
    } catch (e) {
      log('Failed to unsubscribe from topic: $topic. Error: $e');
    }
  }

  Future<void> sendMessage(
    String body,
    Map<String, dynamic>? dataNotification,
  ) async {
    // var token = await storage.read('fcmToken');
    // log('Data Token = $token');
    await PushFcmService.sendNotificationToFCM(
      Get.context!,
      body: body,
      dataNotification: dataNotification ?? {},
    );
  }
}
