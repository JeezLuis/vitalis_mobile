import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:vitalis_mobile/Model/patient.dart';
import 'package:vitalis_mobile/Model/question.dart';
import 'package:vitalis_mobile/Model/response.dart';
import 'package:vitalis_mobile/Model/treatment_to_patient.dart';

const String url = 'https://skilledmist.backendless.app/api/data/';

Future<List<Patient>> logPatient(String mail, String password) async {
  final response = await http.get(Uri.parse('${url}Patient?where=password%20%3D%20\'$password\'%20AND%20mail%3D\'$mail\''));
  if (response.statusCode == 200) {
    List<Patient> patients = <Patient>[];
    for(var i = 0; i < jsonDecode(utf8.decode(response.bodyBytes)).length; i++){
      patients.add(Patient(
        userid:     jsonDecode(utf8.decode(response.bodyBytes)).elementAt(i)['patientid'],
        userkey:    jsonDecode(utf8.decode(response.bodyBytes)).elementAt(i)['userkey'],
        mail:       jsonDecode(utf8.decode(response.bodyBytes)).elementAt(i)['mail'],
        password:   jsonDecode(utf8.decode(response.bodyBytes)).elementAt(i)['password'],
        objectid:   jsonDecode(utf8.decode(response.bodyBytes)).elementAt(i)['objectId'],
        name:       jsonDecode(utf8.decode(response.bodyBytes)).elementAt(i)['name'],
        surnames:   jsonDecode(utf8.decode(response.bodyBytes)).elementAt(i)['surnames'],
        birthdate:  jsonDecode(utf8.decode(response.bodyBytes)).elementAt(i)['birthdate'],
        gender:     jsonDecode(utf8.decode(response.bodyBytes)).elementAt(i)['gender'],
      ));
    }
    return patients;
  } else {
    throw Exception('Failed to load Patient');
  }
}

Future<http.Response> registerPatient(String mail, String password) async{
  return http.post(
    Uri.parse('${url}Patient'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'mail': mail,
      'password': password,
    }),
  );
}

///Get patient info from an email
Future<List<Patient>> getPatient(String mail) async {
  final response = await http.get(Uri.parse('${url}Patient?where=mail%3D\'$mail\''));

  if (response.statusCode == 200) {
    List<Patient> patients = <Patient>[];
    for(var i = 0; i < jsonDecode(utf8.decode(response.bodyBytes)).length; i++){
      patients.add(Patient(
        userid:     jsonDecode(utf8.decode(response.bodyBytes)).elementAt(i)['patientid'],
        userkey:    jsonDecode(utf8.decode(response.bodyBytes)).elementAt(i)['userkey'],
        mail:       jsonDecode(utf8.decode(response.bodyBytes)).elementAt(i)['mail'],
        password:   jsonDecode(utf8.decode(response.bodyBytes)).elementAt(i)['password'],
        objectid:   jsonDecode(utf8.decode(response.bodyBytes)).elementAt(i)['objectId'],
        name:       jsonDecode(utf8.decode(response.bodyBytes)).elementAt(i)['name'],
        surnames:   jsonDecode(utf8.decode(response.bodyBytes)).elementAt(i)['surnames'],
        birthdate:  jsonDecode(utf8.decode(response.bodyBytes)).elementAt(i)['birthdate'],
        gender:     jsonDecode(utf8.decode(response.bodyBytes)).elementAt(i)['gender'],
      ));
    }
    return patients;
  } else {
    throw Exception('Failed to load album');
  }
}

///Get treatments assigned to specific patient
Future<List<TreatmentToPatient>> getTreatments(int patientId) async {
  final response = await http.get(Uri.parse('${url}TreatmentToPatient?where=patientid%3D$patientId'));
  if (response.statusCode == 200) {
    List<TreatmentToPatient> patients = <TreatmentToPatient>[];
    for(var i = 0; i < jsonDecode(utf8.decode(response.bodyBytes)).length; i++){
      patients.add(TreatmentToPatient(
        objectid:           jsonDecode(utf8.decode(response.bodyBytes)).elementAt(i)['objectId'],
        treatmentid:        jsonDecode(utf8.decode(response.bodyBytes)).elementAt(i)['treatmentid'],
        title:              jsonDecode(utf8.decode(response.bodyBytes)).elementAt(i)['title'],
        observations:       jsonDecode(utf8.decode(response.bodyBytes)).elementAt(i)['observations'],
        startdate:          jsonDecode(utf8.decode(response.bodyBytes)).elementAt(i)['startdate'],
        state:              jsonDecode(utf8.decode(response.bodyBytes)).elementAt(i)['state'],
        patientMail:        jsonDecode(utf8.decode(response.bodyBytes)).elementAt(i)['patientMail'],
        patientid:          jsonDecode(utf8.decode(response.bodyBytes)).elementAt(i)['patientid'],
        patientObjectId:    jsonDecode(utf8.decode(response.bodyBytes)).elementAt(i)['patientObjectId'],
        treatmentTypeName:  jsonDecode(utf8.decode(response.bodyBytes)).elementAt(i)['treatmentTypeName'],
        doctorSurname:      jsonDecode(utf8.decode(response.bodyBytes)).elementAt(i)['doctorSurname'],
        doctorName:         jsonDecode(utf8.decode(response.bodyBytes)).elementAt(i)['doctorName'],
        doctorTitle:        jsonDecode(utf8.decode(response.bodyBytes)).elementAt(i)['doctorTitle'],
      ));
    }
    return patients;
  } else {
    throw Exception('Failed to load TreatmentToPatient');
  }
}

Future<http.Response> updatePatient(Patient patient) {
  return http.put(Uri.parse('${url}Patient/${patient.objectid}'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({
      'name': patient.name,
      'surnames' : patient.surnames,
      'gender' : patient.gender,
      'birthdate' : patient.birthdate
    }),
  );
}

Future<List<Question>> getQuestions(String treatmentObjectId) async {
  final response = await http.get(Uri.parse('${url}Question?where=treatmentid%3D\'$treatmentObjectId\''));

  if (response.statusCode == 200) {
    List<Question> questions = <Question>[];
    for(var i = 0; i < jsonDecode(utf8.decode(response.bodyBytes)).length; i++){
      questions.add(Question(
        objectId:   jsonDecode(utf8.decode(response.bodyBytes)).elementAt(i)['objectId'],
        questionid: jsonDecode(utf8.decode(response.bodyBytes)).elementAt(i)['questionid'],
        question:   jsonDecode(utf8.decode(response.bodyBytes)).elementAt(i)['question'],
        repetition: jsonDecode(utf8.decode(response.bodyBytes)).elementAt(i)['repetition'],
        time:       jsonDecode(utf8.decode(response.bodyBytes)).elementAt(i)['time'],
        type:       jsonDecode(utf8.decode(response.bodyBytes)).elementAt(i)['type'],
      ));
    }
    return questions;
  } else {
    throw Exception('Failed to load questions');
  }
}

Future<List<Response>> getResponses(String questionObjectId) async {
  final response = await http.get(Uri.parse('${url}Response?where=questionid%3D\'$questionObjectId\''));

  if (response.statusCode == 200) {
    List<Response> responses = <Response>[];
    for(var i = 0; i < jsonDecode(utf8.decode(response.bodyBytes)).length; i++){
      responses.add(Response(
        objectId:   jsonDecode(utf8.decode(response.bodyBytes)).elementAt(i)['objectId'],
        responseid: jsonDecode(utf8.decode(response.bodyBytes)).elementAt(i)['responseid'],
        datum:      jsonDecode(utf8.decode(response.bodyBytes)).elementAt(i)['datum'],
        response:   jsonDecode(utf8.decode(response.bodyBytes)).elementAt(i)['response'],
      ));
    }
    return responses;
  } else {
    throw Exception('Failed to load responses');
  }
}

Future<List<Response>> getTodayResponses(String questionObjectId) async {
  DateTime today = DateTime.now();
  final response = await http.get(Uri.parse('${url}Response?where=questionid%3D\'$questionObjectId\'%20and%20datum%3E%3D\'${DateTime(today.year, today.month, today.day, 0,0,0,0,0).millisecondsSinceEpoch}\''));

  if (response.statusCode == 200) {
    List<Response> responses = <Response>[];
    for(var i = 0; i < jsonDecode(utf8.decode(response.bodyBytes)).length; i++){
      responses.add(Response(
        objectId:   jsonDecode(utf8.decode(response.bodyBytes)).elementAt(i)['objectId'],
        responseid: jsonDecode(utf8.decode(response.bodyBytes)).elementAt(i)['responseid'],
        datum:      jsonDecode(utf8.decode(response.bodyBytes)).elementAt(i)['datum'],
        response:   jsonDecode(utf8.decode(response.bodyBytes)).elementAt(i)['response'],
      ));
    }
    return responses;
  } else {
    throw Exception('Failed to load responses');
  }
}

Future<int> respondQuestion(Question question, String answer) async{
  var result = await http.post(
    Uri.parse('${url}Response'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({
      'datum': DateTime.now().millisecondsSinceEpoch,
      'password': answer,
    }),
  );
  if (result.statusCode != 200) {
    return 1;
  }
  Response response = Response.fromJson(jsonDecode(utf8.decode(result.bodyBytes)));

  var link = await http.post(
      Uri.parse('${url}Response/${response.objectId}/questionid'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: "[\"${question.objectId}\"]"
  );
  if (link.statusCode != 200) {
    return 1;
  }

  return 0;
}