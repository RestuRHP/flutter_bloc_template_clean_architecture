import 'package:core/core.dart';
import 'package:restaurant/data/model/restaurant_table.dart';

abstract class RestaurantLocalSource {
  Future<String> insertPlaceList(RestaurantTable restaurantTable);

  Future<String> removePLaceList(String id);

  Future<RestaurantTable?> getPlaceListById(String id);

  Future<List<RestaurantTable>> getPlaceList();
}

class RestaurantLocalSourceImpl implements RestaurantLocalSource {
  final DatabaseHelper databaseHelper;

  RestaurantLocalSourceImpl(this.databaseHelper);

  @override
  Future<List<RestaurantTable>> getPlaceList() async {
    final result = await databaseHelper.getPlaceList();
    return result.map((data) => RestaurantTable.fromMap(data)).toList();
  }

  @override
  Future<RestaurantTable?> getPlaceListById(String id) async {
    final result = await databaseHelper.getPlaceById(id);
    if (result != null) {
      return RestaurantTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<String> insertPlaceList(RestaurantTable restaurantTable) async {
    try {
      await databaseHelper.insertWatchlist(restaurantTable);
      return 'Added to PlaceList';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removePLaceList(String id) async {
    try {
      await databaseHelper.removePlaceList(id);
      return 'Removed from PlaceList';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
