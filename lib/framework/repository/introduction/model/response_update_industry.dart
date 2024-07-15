// To parse this JSON data, do
//
//     final responseUpdateIndustry = responseUpdateIndustryFromJson(jsonString);

import 'dart:convert';

ResponseUpdateIndustry responseUpdateIndustryFromJson(String str) => ResponseUpdateIndustry.fromJson(json.decode(str));

String responseUpdateIndustryToJson(ResponseUpdateIndustry data) => json.encode(data.toJson());

class ResponseUpdateIndustry {
  ResponseUpdateIndustry({
    this.respStatus,
    this.respCode,
    this.respDesc,
    this.data,
  });

  String? respStatus;
  String? respCode;
  String? respDesc;
  Data? data;

  factory ResponseUpdateIndustry.fromJson(Map<String, dynamic> json) => ResponseUpdateIndustry(
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
    this.user,
  });

  User? user;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user!.toJson(),
      };
}

class User {
  User(
      {this.clientId,
      this.shopName,
      this.industryId,
      this.createdAt,
      this.updatedAt,
      this.address,
      this.phoneno,
      this.contactInfo});

  String? clientId;
  String? shopName;
  int? industryId;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? address;
  String? phoneno;
  String? contactInfo;

  factory User.fromJson(Map<String, dynamic> json) => User(
        phoneno: json["phoneno"],
        address: json["address"],
        clientId: json["client_id"],
        shopName: json["shop_name"],
        industryId: json["industry_id"],
        contactInfo: json["contact_info"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "phoneno": phoneno,
        "address": address,
        "client_id": clientId,
        "shop_name": shopName,
        "industry_id": industryId,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "industry_id": industryId,
      };
}
