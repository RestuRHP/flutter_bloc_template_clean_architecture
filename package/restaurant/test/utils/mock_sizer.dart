import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class MockSizer extends StatelessWidget {
  const MockSizer({
    Key? key,
    required this.page,
    this.navigatorObservers = const <NavigatorObserver>[],
  }) : super(key: key);

  final dynamic page;
  final List<NavigatorObserver> navigatorObservers;

  @override
  Widget build(BuildContext context) {
    return FlutterSizer(builder: (c, o, s) {
      return MaterialApp(
        home: page,
        navigatorObservers: navigatorObservers,
      );
    });
  }
}
