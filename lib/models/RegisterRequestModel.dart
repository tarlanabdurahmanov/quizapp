class RegisterRequestModel {
  RegisterRequestModel({
    required this.name,
    required this.username,
    required this.email,
    required this.password,
  });

  String name;
  String username;
  String email;
  String password;

  factory RegisterRequestModel.fromJson(Map<String, dynamic> json) =>
      RegisterRequestModel(
        name: json["name"],
        username: json["username"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "username": username,
        "email": email,
        "password": password,
      };
}
