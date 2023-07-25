class TreatmentToPatient {
  final String?   objectid;
  final int?      treatmentid;
  final String?   title;
  final String?   observations;
  final int? startdate;
  final bool?     state;
  final String?   patientMail;
  final int?      patientid;
  final String?   patientObjectId;
  final String?   treatmentTypeName;
  final String?   doctorSurname;
  final String?   doctorName;

  const TreatmentToPatient({
    required this.objectid,
    required this.treatmentid,
    required this.title,
    required this.observations,
    required this.startdate,
    required this.state,
    required this.patientMail,
    required this.patientid,
    required this.patientObjectId,
    required this.treatmentTypeName,
    required this.doctorSurname,
    required this.doctorName,
  });

  factory TreatmentToPatient.fromJson(Map<String, dynamic> json) {
    return TreatmentToPatient(
      objectid:           json['objectid'],
      treatmentid:        json['treatmentid'],
      title:              json['title'],
      observations:       json['observations'],
      startdate:          json['startdate'],
      state:              json['state'],
      patientMail:        json['patientMail'],
      patientid:          json['patientid'],
      patientObjectId:    json['patientObjectId'],
      treatmentTypeName:  json['treatmentTypeName'],
      doctorSurname:      json['doctorSurname'],
      doctorName:         json['doctorName'],
    );
  }
}