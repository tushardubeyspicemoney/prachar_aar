// To parse this JSON data, do
//
//     final responseSavePoster = responseSavePosterFromJson(jsonString);

import 'dart:convert';

ResponseSavePoster responseSavePosterFromJson(String str) => ResponseSavePoster.fromJson(json.decode(str));

String responseSavePosterToJson(ResponseSavePoster data) => json.encode(data.toJson());

class ResponseSavePoster {
  ResponseSavePoster({
    this.respStatus,
    this.respCode,
    this.respDesc,
    this.data,
  });

  String? respStatus;
  String? respCode;
  String? respDesc;
  Data? data;

  factory ResponseSavePoster.fromJson(Map<String, dynamic> json) => ResponseSavePoster(
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
    this.banner,
  });

  Banner? banner;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        banner: json["banner"] == null ? null : Banner.fromJson(json["banner"]),
      );

  Map<String, dynamic> toJson() => {
        "banner": banner?.toJson(),
      };
}

class Banner {
  Banner(
      {this.bannersId,
      this.offerName,
      this.offerDesc,
      this.imageUrl,
      this.signedUrl,
      this.clientId,
      this.updatedAt,
      this.createdAt,
      this.deletedAt,
      this.offerId,
      this.fileName});

  int? bannersId;
  String? offerName;
  String? fileName;
  String? offerDesc;
  String? imageUrl;
  String? signedUrl;
  String? clientId;
  DateTime? updatedAt;
  DateTime? createdAt;
  DateTime? deletedAt;
  DateTime? offerId;

  factory Banner.fromJson(Map<String, dynamic> json) => Banner(
        bannersId: json["banners_id"],
        offerName: json["offer_name"],
        offerDesc: json["offer_desc"],
        imageUrl: json["image_url"],
        signedUrl: json["signedUrl"],
        clientId: json["client_id"],
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        deletedAt: json["deletedAt"] == null ? null : DateTime.parse(json["deletedAt"]),
        offerId: json["offer_id"] == null ? null : DateTime.parse(json["offer_id"]),
        fileName: json["fileName"],
      );

  Map<String, dynamic> toJson() => {
        "fileName": bannersId,
        "banners_id": bannersId,
        "offer_name": offerName,
        "offer_desc": offerDesc,
        "image_url": imageUrl,
        "signedUrl": signedUrl,
        "client_id": clientId,
        "updatedAt": updatedAt?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
        "deletedAt": deletedAt?.toIso8601String(),
        "offer_id": offerId?.toIso8601String(),
      };
}
