import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant/data/datasource/restaurant_local_source.dart';

class MockDatabaseHelper extends Mock implements DatabaseHelper{}

void main(){
  late RestaurantLocalSourceImpl localSource;
  late MockDatabaseHelper databaseHelper;

  group('RestaurantLocalSource -', () {

    setUp((){
      databaseHelper = MockDatabaseHelper();
      localSource = RestaurantLocalSourceImpl(databaseHelper);
    });



  });
}