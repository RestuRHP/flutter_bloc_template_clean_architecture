import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant/restaurant.dart';

part 'list_restaurant_event.dart';

part 'list_restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final GetListRestaurant _getListRestaurant;

  RestaurantBloc(
    this._getListRestaurant,
  ) : super(RestaurantInitial()) {
    on<GetListRestaurantEvent>((event, emit) async => await getListRestaurant(emit));
  }

  Future<void> getListRestaurant(Emitter<RestaurantState> emit) async {
    emit(state.copyWith(result: BaseState(status: StatusState.loading)));
    try {
      final response = await _getListRestaurant.fetchData();
      emit(state.copyWith(result: BaseState(status: StatusState.success, data: response)));
    } catch (e) {
      emit(state.copyWith(
        result: BaseState(
          status: StatusState.error,
          message: errorHandling(e),
        ),
      ));
    }
  }

}
