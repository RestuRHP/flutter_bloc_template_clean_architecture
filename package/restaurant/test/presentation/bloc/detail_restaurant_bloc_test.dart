import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant/restaurant.dart';

class GetDetailRestaurantMock extends Mock implements GetDetailRestaurant {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const id = 'id';

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

  late DetailRestaurantBloc bloc;
  GetDetailRestaurantMock getMock = GetDetailRestaurantMock();

  setUp(() {
    bloc = DetailRestaurantBloc(getMock);
  });

  group('Restaurant Bloc - GetListRestaurant - ', () {
    blocTest(
      "success",
      build: () {
        when(() => getMock.fetchData(id)).thenAnswer(
              (_) async => Future.value(mockDetailRestaurant),
        );
        return bloc;
      },
      act: (bloc) {
        bloc.add(GetDetailRestaurantEvent(id));
      },
      expect: () => [
        isA<DetailRestaurantState>().having((p0) => p0.result?.status, 'isLoading', StatusState.loading),
        isA<DetailRestaurantState>().having((p0) => p0.result?.data, 'data', mockDetailRestaurant)
      ],
    );

    blocTest(
      "noInternet",
      build: () {
        when(() => getMock.fetchData(id)).thenThrow(const ConnectionFailure(StringSetup.noInternet));
        return bloc;
      },
      act: (bloc) {
        bloc.add(GetDetailRestaurantEvent(id));
      },
      expect: () => [
        isA<DetailRestaurantState>().having((p0) => p0.result?.status, 'isLoading', StatusState.loading),
        isA<DetailRestaurantState>().having((p0) => p0.result?.message, 'message', StringSetup.noInternet)
      ],
    );

    blocTest(
      "exception",
      build: () {
        when(() => getMock.fetchData(id)).thenThrow(const ServerFailure(StringSetup.exceptionDesc));
        return bloc;
      },
      act: (bloc) {
        bloc.add(GetDetailRestaurantEvent(id));
      },
      expect: () => [
        isA<DetailRestaurantState>().having((p0) => p0.result?.status, 'isLoading', StatusState.loading),
        isA<DetailRestaurantState>().having((p0) => p0.result?.message, 'message', StringSetup.exceptionDesc)
      ],
    );


  });
}
