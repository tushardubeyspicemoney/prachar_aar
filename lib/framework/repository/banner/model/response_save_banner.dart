// To parse this JSON data, do
//
//     final responseSaveBanner = responseSaveBannerFromJson(jsonString);

import 'dart:convert';

ResponseSaveBanner responseSaveBannerFromJson(String str) => ResponseSaveBanner.fromJson(json.decode(str));

String responseSaveBannerToJson(ResponseSaveBanner data) => json.encode(data.toJson());

class ResponseSaveBanner {
  ResponseSaveBanner({
    this.respStatus,
    this.respCode,
    this.respDesc,
    this.data,
  });

  String? respStatus;
  String? respCode;
  String? respDesc;
  Data? data;

  factory ResponseSaveBanner.fromJson(Map<String, dynamic> json) => ResponseSaveBanner(
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
    this.banner,
  });

  ShareBanner? banner;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        banner: ShareBanner.fromJson(json["banner"]),
      );

  Map<String, dynamic> toJson() => {
        "banner": banner!.toJson(),
      };
}

class ShareBanner {
  ShareBanner({
    this.bannersId,
    this.offerName,
    this.offerDesc,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.offerId,
    this.clientId,
    this.originalOffer,
  });

  int? bannersId;
  String? offerName;
  String? offerDesc;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  int? offerId;
  String? clientId;
  OriginalOffer? originalOffer;

  factory ShareBanner.fromJson(Map<String, dynamic> json) => ShareBanner(
        bannersId: json["banners_id"],
        offerName: json["offer_name"],
        offerDesc: json["offer_desc"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        offerId: json["offer_id"],
        clientId: json["client_id"],
        originalOffer: OriginalOffer.fromJson(json["originalOffer"]),
      );

  Map<String, dynamic> toJson() => {
        "banners_id": bannersId,
        "offer_name": offerName,
        "offer_desc": offerDesc,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "deletedAt": deletedAt,
        "offer_id": offerId,
        "client_id": clientId,
        "originalOffer": originalOffer!.toJson(),
      };
}

class OriginalOffer {
  OriginalOffer({
    this.offerImage,
    this.offerId,
    this.offerName,
    this.offerType,
    this.offerDesc,
    this.offerNameColor,
    this.shopNameColor,
    this.offerDescTextColor,
    this.lang,
    this.industryId,
  });

  String? offerImage;
  int? offerId;
  String? offerName;
  String? offerType;
  String? offerDesc;
  String? offerNameColor;
  String? shopNameColor;
  String? offerDescTextColor;
  String? lang;
  int? industryId;

  factory OriginalOffer.fromJson(Map<String, dynamic> json) => OriginalOffer(
        offerImage: json["offer_image"],
        offerId: json["offer_id"],
        offerName: json["offer_name"],
        offerType: json["offer_type"],
        offerDesc: json["offer_desc"],
        offerNameColor: json["offer_name_color"],
        shopNameColor: json["shop_name_color"],
        offerDescTextColor: json["offer_desc_text_color"],
        lang: json["lang"],
        industryId: json["industry_id"],
      );

  Map<String, dynamic> toJson() => {
        "offer_image": offerImage,
        "offer_id": offerId,
        "offer_name": offerName,
        "offer_type": offerType,
        "offer_desc": offerDesc,
        "offer_name_color": offerNameColor,
        "shop_name_color": shopNameColor,
        "offer_desc_text_color": offerDescTextColor,
        "lang": lang,
        "industry_id": industryId,
      };
}
