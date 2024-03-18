import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:restaurant/restaurant.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  //utils
  locator.registerLazySingleton(() => BackgroundService()..initialize());
  locator.registerLazySingleton(() => NotificationService()..initialize());
  locator.registerLazySingleton(() => FirebaseMessagingService()..initialize());
  locator.registerLazySingleton(() => FirebaseCrashlyticsService()..initialize());
  locator.registerLazySingleton(() => FirebaseRemoteConfigService()..initialize());
  locator.registerLazySingleton(() => DatabaseHelper());

  locator.registerLazySingleton<RestaurantRemoteSource>(
    () => RestaurantRemoteSourceImpl(locator()),
  );
  locator.registerLazySingleton<RestaurantLocalSource>(
    () => RestaurantLocalSourceImpl(locator()),
  );

  locator.registerLazySingleton<RestaurantRepository>(
    () => RestaurantRepositoryImpl(
      local: locator(),
      remote: locator(),
    ),
  );


  //usecase
  locator.registerLazySingleton(() => GetListRestaurant(locator()));
  locator.registerLazySingleton(() => GetDetailRestaurant(locator()));

  //Bloc
  locator.registerFactory(() => RestaurantBloc(locator()));
  locator.registerFactory(() => DetailRestaurantBloc(locator()));

  //client
  locator.registerLazySingleton<Dio>(() => ApiClient.instance.dio);
}
