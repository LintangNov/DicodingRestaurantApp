
class RestaurantListResponse{
  final bool error;
  final String? message;
  final int? count;
  final int? founded;
  final List<Restaurant> restaurants;

  RestaurantListResponse({
    required this.error,
    this.message,
    this.count,
    this.founded,
    required this.restaurants,
  });

  factory RestaurantListResponse.fromJson(Map<String,dynamic> json){
    return RestaurantListResponse(
      error: json['error'],
      message: json["message"],
      count: json["count"],
      founded: json["founded"],
      restaurants: List<Restaurant>.from(
        json['restaurants'].map((r) => Restaurant.fromJson(r)),
      ),
    );
  }
}

class Restaurant {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      pictureId: json["pictureId"],
      city: json["city"],
      rating: json["rating"].toDouble(),
    );
  }
}