import 'package:shared_preferences/shared_preferences.dart';

class LocalUser {
  String?  mail;
  String?  password;
  bool?    faceid;

  LocalUser({
    this.mail,
    this.password,
    this.faceid,
  });
}

///Saves the given [localUser] into internal storage
setLocalUser(LocalUser localUser)async{
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('mail', localUser.mail!);
  prefs.setString('password', localUser.password!);
  prefs.setBool('faceid', localUser.faceid!);
}

///Retrieves [localUser] from internal storage
Future<LocalUser> getLocalUser() async{
  final prefs = await SharedPreferences.getInstance();
  if(prefs.containsKey('mail')){
    return LocalUser(mail: prefs.getString('mail'), password: prefs.getString('password'), faceid: prefs.getBool('faceid'));
  }
  else{
    return LocalUser(mail: null, password: null, faceid: null);
  }
}