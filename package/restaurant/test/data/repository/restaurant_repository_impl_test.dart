import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant/restaurant.dart';

class RestaurantLocalSourceMock extends Mock implements RestaurantLocalSource {}

class RestaurantRemoteSourceMock extends Mock implements RestaurantRemoteSource {}

class RepositoryMock extends Mock implements RestaurantRepositoryImpl {}

void main() {
  late RestaurantLocalSourceMock localSourceMock;
  late RestaurantRemoteSourceMock remoteSourceMock;
  late RestaurantRepositoryImpl repository;
  const id = 'id';

  final mockListRestaurant = ListRestaurantResponse(
    error: false,
    message: "Success",
    count: 3,
    restaurants: [
      Restaurant(
        id: "1",
        name: "Restaurant A",
        description: "Description A",
        pictureId: "picture1.jpg",
        city: "City A",
        rating: 4.5,
      ),
    ],
  );

  final mockDetailRestaurant = DetailRestaurantResponse(
      error: false,
      message: 'Mock message',
      restaurant: RestaurantDetails(
        id: '1',
        name: 'Mock Restaurant',
        description: 'Mock description',
        city: 'Mock City',
        address: 'Mock Address',
        pictureId: 'mock_picture_id',
        categories: [
          Category(name: 'Category 1'),
          Category(name: 'Category 2'),
        ],
        menus: Menus(
          foods: [
            MenuItem(name: 'Food 1'),
            MenuItem(name: 'Food 2'),
          ],
          drinks: [
            MenuItem(name: 'Drink 1'),
            MenuItem(name: 'Drink 2'),
          ],
        ),
        rating: 4.5,
        customerReviews: [
          CustomerReview(name: 'John Doe', review: 'Mock review', date: '2022-01-01'),
          CustomerReview(name: 'Jane Doe', review: 'Another mock review', date: '2022-01-02'),
        ],
      ));

  group('RepositoryImpl - ', () {
    setUp(() {
      localSourceMock = RestaurantLocalSourceMock();
      remoteSourceMock = RestaurantRemoteSourceMock();
      repository = RestaurantRepositoryImpl(
        remote: remoteSourceMock,
        local: localSourceMock,
      );
    });

    group('GetListRestaurant - ', () {
      test('success', () async {
        when(() => remoteSourceMock.getListRestaurant()).thenAnswer(
          (_) async => Future.value(mockListRestaurant),
        );
        final result = await repository.getListRestaurant();
        expect(result, isA<ListRestaurantResponse>());
      });

      test('server_failure', () async {
        when(() => remoteSourceMock.getListRestaurant()).thenThrow(
          ServerException(),
        );
        expect(() => repository.getListRestaurant(), throwsA(isA<ServerFailure>()));
      });

      test('connection_error', () async {
        when(() => remoteSourceMock.getListRestaurant()).thenThrow(
          DioException(requestOptions: RequestOptions(path: '')),
        );
        expect(() => repository.getListRestaurant(), throwsA(isA<ConnectionFailure>()));
      });
    });

    group('GetDetailRestaurant - ', () {
      test('success', () async {
        when(() => remoteSourceMock.getDetailRestaurant(id)).thenAnswer(
          (_) async => Future.value(mockDetailRestaurant),
        );
        final result = await repository.getDetailRestaurant(id);
        expect(result, isA<DetailRestaurantResponse>());
      });

      test('server_failure', () async {
        when(() => remoteSourceMock.getDetailRestaurant(id)).thenThrow(
          ServerException(),
        );
        expect(() => repository.getDetailRestaurant(id), throwsA(isA<ServerFailure>()));
      });

      test('connection_error', () async {
        when(() => remoteSourceMock.getDetailRestaurant(id)).thenThrow(
          DioException(requestOptions: RequestOptions(path: '')),
        );
        expect(() => repository.getDetailRestaurant(id), throwsA(isA<ConnectionFailure>()));
      });
    });
  });
}
