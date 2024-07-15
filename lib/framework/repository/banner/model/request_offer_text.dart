// To parse this JSON data, do
//
//     final requestOfferText = requestOfferTextFromJson(jsonString);

import 'dart:convert';

RequestOfferText? requestOfferTextFromJson(String str) => RequestOfferText.fromJson(json.decode(str));

String requestOfferTextToJson(RequestOfferText? data) => json.encode(data!.toJson());

class RequestOfferText {
  RequestOfferText({
    this.industryId,
  });

  int? industryId;

  factory RequestOfferText.fromJson(Map<String, dynamic> json) => RequestOfferText(
        industryId: json["industryId"],
      );

  Map<String, dynamic> toJson() => {
        "industryId": industryId,
      };
}
