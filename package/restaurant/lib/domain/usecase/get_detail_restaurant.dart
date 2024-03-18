import '../../restaurant.dart';

class GetDetailRestaurant{
  final RestaurantRepository repository;

  GetDetailRestaurant(this.repository);

  Future<DetailRestaurantResponse> fetchData(String id) async {
    return repository.getDetailRestaurant(id);
  }
}