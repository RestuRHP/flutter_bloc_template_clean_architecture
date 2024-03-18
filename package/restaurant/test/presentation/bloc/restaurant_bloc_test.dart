import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant/restaurant.dart';

class GetListRestaurantMock extends Mock implements GetListRestaurant {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

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

  late RestaurantBloc blocIsConnect;
  GetListRestaurantMock getMock = GetListRestaurantMock();

  setUp(() {
    blocIsConnect = RestaurantBloc(getMock);
  });

  group('Restaurant Bloc - GetListRestaurant - ', () {
    blocTest(
      "success",
      build: () {
        when(() => getMock.fetchData()).thenAnswer(
          (_) async => Future.value(mockResponse),
        );
        return blocIsConnect;
      },
      act: (bloc) {
        bloc.add(GetListRestaurantEvent());
      },
      expect: () => [
        isA<RestaurantState>().having((p0) => p0.result?.status, 'isLoading', StatusState.loading),
        isA<RestaurantState>().having((p0) => p0.result?.data, 'data', mockResponse)
      ],
    );

    blocTest(
      "noInternet",
      build: () {
        when(() => getMock.fetchData()).thenThrow(const ConnectionFailure(StringSetup.noInternet));
        return blocIsConnect;
      },
      act: (bloc) {
        bloc.add(GetListRestaurantEvent());
      },
      expect: () => [
        isA<RestaurantState>().having((p0) => p0.result?.status, 'isLoading', StatusState.loading),
        isA<RestaurantState>().having((p0) => p0.result?.message, 'message', StringSetup.noInternet)
      ],
    );

    blocTest(
      "exception",
      build: () {
        when(() => getMock.fetchData()).thenThrow(const ServerFailure(StringSetup.exceptionDesc));
        return blocIsConnect;
      },
      act: (bloc) {
        bloc.add(GetListRestaurantEvent());
      },
      expect: () => [
        isA<RestaurantState>().having((p0) => p0.result?.status, 'isLoading', StatusState.loading),
        isA<RestaurantState>().having((p0) => p0.result?.message, 'message', StringSetup.exceptionDesc)
      ],
    );


  });
}
