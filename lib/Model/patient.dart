class Patient {
  String    userkey;
  String    email;
  String?   objectid;
  String?   name;
  String?   surnames;
  int?      birthdate;
  String?   gender;

  Patient({
    required this.userkey,
    required this.email,
    required this.objectid,
    required this.name,
    required this.surnames,
    required this.birthdate,
    required this.gender,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      userkey:    json['userkey'],
      email:       json['email'],
      objectid:   json['objectId'],
      name:       json['name'],
      surnames:   json['surnames'],
      birthdate:  json['birthdate'],
      gender:     json['gender'],
    );
  }
}