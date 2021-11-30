class ErrorModel {
  ErrorModel({
    this.error,
    this.message,
    this.commonScore,
  });

  Map? error;
  String? message;
  int? commonScore;

  factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
        error: json["error"],
        message: json["message"],
        commonScore: json["common_score"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "error": error,
        "common_score": commonScore,
      };
}
