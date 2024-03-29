class QuestionOption {
  QuestionOption({
    required this.text,
    required this.id,
  });

  String text;
  int id;

  factory QuestionOption.fromJson(Map<String, dynamic> json) => QuestionOption(
        text: json["text"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "id": id,
      };
}

List<QuestionOption> radioList = [
  QuestionOption(
      text:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
      id: 1),
  QuestionOption(
    text:
        "Contray to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC",
    id: 2,
  ),
  QuestionOption(
      text: "It is a long established fact that a reader will be", id: 3),
  QuestionOption(
    text:
        "Many desktop publishing packages and web page editors now use Lorem Ipsum",
    id: 4,
  ),
];
