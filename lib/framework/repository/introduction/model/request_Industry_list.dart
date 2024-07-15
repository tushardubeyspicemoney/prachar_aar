// To parse this JSON data, do
//
//     final requestIndustryList = requestIndustryListFromJson(jsonString);

import 'dart:convert';

RequestIndustryList requestIndustryListFromJson(String str) => RequestIndustryList.fromJson(json.decode(str));

String requestIndustryListToJson(RequestIndustryList data) => json.encode(data.toJson());

class RequestIndustryList {
  RequestIndustryList({
    this.sessionId,
    this.aggId,
    this.clientId,
    this.requestMode,
    this.language,
    this.isSmaApp,
  });

  String? sessionId;
  String? aggId;
  String? clientId;
  String? requestMode;
  String? language;
  bool? isSmaApp;

  factory RequestIndustryList.fromJson(Map<String, dynamic> json) => RequestIndustryList(
        sessionId: json["sessionID"],
        aggId: json["aggID"],
        clientId: json["clientID"],
        requestMode: json["requestMode"],
        language: json["language"],
        isSmaApp: json["isSMAApp"],
      );

  Map<String, dynamic> toJson() => {
        "sessionID": sessionId,
        "aggID": aggId,
        "clientID": clientId,
        "requestMode": requestMode,
        "language": language,
        "isSMAApp": isSmaApp,
      };
}
