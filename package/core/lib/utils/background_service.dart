import 'dart:isolate';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:restaurant/restaurant.dart';

import '../core.dart';
import 'package:core/injection.dart' as di;

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static const String _isolateName = 'restaurant_isolate';
  static SendPort? _uiSendPort;
  final Dio dio = di.locator<Dio>();
  final NotificationService notification = di.locator<NotificationService>();
  final GetListRestaurant getListRestaurant = di.locator<GetListRestaurant>();

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initialize() {
    IsolateNameServer.registerPortWithName(port.sendPort, _isolateName);
  }

  Future<void> callback() async {

    final result = await getListRestaurant.fetchData();

    await notification.showNotification(result);

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }

}