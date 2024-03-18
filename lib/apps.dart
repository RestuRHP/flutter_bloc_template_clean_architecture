import 'dart:developer';

import 'package:core/app/common/navigation.dart';
import 'package:core/core.dart';
import 'package:core/injection.dart' as di;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:restaurant/restaurant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Apps extends StatelessWidget {
  Apps({Key? key}) : super(key: key);

  final FirebaseMessagingService firebaseMessagingService = di.locator<FirebaseMessagingService>();

  @override
  Widget build(BuildContext context) {
    firebaseNotificationListener();

    List<BlocProvider> providers = [
      BlocProvider<RestaurantBloc>(
        create: (_) => di.locator<RestaurantBloc>(),
      ),
      BlocProvider<DetailRestaurantBloc>(
        create: (_) => di.locator<DetailRestaurantBloc>(),
      ),
    ];

    return MultiBlocProvider(
      providers: providers,
      child: FlutterSizer(
        builder: (context, orientation, screenType) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Restaurant App",
            navigatorKey: navigatorKey,
            routes: {
              RestaurantDetailView.routeName: (context) => const RestaurantDetailView()
            },
            home: const HomeView(),
          );
        },
      ),
    );
  }

  Future<void> firebaseNotificationListener() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    log('=================');
    log(fcmToken.toString());
    log('=================');
    FirebaseMessaging.instance.requestPermission();
  }
}
