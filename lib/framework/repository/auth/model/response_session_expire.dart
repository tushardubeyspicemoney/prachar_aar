// To parse this JSON data, do
//
//     final responseSessionExpire = responseSessionExpireFromJson(jsonString);

import 'dart:convert';

ResponseSessionExpire responseSessionExpireFromJson(String str) => ResponseSessionExpire.fromJson(json.decode(str));

String responseSessionExpireToJson(ResponseSessionExpire? data) => json.encode(data!.toJson());

class ResponseSessionExpire {
  ResponseSessionExpire({
    this.responseCode,
    this.responseDesc,
    this.responseStatus,
  });

  String? responseCode;
  String? responseDesc;
  String? responseStatus;

  factory ResponseSessionExpire.fromJson(Map<String, dynamic> json) => ResponseSessionExpire(
        responseCode: json["responseCode"],
        responseDesc: json["responseDesc"],
        responseStatus: json["responseStatus"],
      );

  Map<String, dynamic> toJson() => {
        "responseCode": responseCode,
        "responseDesc": responseDesc,
        "responseStatus": responseStatus,
      };
}
