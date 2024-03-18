import 'dart:developer';

import 'package:flutter/services.dart';

class ProgressNotification{
  final MethodChannel channel = const MethodChannel('notification');

  Future<void> initPlatformState() async {
    try {
      channel.setMethodCallHandler(_handleMethod);
    } on PlatformException {
      log('PlatformException');
    }
  }

  Future<void> _handleMethod(MethodCall call) async {
    switch (call.method) {
      case 'updateProgress':
        int progress = call.arguments['progress'];
        log("$progress Methode Channel");
        break;
      default:
      // TODO Handle other method calls
    }
  }

}