import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:restaurant/data/datasource/restaurant_local_source.dart';
import 'package:restaurant/data/datasource/restaurant_remote_source.dart';
import 'package:restaurant/data/model/detail_restaurant_response.dart';
import 'package:restaurant/data/model/list_restaurant_response.dart';
import 'package:restaurant/domain/repository/restaurant_repository.dart';

class RestaurantRepositoryImpl implements RestaurantRepository {
  final RestaurantRemoteSource remote;
  final RestaurantLocalSource local;

  RestaurantRepositoryImpl({required this.remote, required this.local});

  @override
  Future<DetailRestaurantResponse> getDetailRestaurant(String id) async {
    try {
      final result = await remote.getDetailRestaurant(id);
      return result;
    } on ServerException {
      throw const ServerFailure(StringSetup.exceptionDesc);
    } on DioException {
      throw const ConnectionFailure(StringSetup.noInternet);
    }
  }

  @override
  Future<ListRestaurantResponse> getListRestaurant() async {
    try {
      final result = await remote.getListRestaurant();
      return result;
    } on ServerException {
      throw const ServerFailure(StringSetup.exceptionDesc);
    } on DioException {
      throw const ConnectionFailure(StringSetup.noInternet);
    }
  }
}
