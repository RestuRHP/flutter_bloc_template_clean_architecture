

class DetailRestaurantResponse {
  final bool error;
  final String message;
  final RestaurantDetails? restaurant;

  DetailRestaurantResponse({
    required this.error,
    required this.message,
    this.restaurant,
  });

  factory DetailRestaurantResponse.fromJson(Map<String, dynamic> json) {
    return DetailRestaurantResponse(
      error: json['error'] as bool,
      message: json['message'] as String,
      restaurant: json['restaurant'] != null
          ? RestaurantDetails.fromJson(json['restaurant'] as Map<String, dynamic>)
          : null,
    );
  }
}

class RestaurantDetails {
  final String id;
  final String name;
  final String? description;
  final String? city;
  final String? address;
  final String? pictureId;
  final List<Category>? categories;
  final Menus? menus;
  final double? rating;
  final List<CustomerReview>? customerReviews;

  RestaurantDetails({
    required this.id,
    required this.name,
    this.description,
    this.city,
    this.address,
    this.pictureId,
    this.categories,
    this.menus,
    this.rating,
    this.customerReviews,
  });

  factory RestaurantDetails.fromJson(Map<String, dynamic> json) {
    return RestaurantDetails(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      city: json['city'] as String?,
      address: json['address'] as String?,
      pictureId: json['pictureId'] as String?,
      categories: json['categories'] != null
          ? List<Category>.from(
        (json['categories'] as List).map(
              (category) => Category.fromJson(category as Map<String, dynamic>),
        ),
      )
          : null,
      menus: json['menus'] != null
          ? Menus.fromJson(json['menus'] as Map<String, dynamic>)
          : null,
      rating: json['rating']?.toDouble(),
      customerReviews: json['customerReviews'] != null
          ? List<CustomerReview>.from(
        (json['customerReviews'] as List).map(
              (review) => CustomerReview.fromJson(review as Map<String, dynamic>),
        ),
      )
          : null,
    );
  }
}

class Category {
  final String? name;

  Category({
    this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['name'] as String?,
    );
  }
}

class Menus {
  final List<MenuItem>? foods;
  final List<MenuItem>? drinks;

  Menus({
    this.foods,
    this.drinks,
  });

  factory Menus.fromJson(Map<String, dynamic> json) {
    return Menus(
      foods: json['foods'] != null
          ? List<MenuItem>.from(
        (json['foods'] as List).map(
              (food) => MenuItem.fromJson(food as Map<String, dynamic>),
        ),
      )
          : null,
      drinks: json['drinks'] != null
          ? List<MenuItem>.from(
        (json['drinks'] as List).map(
              (drink) => MenuItem.fromJson(drink as Map<String, dynamic>),
        ),
      )
          : null,
    );
  }
}

class MenuItem {
  final String? name;

  MenuItem({
    this.name,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      name: json['name'] as String?,
    );
  }
}

class CustomerReview {
  final String? name;
  final String? review;
  final String? date;

  CustomerReview({
    this.name,
    this.review,
    this.date,
  });

  factory CustomerReview.fromJson(Map<String, dynamic> json) {
    return CustomerReview(
      name: json['name'] as String?,
      review: json['review'] as String?,
      date: json['date'] as String?,
    );
  }
}
