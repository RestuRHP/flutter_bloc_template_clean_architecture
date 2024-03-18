part of 'detail_restaurant_bloc.dart';

class DetailRestaurantState {
  final BaseState<DetailRestaurantResponse>? result;

  const DetailRestaurantState({
    this.result,
  });

  DetailRestaurantState copyWith({
    BaseState<DetailRestaurantResponse>? result,
  }) {
    return DetailRestaurantState(
      result: result,
    );
  }
}

class DetailRestaurantInitial extends DetailRestaurantState {}
