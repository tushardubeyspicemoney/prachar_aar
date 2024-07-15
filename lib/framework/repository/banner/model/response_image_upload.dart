// To parse this JSON data, do
//
//     final responseImageUpload = responseImageUploadFromJson(jsonString);

import 'dart:convert';

ResponseImageUpload responseImageUploadFromJson(String str) => ResponseImageUpload.fromJson(json.decode(str));

String responseImageUploadToJson(ResponseImageUpload data) => json.encode(data.toJson());

class ResponseImageUpload {
  ResponseImageUpload({
    this.respStatus,
    this.respCode,
    this.respDesc,
    this.data,
  });

  String? respStatus;
  String? respCode;
  String? respDesc;
  Data? data;

  factory ResponseImageUpload.fromJson(Map<String, dynamic> json) => ResponseImageUpload(
        respStatus: json["respStatus"],
        respCode: json["respCode"],
        respDesc: json["respDesc"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "respStatus": respStatus,
        "respCode": respCode,
        "respDesc": respDesc,
        "data": data?.toJson(),
      };
}

class Data {
  Data({
    this.signedUrl,
    this.url,
  });

  String? signedUrl;
  String? url;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        signedUrl: json["signedUrl"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "signedUrl": signedUrl,
        "url": url,
      };
}
