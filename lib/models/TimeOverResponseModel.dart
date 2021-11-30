class TimeOverResponseModel {
  TimeOverResponseModel({
    required this.success,
  });

  Success success;

  factory TimeOverResponseModel.fromJson(Map<String, dynamic> json) =>
      TimeOverResponseModel(
        success: Success.fromJson(json["success"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success.toJson(),
      };
}

class Success {
  Success({
    this.message,
    this.commonScore,
  });

  String? message;
  int? commonScore;

  factory Success.fromJson(Map<String, dynamic> json) => Success(
        message: json["message"],
        commonScore: json["common_score"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "common_score": commonScore,
      };
}
