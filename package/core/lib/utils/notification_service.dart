import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math' hide log;

import 'package:core/app/common/navigation.dart';
import 'package:core/core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurant/restaurant.dart';

class NotificationService {
  static NotificationService? _instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  NotificationService._internal() {
    _instance = this;
  }

  factory NotificationService() {
    if (_instance != null) {
      return _instance!;
    } else {
      return NotificationService._internal();
    }
  }

  Future<void> initialize() async {
    AndroidInitializationSettings initializationSettingsAndroid = const AndroidInitializationSettings('app_icon');
    DarwinInitializationSettings initializationSettingsIOs = const DarwinInitializationSettings();
    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOs,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (value) async {
        final payload = value.payload;
        if (payload != null) {
          navigateToPage(payload);
        }
        log('notification payload: $payload');
      },
    );
  }

  Future<File> _downloadImage({String? imageUrl}) async {
    return await DefaultCacheManager().getSingleFile('$imageUrl');
  }

  Future<void> showNotification(ListRestaurantResponse? restaurantList) async {
    const channelId = 'General';
    const channelName = 'Restaurant General Notification';
    const channelDescription = 'restaurant app channel';
    String downloadedImagePath;
    FilePathAndroidBitmap imageBitmap;

    const titleNotification = "Rekomendasi restoran hari ini";
    final randomIndex = Random().nextInt(restaurantList?.restaurants?.length ?? 0);
    final restaurant = restaurantList?.restaurants?[randomIndex];

    StyleInformation notificationStyle = const BigTextStyleInformation('');

    if (restaurantList != null) {
      String? imageUrl = "${ApiConfig.smallImage}${restaurant?.pictureId}";

      downloadedImagePath = (await _downloadImage(imageUrl: imageUrl)).path;
      imageBitmap = FilePathAndroidBitmap(downloadedImagePath);

      notificationStyle = BigPictureStyleInformation(imageBitmap, hideExpandedLargeIcon: true);
    }

    AndroidNotificationDetails android = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDescription,
      styleInformation: notificationStyle,
      importance: Importance.high,
      priority: Priority.high,
    );
    var iOS = const DarwinNotificationDetails();
    var platform = NotificationDetails(android: android, iOS: iOS);

    await flutterLocalNotificationsPlugin.show(
      0,
      titleNotification,
      restaurant?.name,
      platform,
      payload: json.encode(restaurant?.toJson()),
    );
  }

  Future<void> showNotificationFirebase(RemoteMessage message) async {
    const channelId = 'Firebase';
    const channelName = 'Restaurant Firebase Notification';
    const channelDescription = 'restaurant app channel';
    String downloadedImagePath;
    FilePathAndroidBitmap imageBitmap;

    StyleInformation notificationStyle = const BigTextStyleInformation('');
    RemoteNotification? notification = message.notification;

    if (notification?.android?.imageUrl != null || notification?.apple?.imageUrl != null) {
      String? imageUrl = notification?.android?.imageUrl ?? notification?.apple?.imageUrl;

      downloadedImagePath = (await _downloadImage(imageUrl: imageUrl)).path;
      imageBitmap = FilePathAndroidBitmap(downloadedImagePath);

      notificationStyle = BigPictureStyleInformation(imageBitmap, hideExpandedLargeIcon: true);
    }

    AndroidNotificationDetails android = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDescription,
      importance: Importance.high,
      styleInformation: notificationStyle,
      priority: Priority.high,
    );
    var iOS = const DarwinNotificationDetails();
    var platform = NotificationDetails(android: android, iOS: iOS);

    if (Platform.isAndroid) {
      await flutterLocalNotificationsPlugin.show(
        0,
        notification?.title,
        notification?.body,
        platform,
        payload: jsonEncode(message.data),
      );
    }
  }

  static navigateToPage(dynamic payload) {
    Map<String, dynamic> decodedPayload = json.decode(payload);
    String pageName = decodedPayload['page_name'];
    String id = decodedPayload['id'];
    print(pageName+id);
    if (navigatorKey.currentState != null) {
      navigatorKey.currentState!.pushNamed(pageName, arguments: id);
    } else {
      print('NavigatorState is null. Unable to navigate.');
    }
  }

  //learning -- ignore it
  Future<void> showProgressNotification({int progress = 0, int maxProgress = 100}) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      '901',
      'Progress Notifications',
      channelDescription: 'Notifications with progress',
      importance: Importance.max,
      priority: Priority.high,
      channelShowBadge: false,
      onlyAlertOnce: true,
      showProgress: true,
      maxProgress: maxProgress,
      progress: progress,
    );
    NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      901,
      'Progress Notification',
      'Downloading...',
      platformChannelSpecifics,
      payload: 'payload',
    );

    if (progress > maxProgress) {
      await flutterLocalNotificationsPlugin.cancel(901);
    }
  }

}
