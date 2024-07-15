// To parse this JSON data, do
//
//     final responseSessionVerify = responseSessionVerifyFromJson(jsonString);

import 'dart:convert';

ResponseSessionVerify responseSessionVerifyFromJson(String str) => ResponseSessionVerify.fromJson(json.decode(str));

String responseSessionVerifyToJson(ResponseSessionVerify data) => json.encode(data.toJson());

class ResponseSessionVerify {
  ResponseSessionVerify({
    this.respStatus,
    this.respCode,
    this.respDesc,
    this.data,
  });

  String? respStatus;
  String? respCode;
  String? respDesc;
  Data? data;

  factory ResponseSessionVerify.fromJson(Map<String, dynamic> json) => ResponseSessionVerify(
        respStatus: json["respStatus"],
        respCode: json["respCode"],
        respDesc: json["respDesc"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "respStatus": respStatus,
        "respCode": respCode,
        "respDesc": respDesc,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.sessionId,
  });

  String? sessionId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        sessionId: json["sessionId"],
      );

  Map<String, dynamic> toJson() => {
        "sessionId": sessionId,
      };
}
