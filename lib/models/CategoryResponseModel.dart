import 'package:quizapp/database/database_model.dart';

class CategoryResponseModel {
  CategoryResponseModel({
    required this.categories,
  });

  List<Category> categories;

  factory CategoryResponseModel.fromJson(Map<String, dynamic> json) =>
      CategoryResponseModel(
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
      };
}

class Category extends DatabaseModel {
  Category({
    required this.id,
    required this.categoryName,
    this.image,
  });

  int id;
  String categoryName;
  String? image;
  dynamic deletedAt;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        categoryName: json["category_name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_name": categoryName,
        "image": image,
      };

  @override
  fromJson(Map<String, dynamic> json) {
    return Category.fromJson(json);
  }
}
