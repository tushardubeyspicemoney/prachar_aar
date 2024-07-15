// To parse this JSON data, do
//
//     final responseBannerList = responseBannerListFromJson(jsonString);

import 'dart:convert';

ResponseBannerList responseBannerListFromJson(String str) => ResponseBannerList.fromJson(json.decode(str));

String responseBannerListToJson(ResponseBannerList data) => json.encode(data.toJson());

class ResponseBannerList {
  ResponseBannerList({
    this.respStatus,
    this.respCode,
    this.respDesc,
    this.data,
  });

  String? respStatus;
  String? respCode;
  String? respDesc;
  Data? data;

  factory ResponseBannerList.fromJson(Map<String, dynamic> json) => ResponseBannerList(
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
    this.banners,
  });

  List<BannerItem>? banners;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        banners: List<BannerItem>.from(json["banners"].map((x) => BannerItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "banners": List<dynamic>.from(banners!.map((x) => x.toJson())),
      };
}

class BannerItem {
  BannerItem({
    this.bannersId,
    this.offerName,
    this.offerDesc,
    this.originalOffer,
  });

  int? bannersId;
  String? offerName;
  String? offerDesc;
  OriginalOffer? originalOffer;

  factory BannerItem.fromJson(Map<String, dynamic> json) => BannerItem(
        bannersId: json["banners_id"],
        offerName: json["offer_name"],
        offerDesc: json["offer_desc"],
        originalOffer: OriginalOffer.fromJson(json["originalOffer"]),
      );

  Map<String, dynamic> toJson() => {
        "banners_id": bannersId,
        "offer_name": offerName,
        "offer_desc": offerDesc,
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
