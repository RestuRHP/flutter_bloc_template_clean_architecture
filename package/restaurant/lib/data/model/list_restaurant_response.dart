import 'dart:math';

class ListRestaurantResponse {
  final bool? error;
  final String? message;
  final int? count;
  final List<Restaurant>? restaurants;

  ListRestaurantResponse({
    this.error,
    this.message,
    this.count,
    this.restaurants,
  });

  factory ListRestaurantResponse.fromJson(Map<String, dynamic> json) {
    return ListRestaurantResponse(
      error: json['error'] as bool?,
      message: json['message'] as String?,
      count: json['count'] as int?,
      restaurants: (json['restaurants'] as List? ?? [])
          .map((restaurant) => Restaurant.fromJson(restaurant as Map<String, dynamic>))
          .toList(),
    );
  }
}

class Restaurant {
  final String? id;
  final String? name;
  final String? description;
  final String? pictureId;
  final String? city;
  final double? rating;

  Restaurant({
    this.id,
    this.name,
    this.description,
    this.pictureId,
    this.city,
    this.rating,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      pictureId: json['pictureId'] as String?,
      city: json['city'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
      };

  distance() {
    return (Random().nextDouble() * (4.6 - 0.1) + 0.1).toStringAsFixed(1);
  }
}
