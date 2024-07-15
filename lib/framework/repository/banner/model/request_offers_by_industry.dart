// To parse this JSON data, do
//
//     final requestOffersByIndustry = requestOffersByIndustryFromJson(jsonString);

import 'dart:convert';

RequestOffersByIndustry requestOffersByIndustryFromJson(String str) =>
    RequestOffersByIndustry.fromJson(json.decode(str));

String requestOffersByIndustryToJson(RequestOffersByIndustry data) => json.encode(data.toJson());

class RequestOffersByIndustry {
  RequestOffersByIndustry({
    this.industryId,
  });

  int? industryId;

  factory RequestOffersByIndustry.fromJson(Map<String, dynamic> json) => RequestOffersByIndustry(
        industryId: json["industryId"],
      );

  Map<String, dynamic> toJson() => {
        "industryId": industryId,
      };
}
