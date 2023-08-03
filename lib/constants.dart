import 'Model/question_type.dart';

const List<QuestionType> question_types = <QuestionType>[
  QuestionType(id: 1, name: "Texto"),
  QuestionType(id: 2, name: "Texto Largo"),
  QuestionType(id: 3, name: "Fecha"),
  QuestionType(id: 4, name: "Número"),
  QuestionType(id: 5, name: "Si/No"),
  QuestionType(id: 6, name: "Estrellas"),
  QuestionType(id: 7, name: "Valoración"),
];

const List<String> repetition_types = <String>[
  "Lunes",
  "Martes",
  "Miercoles",
  "Jueves",
  "Viernes",
  "Sabado",
  "Domingo",
  "Siempre",
];

const List<String> genders = <String>[
  "Hombre",
  "Mujer",
  "Otros",
];