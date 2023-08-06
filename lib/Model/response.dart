class Response {
  String? objectId;
  int?    datum;
  String? response;

  Response({
    this.objectId,
    this.datum,
    this.response,
  });

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      objectId:   json['objectId'],
      datum:      json['datum'],
      response:   json['response'],
    );
  }
}