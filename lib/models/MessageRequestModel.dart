class MessageRequestModel {
  MessageRequestModel({
    required this.subject,
    required this.message,
  });

  String subject;
  String message;

  factory MessageRequestModel.fromJson(Map<String, dynamic> json) =>
      MessageRequestModel(
        subject: json["subject"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "subject": subject,
        "message": message,
      };
}
