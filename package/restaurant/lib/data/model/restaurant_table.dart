import 'package:restaurant/data/model/list_restaurant_response.dart';

class RestaurantTable {
  final String? id;
  final String? name;
  final String? description;
  final String? pictureId;
  final String? city;
  final double? rating;

  RestaurantTable({
    this.id,
    this.name,
    this.description,
    this.pictureId,
    this.city,
    this.rating,
  });

  factory RestaurantTable.fromEntity(Restaurant value) => RestaurantTable(
        id: value.id,
        name: value.name,
        description: value.description,
        city: value.city,
        pictureId: value.pictureId,
        rating: value.rating,
      );

  factory RestaurantTable.fromMap(Map<String, dynamic> map) => RestaurantTable(
        id: map['id'],
        name: map['name'],
        description: map['description'],
        city: map['city'],
        pictureId: map['pictureId'],
        rating: map['rating'],
      );

  Map <String, dynamic> toJson()=>{
    'id': id,
    'name': name,
    'description': description,
    'city': city,
    'pictureId': pictureId,
    'rating': rating,
  };
}
