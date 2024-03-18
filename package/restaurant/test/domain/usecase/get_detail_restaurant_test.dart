import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant/restaurant.dart';

class RepositoryMock extends Mock implements RestaurantRepository {}

void main() {
  late RepositoryMock repositoryMock;
  late GetDetailRestaurant usecase;
  const id = 'id';

  final mockResponse = DetailRestaurantResponse(
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

  group('Usecase - ', () {
    setUp(() {
      repositoryMock = RepositoryMock();
      usecase = GetDetailRestaurant(repositoryMock);
    });

    group('GetDetailRestaurant - ', () {
      test('return - DetailRestaurantResponse', () async {
        when(() => repositoryMock.getDetailRestaurant(id)).thenAnswer(
          (_) async => Future.value(mockResponse),
        );
        final result = await usecase.fetchData(id);
        expect(result, isA<DetailRestaurantResponse>());
      });
    });
  });
}
