part of 'list_restaurant_bloc.dart';

class RestaurantState {
  final BaseState<ListRestaurantResponse>? result;

  const RestaurantState({
    this.result,
  });

  RestaurantState copyWith({
    BaseState<ListRestaurantResponse>? result,
  }) {
    return RestaurantState(
      result: result,
    );
  }
}

class RestaurantInitial extends RestaurantState {}
