import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant/presentation/view/item_list_restaurant.dart';
import 'package:restaurant/restaurant.dart';

import '../../utils/mock_sizer.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  final Restaurant mockItem = Restaurant(
    name: 'Mock Restaurant',
    description: 'Mock Description',
    pictureId: 'mock_picture_id',
    city: 'Mock City',
    rating: 4.5,
  );

  testWidgets('displays content correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MockSizer(
        page: MaterialApp(
          home: Scaffold(
            body: ItemListRestaurant(item: mockItem),
          ),
        ),
      ),
    );

    expect(find.text('Mock Restaurant'), findsOneWidget);
    expect(find.text('Mock Description'), findsOneWidget);
    expect(find.text('Mock City'), findsOneWidget);
    expect(find.text('4.5'), findsOneWidget);

    expect(find.byType(CachedNetworkImage), findsOneWidget);
  });

  testWidgets('Tap on ItemListRestaurant navigates to RestaurantDetailView', (WidgetTester tester) async {
    // Buat instance dari MockNavigatorObserver
    final mockObserver = MockNavigatorObserver();

    // Bangun widget test
    await tester.pumpWidget(
      MaterialApp(
        home: ItemListRestaurant(item: mockItem),
        navigatorObservers: [mockObserver],
        onGenerateRoute: (settings) {
          expect(settings.name, equals(RestaurantDetailView.routeName));
          return MaterialPageRoute(builder: (context) => Container());
        },
      ),
    );

    await tester.tap(find.byType(ItemListRestaurant));
    await tester.pumpAndSettle();

    // verify(mockObserver.didPush(any, any)).called(1);
  });
}
