class Patient {
  final int       userid;
  final String    userkey;
  final String    mail;
  final String    password;
  final String?   name;
  final String?   surnames;
  final DateTime? birthdate;
  final String?   gender;
  final String?   occupation;
  final String?   civilstate;

  const Patient({
    required this.userid,
    required this.userkey,
    required this.mail,
    required this.password,
    required this.name,
    required this.surnames,
    required this.birthdate,
    required this.gender,
    required this.occupation,
    required this.civilstate,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      userid:     json['patientid'],
      userkey:    json['userkey'],
      mail:       json['mail'],
      password:   json['password'],
      name:       json['name'],
      surnames:   json['surnames'],
      birthdate:  json['birthdate'],
      gender:     json['gender'],
      occupation: json['occupation'],
      civilstate: json['civilstate'],
    );
  }
}