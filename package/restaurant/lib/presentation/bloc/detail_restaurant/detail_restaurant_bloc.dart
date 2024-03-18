import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant/restaurant.dart';

part 'detail_restaurant_event.dart';

part 'detail_restaurant_state.dart';

class DetailRestaurantBloc extends Bloc<DetailRestaurantEvent, DetailRestaurantState> {
  final GetDetailRestaurant _getDetailRestaurant;

  DetailRestaurantBloc(
    this._getDetailRestaurant,
  ) : super(DetailRestaurantInitial()) {
    on<GetDetailRestaurantEvent>((event, emit) async => await getDetailRestaurant(event, emit));
  }

  Future<void> getDetailRestaurant(GetDetailRestaurantEvent event, Emitter<DetailRestaurantState> emit) async {
    emit(state.copyWith(result: BaseState(status: StatusState.loading)));
    try {
      final response = await _getDetailRestaurant.fetchData(event.id);
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
