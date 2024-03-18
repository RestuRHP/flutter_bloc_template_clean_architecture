part of 'detail_restaurant_bloc.dart';

abstract class DetailRestaurantEvent {
  const DetailRestaurantEvent();
}

class GetDetailRestaurantEvent extends DetailRestaurantEvent {
  final String id;

  GetDetailRestaurantEvent(this.id);
}
