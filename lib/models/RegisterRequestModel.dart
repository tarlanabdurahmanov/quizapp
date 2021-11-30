class RegisterRequestModel {
  RegisterRequestModel({
    required this.username,
    required this.email,
    required this.password,
  });

  String username;
  String email;
  String password;

  factory RegisterRequestModel.fromJson(Map<String, dynamic> json) =>
      RegisterRequestModel(
        username: json["username"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "password": password,
      };
}
