class Patient {
  int       userid;
  String    userkey;
  String    mail;
  String    password;
  String?   objectid;
  String?   name;
  String?   surnames;
  int?      birthdate;
  String?   gender;

  Patient({
    required this.userid,
    required this.userkey,
    required this.mail,
    required this.password,
    required this.objectid,
    required this.name,
    required this.surnames,
    required this.birthdate,
    required this.gender,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      userid:     json['patientid'],
      userkey:    json['userkey'],
      mail:       json['mail'],
      password:   json['password'],
      objectid:   json['objectId'],
      name:       json['name'],
      surnames:   json['surnames'],
      birthdate:  json['birthdate'],
      gender:     json['gender'],
    );
  }
}