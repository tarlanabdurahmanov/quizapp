class QuestionResponseModel {
  QuestionResponseModel({
    this.gameId,
    required this.question,
    required this.answers,
  });

  int? gameId;
  Question question;
  List<QuestionAnswer> answers;

  factory QuestionResponseModel.fromJson(Map<String, dynamic> json) =>
      QuestionResponseModel(
        gameId: json["game_id"],
        question: Question.fromJson(json["question"]),
        answers: List<QuestionAnswer>.from(
            json["answers"].map((x) => QuestionAnswer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "game_id": gameId,
        "question": question.toJson(),
        "answers": List<dynamic>.from(answers.map((x) => x.toJson())),
      };
}

class QuestionAnswer {
  QuestionAnswer({
    required this.id,
    required this.answer,
  });

  int id;
  String answer;

  factory QuestionAnswer.fromJson(Map<String, dynamic> json) => QuestionAnswer(
        id: json["id"],
        answer: json["answer"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "answer": answer,
      };
}

class Question {
  Question({
    required this.id,
    required this.question,
    this.music,
    this.image,
  });

  int id;
  String question;
  dynamic music;
  dynamic image;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json["id"],
        question: json["question"],
        music: json["music"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question": question,
        "music": music,
        "image": image,
      };
}
