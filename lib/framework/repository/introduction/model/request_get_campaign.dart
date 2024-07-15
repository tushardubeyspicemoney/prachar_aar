// To parse this JSON data, do
//
//     final requestGetCampaign = requestGetCampaignFromJson(jsonString);

import 'dart:convert';

RequestGetCampaign requestGetCampaignFromJson(String str) => RequestGetCampaign.fromJson(json.decode(str));

String requestGetCampaignToJson(RequestGetCampaign data) => json.encode(data.toJson());

class RequestGetCampaign {
  RequestGetCampaign({
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

  factory RequestGetCampaign.fromJson(Map<String, dynamic> json) => RequestGetCampaign(
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
