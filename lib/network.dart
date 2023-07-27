import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:vitalis_mobile/Model/patient.dart';
import 'package:vitalis_mobile/Model/treatment_to_patient.dart';

const String url = 'https://skilledmist.backendless.app/api/data/';

Future<List<Patient>> logPatient(String mail, String password) async {
  final response = await http.get(Uri.parse('${url}Patient?where=password%20%3D%20\'$password\'%20AND%20mail%3D\'$mail\''));
  if (response.statusCode == 200) {
    List<Patient> patients = <Patient>[];
    for(var i = 0; i < jsonDecode(response.body).length; i++){
      patients.add(Patient(
        userid:     jsonDecode(response.body).elementAt(i)['patientid'],
        userkey:    jsonDecode(response.body).elementAt(i)['userkey'],
        mail:       jsonDecode(response.body).elementAt(i)['mail'],
        password:   jsonDecode(response.body).elementAt(i)['password'],
        objectid:   jsonDecode(response.body).elementAt(i)['objectId'],
        name:       jsonDecode(response.body).elementAt(i)['name'],
        surnames:   jsonDecode(response.body).elementAt(i)['surnames'],
        birthdate:  jsonDecode(response.body).elementAt(i)['birthdate'],
        gender:     jsonDecode(response.body).elementAt(i)['gender'],
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
    for(var i = 0; i < jsonDecode(response.body).length; i++){
      patients.add(Patient(
        userid:     jsonDecode(response.body).elementAt(i)['patientid'],
        userkey:    jsonDecode(response.body).elementAt(i)['userkey'],
        mail:       jsonDecode(response.body).elementAt(i)['mail'],
        password:   jsonDecode(response.body).elementAt(i)['password'],
        objectid:   jsonDecode(response.body).elementAt(i)['objectId'],
        name:       jsonDecode(response.body).elementAt(i)['name'],
        surnames:   jsonDecode(response.body).elementAt(i)['surnames'],
        birthdate:  jsonDecode(response.body).elementAt(i)['birthdate'],
        gender:     jsonDecode(response.body).elementAt(i)['gender'],
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
    for(var i = 0; i < jsonDecode(response.body).length; i++){
      patients.add(TreatmentToPatient(
        objectid:           jsonDecode(response.body).elementAt(i)['objectid'],
        treatmentid:        jsonDecode(response.body).elementAt(i)['treatmentid'],
        title:              jsonDecode(response.body).elementAt(i)['title'],
        observations:       jsonDecode(response.body).elementAt(i)['observations'],
        startdate:          jsonDecode(response.body).elementAt(i)['startdate'],
        state:              jsonDecode(response.body).elementAt(i)['state'],
        patientMail:        jsonDecode(response.body).elementAt(i)['patientMail'],
        patientid:          jsonDecode(response.body).elementAt(i)['patientid'],
        patientObjectId:    jsonDecode(response.body).elementAt(i)['patientObjectId'],
        treatmentTypeName:  jsonDecode(response.body).elementAt(i)['treatmentTypeName'],
        doctorSurname:      jsonDecode(response.body).elementAt(i)['doctorSurname'],
        doctorName:         jsonDecode(response.body).elementAt(i)['doctorName'],
        doctorTitle:        jsonDecode(response.body).elementAt(i)['doctorTitle'],
      ));
    }
    return patients;
  } else {
    throw Exception('Failed to load TreatmentToPatient');
  }
}