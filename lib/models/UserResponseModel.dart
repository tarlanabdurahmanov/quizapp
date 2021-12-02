class UserResponseModel {
  UserResponseModel({
    required this.user,
  });

  User user;

  factory UserResponseModel.fromJson(Map<String, dynamic> json) =>
      UserResponseModel(
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
      };
}

class User {
  User({
    this.name,
    required this.email,
    required this.username,
    this.birthday,
    this.profileImage,
  });

  String? name;
  String email;
  String username;
  dynamic birthday;
  dynamic profileImage;

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        email: json["email"],
        username: json["username"],
        birthday: json["birthday"],
        profileImage: json["profile_image"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "username": username,
        "birthday": birthday,
        "profile_image": profileImage,
      };
}
