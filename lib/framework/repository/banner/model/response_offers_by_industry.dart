// To parse this JSON data, do
//
//     final responseOffersByIndustry = responseOffersByIndustryFromJson(jsonString);

import 'dart:convert';

ResponseOffersByIndustry responseOffersByIndustryFromJson(String str) =>
    ResponseOffersByIndustry.fromJson(json.decode(str));

String responseOffersByIndustryToJson(ResponseOffersByIndustry data) => json.encode(data.toJson());

class ResponseOffersByIndustry {
  ResponseOffersByIndustry({
    this.respStatus,
    this.respCode,
    this.respDesc,
    this.data,
  });

  String? respStatus;
  String? respCode;
  String? respDesc;
  Data? data;

  factory ResponseOffersByIndustry.fromJson(Map<String, dynamic> json) => ResponseOffersByIndustry(
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

  List<Offer>? offers;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        offers: List<Offer>.from(json["offers"].map((x) => Offer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "offers": List<dynamic>.from(offers!.map((x) => x.toJson())),
      };
}

class Offer {
  Offer({
    this.offerType,
    this.offerList,
  });

  String? offerType;
  List<OfferList>? offerList;

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
        offerType: json["offerType"],
        offerList: List<OfferList>.from(json["offerList"].map((x) => OfferList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "offerType": offerType,
        "offerList": List<dynamic>.from(offerList!.map((x) => x.toJson())),
      };
}

class OfferList {
  OfferList({
    this.offerId,
    this.offerImage,
    this.offerName,
    this.offerDesc,
    this.offerDescTextColor,
    this.offerNameColor,
    this.shopNameColor,
  });

  int? offerId;
  String? offerImage;
  String? offerName;
  String? offerDesc;
  String? offerDescTextColor;
  String? offerNameColor;
  String? shopNameColor;

  factory OfferList.fromJson(Map<String, dynamic> json) => OfferList(
        offerId: json["offerId"],
        offerImage: json["offerImage"],
        offerName: json["offerName"],
        offerDesc: json["offerDesc"],
        offerDescTextColor: json["offerDescTextColor"],
        offerNameColor: json["offerNameColor"],
        shopNameColor: json["shopNameColor"],
      );

  Map<String, dynamic> toJson() => {
        "offerId": offerId,
        "offerImage": offerImage,
        "offerName": offerName,
        "offerDesc": offerDesc,
        "offerDescTextColor": offerDescTextColor,
        "offerNameColor": offerNameColor,
        "shopNameColor": shopNameColor,
      };
}
