class Question {
  String? objectId;
  String? question;
  String? repetition;
  String? time;
  int?    type;
  bool?   answered = false;

  Question({
    this.objectId,
    this.question,
    this.repetition,
    this.time,
    this.type,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      objectId:   json['objectId'],
      question:   json['question'],
      repetition: json['repetition'],
      time:       json['time'],
      type:       json['type'],
    );
  }
}