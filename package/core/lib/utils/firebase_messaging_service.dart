import 'dart:developer';
import 'dart:io';

import 'package:core/core.dart';
import 'package:core/injection.dart' as di;
import 'package:firebase_messaging/firebase_messaging.dart';

Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log("Handling a background message: ${message.data}");
}

class FirebaseMessagingService {
  static FirebaseMessaging? _firebaseMessaging;

  static FirebaseMessaging get firebaseMessaging =>
      FirebaseMessagingService._firebaseMessaging ?? FirebaseMessaging.instance;

  final NotificationService notification = di.locator<NotificationService>();

  Future<void> initialize() async {
    if (Platform.isIOS) {
      NotificationSettings settings = await firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        log('User granted permission');
      } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
        log('User granted provisional permission');
      } else {
        log('User declined or has not accepted permission');
      }
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        notification.showNotificationFirebase(message);
      }
      log("onMessages: ${message.data.toString()}");
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log("onLaunch: ${message.data}");
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }
}
