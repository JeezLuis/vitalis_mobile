class Response {
  String? objectId;
  int?    responseid;
  int?    datum;
  String? response;

  Response({
    this.objectId,
    this.responseid,
    this.datum,
    this.response,
  });

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      objectId:   json['objectId'],
      responseid: json['responseid'],
      datum:      json['datum'],
      response:   json['response'],
    );
  }
}