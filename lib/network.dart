import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:vitalis_mobile/Model/Patient.dart';
import 'package:vitalis_mobile/Model/TreatmentToPatient.dart';

Future<List<Patient>> logPatient(String mail, String password) async {
  final response = await http.get(Uri.parse('https://skilledmist.backendless.app/api/data/Patient?where=password%20%3D%20\'$password\'%20AND%20mail%3D\'$mail\''));

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
        occupation: jsonDecode(response.body).elementAt(i)['occupation'],
        civilstate: jsonDecode(response.body).elementAt(i)['civilstate'],
      )
      );
    }
    return patients;
  } else {
    throw Exception('Failed to load Patient');
  }
}

Future<http.Response> registerPatient(String mail, String password) async{
  return http.post(
    Uri.parse('https://skilledmist.backendless.app/api/data/Patient'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'mail': mail,
      'password': password,
    }),
  );
}

Future<List<Patient>> getPatient(String mail) async {
  final response = await http.get(Uri.parse('https://skilledmist.backendless.app/api/data/Patient?where=mail%3D\'$mail\''));

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
        occupation: jsonDecode(response.body).elementAt(i)['occupation'],
        civilstate: jsonDecode(response.body).elementAt(i)['civilstate'],
      )
      );
    }
    return patients;
  } else {
    throw Exception('Failed to load album');
  }
}

Future<List<TreatmentToPatient>> getTreatments(int patientId) async {
  final response = await http.get(Uri.parse('https://skilledmist.backendless.app/api/data/TreatmentToPatient?where=patientid%3D$patientId'));

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
      )
      );
    }
    return patients;
  } else {
    throw Exception('Failed to load TreatmentToPatient');
  }
}