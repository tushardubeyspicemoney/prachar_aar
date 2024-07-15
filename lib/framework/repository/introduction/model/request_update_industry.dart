// To parse this JSON data, do
//
//     final requestUpdateIndustry = requestUpdateIndustryFromJson(jsonString);

import 'dart:convert';

RequestUpdateIndustry requestUpdateIndustryFromJson(String str) => RequestUpdateIndustry.fromJson(json.decode(str));

String requestUpdateIndustryToJson(RequestUpdateIndustry data) => json.encode(data.toJson());

class RequestUpdateIndustry {
  RequestUpdateIndustry({
    this.industryId,
    this.shopName,
  });

  int? industryId;
  String? shopName;

  factory RequestUpdateIndustry.fromJson(Map<String, dynamic> json) => RequestUpdateIndustry(
        industryId: json["industryId"],
        shopName: json["shopName"],
      );

  Map<String, dynamic> toJson() => {
        "industryId": industryId,
        "shopName": shopName,
      };
}
