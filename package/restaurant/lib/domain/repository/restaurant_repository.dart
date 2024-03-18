import 'package:restaurant/data/model/detail_restaurant_response.dart';

import '../../data/model/list_restaurant_response.dart';

abstract class RestaurantRepository{
  Future<ListRestaurantResponse> getListRestaurant();
  Future<DetailRestaurantResponse> getDetailRestaurant(String id);
}