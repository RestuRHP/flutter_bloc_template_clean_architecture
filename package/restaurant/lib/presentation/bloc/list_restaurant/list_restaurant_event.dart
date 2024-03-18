
part of 'list_restaurant_bloc.dart';

abstract class RestaurantEvent {
  const RestaurantEvent();
}

class GetListRestaurantEvent extends RestaurantEvent {}