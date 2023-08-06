class TreatmentToPatient {
  final String?   objectid;
  final String?   title;
  final String?   observations;
  final int?      startdate;
  final bool?     state;
  final String?   patientMail;
  final String?   patientObjectId;
  final String?   treatmentTypeName;
  final String?   doctorSurname;
  final String?   doctorName;
  final String?   doctorTitle;

  const TreatmentToPatient({
    required this.objectid,
    required this.title,
    required this.observations,
    required this.startdate,
    required this.state,
    required this.patientMail,
    required this.patientObjectId,
    required this.treatmentTypeName,
    required this.doctorSurname,
    required this.doctorName,
    required this.doctorTitle,
  });

  factory TreatmentToPatient.fromJson(Map<String, dynamic> json) {
    return TreatmentToPatient(
      objectid:           json['objectId'],
      title:              json['title'],
      observations:       json['observations'],
      startdate:          json['startdate'],
      state:              json['state'],
      patientMail:        json['patientMail'],
      patientObjectId:    json['patientObjectId'],
      treatmentTypeName:  json['treatmentTypeName'],
      doctorSurname:      json['doctorSurname'],
      doctorName:         json['doctorName'],
      doctorTitle:        json['doctorTitle'],
    );
  }
}