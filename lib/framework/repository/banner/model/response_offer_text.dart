// To parse this JSON data, do
//
//     final responseOfferText = responseOfferTextFromJson(jsonString);

import 'dart:convert';

ResponseOfferText? responseOfferTextFromJson(String str) => ResponseOfferText.fromJson(json.decode(str));

String responseOfferTextToJson(ResponseOfferText? data) => json.encode(data!.toJson());

class ResponseOfferText {
  ResponseOfferText({
    this.respStatus,
    this.respCode,
    this.respDesc,
    this.data,
  });

  String? respStatus;
  String? respCode;
  String? respDesc;
  Data? data;

  factory ResponseOfferText.fromJson(Map<String, dynamic> json) => ResponseOfferText(
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
    this.offers,
  });

  List<OfferText?>? offers;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        offers: json["offers"] == null ? [] : List<OfferText?>.from(json["offers"]!.map((x) => OfferText.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "offers": offers == null ? [] : List<dynamic>.from(offers!.map((x) => x!.toJson())),
      };
}

class OfferText {
  OfferText({
    this.offerName,
    this.offerDesc,
  });

  String? offerName;
  String? offerDesc;

  factory OfferText.fromJson(Map<String, dynamic> json) => OfferText(
        offerName: json["offer_name"],
        offerDesc: json["offer_desc"],
      );

  Map<String, dynamic> toJson() => {
        "offer_name": offerName,
        "offer_desc": offerDesc,
      };
}
