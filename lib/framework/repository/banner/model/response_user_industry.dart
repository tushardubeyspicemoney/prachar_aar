// To parse this JSON data, do
//
//     final responseUserIndustry = responseUserIndustryFromJson(jsonString);

import 'dart:convert';

import 'package:my_flutter_module/framework/repository/banner/model/response_banner_list.dart';

ResponseUserIndustry responseUserIndustryFromJson(String str) => ResponseUserIndustry.fromJson(json.decode(str));

String responseUserIndustryToJson(ResponseUserIndustry data) => json.encode(data.toJson());

class ResponseUserIndustry {
  ResponseUserIndustry({
    this.respStatus,
    this.respCode,
    this.respDesc,
    this.data,
  });

  String? respStatus;
  String? respCode;
  String? respDesc;
  Data? data;

  factory ResponseUserIndustry.fromJson(Map<String, dynamic> json) => ResponseUserIndustry(
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
    this.user,
    this.video,
    this.faq,
  });

  User? user;
  String? video;
  List<Faq>? faq;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: json["user"] == null ? User(clientId: "null") : User.fromJson(json["user"]),
        video: json["video"],
        faq: json["faq"] == null ? [] : List<Faq>.from(json["faq"]!.map((x) => Faq.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "video": video,
        "faq": faq == null ? [] : List<dynamic>.from(faq!.map((x) => x.toJson())),
      };
}

class Faq {
  Faq({
    this.question,
    this.answer,
  });

  String? question;
  String? answer;

  factory Faq.fromJson(Map<String, dynamic> json) => Faq(
        question: json["question"],
        answer: json["answer"],
      );

  Map<String, dynamic> toJson() => {
        "question": question,
        "answer": answer,
      };
}

class User {
  User(
      {this.clientId, this.address, this.shopName, this.phoneno, this.industryDetails, this.banners, this.contactInfo});

  String? clientId;
  String? address;
  String? phoneno;
  String? shopName;
  IndustryDetails? industryDetails;
  List<Poster>? banners;
  String? contactInfo;

  factory User.fromJson(Map<String, dynamic> json) => User(
        clientId: json["client_id"],
        address: json["address"],
        phoneno: json["phoneno"],
        shopName: json["shop_name"],
        contactInfo: json["contact_info"],
        industryDetails: json["industryDetails"] == null ? null : IndustryDetails.fromJson(json["industryDetails"]),
        banners: json["banners"] == null ? [] : List<Poster>.from(json["banners"]!.map((x) => Poster.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "client_id": clientId,
        "address": address,
        "shop_name": shopName,
        "phoneno": phoneno,
        "contact_info": contactInfo,
        "industryDetails": industryDetails?.toJson(),
        "banners": banners == null ? [] : List<dynamic>.from(banners!.map((x) => x.toJson())),
      };
}

class Poster {
  Poster({
    this.bannersId,
    this.offerName,
    this.offerDesc,
    this.status,
    this.imageUrl,
    this.signedUrl,
    this.originalOffer,
    this.fileName,
  });

  int? bannersId;
  int? status;
  String? offerName;
  String? offerDesc;
  String? imageUrl;
  String? signedUrl;
  OriginalOffer? originalOffer;
  String? fileName;

  factory Poster.fromJson(Map<String, dynamic> json) => Poster(
        bannersId: json["banners_id"],
        offerName: json["offer_name"],
        offerDesc: json["offer_desc"],
        status: json["status"],
        imageUrl: json["image_url"] ?? "",
        signedUrl: json["signedUrl"] ?? "",
        originalOffer: json["originalOffer"] == null ? null : OriginalOffer.fromJson(json["originalOffer"]),
        fileName: json["fileName"],
      );

  Map<String, dynamic> toJson() => {
        "banners_id": bannersId,
        "offer_name": offerName,
        "offer_desc": offerDesc,
        "image_url": imageUrl,
        "signedUrl": signedUrl,
        "status": status,
        "originalOffer": originalOffer?.toJson(),
        "fileName": fileName,
      };
}

class IndustryDetails {
  IndustryDetails({
    this.industryImage,
    this.industryId,
    this.industryName,
  });

  String? industryImage;
  int? industryId;
  String? industryName;

  factory IndustryDetails.fromJson(Map<String, dynamic> json) => IndustryDetails(
        industryImage: json["industry_image"],
        industryId: json["industry_id"],
        industryName: json["industry_name"],
      );

  Map<String, dynamic> toJson() => {
        "industry_image": industryImage,
        "industry_id": industryId,
        "industry_name": industryName,
      };
}
