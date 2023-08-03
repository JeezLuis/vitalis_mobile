class Question {
  String? objectId;
  int?    questionid;
  String? question;
  String? repetition;
  String? time;
  int?    type;
  bool?   answered = false;

  Question({
    this.objectId,
    this.questionid,
    this.question,
    this.repetition,
    this.time,
    this.type,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      objectId:   json['objectId'],
      questionid: json['questionid'],
      question:   json['question'],
      repetition: json['repetition'],
      time:       json['time'],
      type:       json['type'],
    );
  }
}