import 'dart:async';
import 'dart:developer';

import 'package:core/core.dart';
import 'package:core/injection.dart' as di;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'apps.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    di.setupLocator();

    runApp(Apps());

  }, (error, stack) {
    if (kDebugMode) {
      log('runZonedGuarded: error $error \nstackTrace $stack');
    }
  });
}
