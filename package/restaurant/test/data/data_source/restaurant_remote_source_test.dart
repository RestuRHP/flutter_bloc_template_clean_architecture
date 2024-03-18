import 'dart:convert';

import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant/restaurant.dart';

import '../../utils/json_reader.dart';

class MockDio extends Mock implements Dio {}

void main() {
  group('RestaurantRemoteSource', () {
    late RestaurantRemoteSource restaurantRemoteSource;
    late Dio mockDio;
    const id = 'id';

    final listRestaurantResponse = readJson('dummy/restaurant.json');
    final detailRestaurantResponse = readJson('dummy/restaurant.json');

    setUp(() {
      mockDio = MockDio();
      restaurantRemoteSource = RestaurantRemoteSourceImpl(mockDio);
    });

    group('getListRestaurant - ', () {
      test('success', () async {
        final jsonData = json.decode(listRestaurantResponse) as Map<String, dynamic>;

        // Arrange
        when(() => mockDio.get(ApiConfig.listRestaurant)).thenAnswer(
          (_) async => Response(
            data: jsonData,
            statusCode: 200,
            requestOptions: RequestOptions(path: ''),
          ),
        );

        final result = await restaurantRemoteSource.getListRestaurant();

        expect(result, isA<ListRestaurantResponse>());
      });

      test('failure', () async {
        when(() => mockDio.get(ApiConfig.listRestaurant)).thenAnswer(
          (_) async => Response(
            data: {},
            statusCode: 500,
            requestOptions: RequestOptions(path: ''),
          ),
        );

        expect(() async => await restaurantRemoteSource.getListRestaurant(), throwsException);
      });
    });

    group('getDetailRestaurant - ', () {
      test('success', () async {
        final jsonData = json.decode(detailRestaurantResponse) as Map<String, dynamic>;

        when(() => mockDio.get('${ApiConfig.detailRestaurant}$id')).thenAnswer(
          (_) async => Response(
            data: jsonData,
            statusCode: 200,
            requestOptions: RequestOptions(path: ''),
          ),
        );

        final result = await restaurantRemoteSource.getDetailRestaurant(id);

        expect(result, isA<DetailRestaurantResponse>());
      });

      test('failure', () async {
        when(() => mockDio.get('${ApiConfig.detailRestaurant}$id')).thenAnswer(
              (_) async => Response(
            data: {},
            statusCode: 500,
            requestOptions: RequestOptions(path: ''),
          ),
        );

        expect(() async => await restaurantRemoteSource.getDetailRestaurant(id), throwsException);
      });
    });
  });
}
