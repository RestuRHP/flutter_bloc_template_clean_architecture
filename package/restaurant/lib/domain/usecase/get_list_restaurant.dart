import '../../restaurant.dart';

class GetListRestaurant{
  final RestaurantRepository repository;

  GetListRestaurant(this.repository);

  Future<ListRestaurantResponse> fetchData() async {
    return await repository.getListRestaurant();
  }
}