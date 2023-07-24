import 'package:shared_preferences/shared_preferences.dart';

class LocalUser {
  final String?  mail;
  final String?  password;
  final bool?    faceid;

  const LocalUser({
    required this.mail,
    required this.password,
    required this.faceid,
  });
}

setLocalUser(LocalUser localUser)async{
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('mail', localUser.mail!);
  prefs.setString('password', localUser.password!);
  prefs.setBool('faceid', localUser.faceid!);
}

getLocalUser() async{
  final prefs = await SharedPreferences.getInstance();
  return LocalUser(mail: prefs.getString('mail'), password: prefs.getString('password'), faceid: prefs.getBool('faceid'));
}