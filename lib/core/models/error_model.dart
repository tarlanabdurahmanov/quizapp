class ErrorModel {
  ErrorModel({
    this.error,
    this.message,
    this.type,
    this.commonScore,
  });

  Map? error;
  String? message;
  int? commonScore;
  int? type;

  factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
        error: json["error"],
        message: json["message"],
        commonScore: json["common_score"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "error": error,
        "common_score": commonScore,
        "type": type,
      };
}
