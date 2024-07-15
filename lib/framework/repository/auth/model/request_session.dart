// To parse this JSON data, do
//
//     final requestSession = requestSessionFromJson(jsonString);

import 'dart:convert';

RequestSession requestSessionFromJson(String str) => RequestSession.fromJson(json.decode(str));

String requestSessionToJson(RequestSession data) => json.encode(data.toJson());

class RequestSession {
  RequestSession({
    this.sessionId,
    this.aggId,
    this.clientId,
    this.requestMode,
    this.lang,
    this.udf2Value,
  });

  String? sessionId;
  String? aggId;
  String? clientId;
  String? requestMode;
  String? lang;
  String? udf2Value;

  factory RequestSession.fromJson(Map<String, dynamic> json) => RequestSession(
        sessionId: json["sessionID"],
        aggId: json["aggID"],
        clientId: json["clientID"],
        requestMode: json["requestMode"],
        lang: json["language"],
        udf2Value: json["udf2Value"],
      );

  Map<String, dynamic> toJson() => {
        "sessionID": sessionId,
        "aggID": aggId,
        "clientID": clientId,
        "requestMode": requestMode,
        "language": lang,
        "udf2Value": udf2Value,
      };
}
