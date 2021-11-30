class RatingResponseModel {
  RatingResponseModel({
    required this.rating,
  });

  List<Rating> rating;

  factory RatingResponseModel.fromJson(Map<String, dynamic> json) =>
      RatingResponseModel(
        rating:
            List<Rating>.from(json["rating"].map((x) => Rating.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "rating": List<dynamic>.from(rating.map((x) => x.toJson())),
      };
}

class Rating {
  Rating({
    this.score,
    this.username,
    this.name,
    this.profileImage,
  });

  int? score;
  String? username;
  String? name;
  dynamic profileImage;

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        score: json["score"],
        username: json["username"],
        name: json["name"],
        profileImage: json["profile_image"],
      );

  Map<String, dynamic> toJson() => {
        "score": score,
        "username": username,
        "name": name,
        "profile_image": profileImage,
      };
}
