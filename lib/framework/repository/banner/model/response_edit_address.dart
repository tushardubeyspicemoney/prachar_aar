// To parse this JSON data, do
//
//     final responseEditAddress = responseEditAddressFromJson(jsonString);

import 'dart:convert';

ResponseEditAddress responseEditAddressFromJson(String str) => ResponseEditAddress.fromJson(json.decode(str));

String responseEditAddressToJson(ResponseEditAddress data) => json.encode(data.toJson());

class ResponseEditAddress {
  ResponseEditAddress({
    this.respStatus,
    this.respCode,
    this.respDesc,
  });

  String? respStatus;
  String? respCode;
  String? respDesc;

  factory ResponseEditAddress.fromJson(Map<String, dynamic> json) => ResponseEditAddress(
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
