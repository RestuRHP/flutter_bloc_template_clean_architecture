import 'package:core/core.dart';
import 'package:dio/dio.dart';

import '../model/detail_restaurant_response.dart';
import '../model/list_restaurant_response.dart';

abstract class RestaurantRemoteSource {
  Future<ListRestaurantResponse> getListRestaurant();

  Future<DetailRestaurantResponse> getDetailRestaurant(String id);
}

class RestaurantRemoteSourceImpl extends RestaurantRemoteSource {
  final Dio dio;

  RestaurantRemoteSourceImpl(this.dio);

  @override
  Future<ListRestaurantResponse> getListRestaurant() async {
    final Response response = await dio.get(ApiConfig.listRestaurant);
    if (response.statusCode == 200) {
      return ListRestaurantResponse.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<DetailRestaurantResponse> getDetailRestaurant(String id) async {
    final Response response = await dio.get(ApiConfig.detailRestaurant + id);
    if (response.statusCode == 200) {
      return DetailRestaurantResponse.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }
}
