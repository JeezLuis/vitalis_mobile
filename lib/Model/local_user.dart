import 'package:shared_preferences/shared_preferences.dart';

class LocalUser {
  String?  mail;
  String?  password;
  bool?    faceid;
  String?  userkey;

  LocalUser({
    this.mail,
    this.password,
    this.faceid,
    this.userkey,
  });
}

setLocalUser(LocalUser localUser)async{
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('mail', localUser.mail!);
  prefs.setString('password', localUser.password!);
  prefs.setBool('faceid', localUser.faceid!);
  prefs.setString('userkey', localUser.userkey!);
}

Future<LocalUser> getLocalUser() async{
  final prefs = await SharedPreferences.getInstance();
  if(prefs.containsKey('mail')){
    return LocalUser(mail: prefs.getString('mail'), password: prefs.getString('password'), faceid: prefs.getBool('faceid'), userkey: prefs.getString('userkey'));
  }
  else{
    return LocalUser(mail: null, password: null, faceid: null, userkey: null);
  }
}