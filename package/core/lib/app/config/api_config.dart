class ApiConfig {
  static const String baseURL = 'https://restaurant-api.dicoding.dev';
  static const String contentType = 'application/json';
  static const String smallImage = '$baseURL/images/small/';
  static const String mediumImage = '$baseURL/images/medium/';
  static const String largeImage = '$baseURL/images/large/';

  static const String listRestaurant = '/list';
  static const String detailRestaurant = '/detail/';
  static const String searchRestaurant = '/search?q=';
  static const String addReview = '/review';
}
