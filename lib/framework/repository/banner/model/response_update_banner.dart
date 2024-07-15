// To parse this JSON data, do
//
//     final responseUpdateBanner = responseUpdateBannerFromJson(jsonString);

import 'dart:convert';

ResponseUpdateBanner responseUpdateBannerFromJson(String str) => ResponseUpdateBanner.fromJson(json.decode(str));

String responseUpdateBannerToJson(ResponseUpdateBanner data) => json.encode(data.toJson());

class ResponseUpdateBanner {
  ResponseUpdateBanner({
    this.respStatus,
    this.respCode,
    this.respDesc,
  });

  String? respStatus;
  String? respCode;
  String? respDesc;

  factory ResponseUpdateBanner.fromJson(Map<String, dynamic> json) => ResponseUpdateBanner(
        respStatus: json["respStatus"],
        respCode: json["respCode"],
        respDesc: json["respDesc"],
      );

  Map<String, dynamic> toJson() => {
        "respStatus": respStatus,
        "respCode": respCode,
        "respDesc": respDesc,
      };
}
