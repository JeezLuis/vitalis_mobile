import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:vitalis_mobile/Model/Patient.dart';

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