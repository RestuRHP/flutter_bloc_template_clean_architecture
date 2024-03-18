import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant/restaurant.dart';

class RepositoryMock extends Mock implements RestaurantRepository {}

void main() {
  late RepositoryMock repositoryMock;
  late GetListRestaurant usecase;

  final mockResponse = ListRestaurantResponse(
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

  group('Usecase - ', () {

    setUp((){
      repositoryMock = RepositoryMock();
      usecase = GetListRestaurant(repositoryMock);
    });

    group('GetListRestaurant - ', () {
      test('return - ListRestaurantResponse', () async {
        when(() => repositoryMock.getListRestaurant()).thenAnswer(
              (_) async => Future.value(mockResponse),
        );
        final result = await usecase.fetchData();
        expect(result, isA<ListRestaurantResponse>());
      });
    });

  });
}
