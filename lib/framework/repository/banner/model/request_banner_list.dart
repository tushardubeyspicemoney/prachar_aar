// To parse this JSON data, do
//
//     final requestBannerList = requestBannerListFromJson(jsonString);

import 'dart:convert';

RequestBannerList requestBannerListFromJson(String str) => RequestBannerList.fromJson(json.decode(str));

String requestBannerListToJson(RequestBannerList data) => json.encode(data.toJson());

class RequestBannerList {
  RequestBannerList({
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

  factory RequestBannerList.fromJson(Map<String, dynamic> json) => RequestBannerList(
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
