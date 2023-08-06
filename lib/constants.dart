import 'Model/question_type.dart';

///List of question types
const List<QuestionType> questionTypes = <QuestionType>[
  QuestionType(id: 1, name: "Texto"),
  QuestionType(id: 2, name: "Texto Largo"),
  QuestionType(id: 3, name: "Fecha"),
  QuestionType(id: 4, name: "Número"),
  QuestionType(id: 5, name: "Si/No"),
  QuestionType(id: 6, name: "Estrellas"),
  QuestionType(id: 7, name: "Valoración"),
];

///List of repetition types
const List<String> repetitionTypes = <String>[
  "Lunes",
  "Martes",
  "Miercoles",
  "Jueves",
  "Viernes",
  "Sabado",
  "Domingo",
  "Siempre",
];

///List of genders
const List<String> genders = <String>[
  "Hombre",
  "Mujer",
  "Otros",
];