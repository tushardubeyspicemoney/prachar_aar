// To parse this JSON data, do
//
//     final responseGetCampaign = responseGetCampaignFromJson(jsonString);

import 'dart:convert';

ResponseGetCampaign responseGetCampaignFromJson(String str) => ResponseGetCampaign.fromJson(json.decode(str));

String responseGetCampaignToJson(ResponseGetCampaign data) => json.encode(data.toJson());

class ResponseGetCampaign {
  ResponseGetCampaign({
    this.respStatus,
    this.respCode,
    this.respDesc,
    this.data,
  });

  String? respStatus;
  String? respCode;
  String? respDesc;
  Data? data;

  factory ResponseGetCampaign.fromJson(Map<String, dynamic> json) => ResponseGetCampaign(
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
    this.campgains,
    this.user,
    this.videos,
  });

  List<Campgain>? campgains;
  User? user;
  List<Video>? videos;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        campgains: List<Campgain>.from(json["campgains"].map((x) => Campgain.fromJson(x))),
        user: json["user"] == null ? User(clientId: "0") : User.fromJson(json["user"]),
        videos: List<Video>.from(json["videos"].map((x) => Video.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "campgains": List<dynamic>.from(campgains!.map((x) => x.toJson())),
        "user": user!.toJson(),
        "videos": List<dynamic>.from(videos!.map((x) => x.toJson())),
      };
}

class Campgain {
  Campgain({
    this.campaignId,
    this.contentTitle,
    this.contentDesc,
    this.videoLink,
  });

  int? campaignId;
  String? contentTitle;
  String? contentDesc;
  String? videoLink;

  factory Campgain.fromJson(Map<String, dynamic> json) => Campgain(
        campaignId: json["campaign_id"],
        contentTitle: json["content_title"],
        contentDesc: json["content_desc"],
        videoLink: json["video_link"],
      );

  Map<String, dynamic> toJson() => {
        "campaign_id": campaignId,
        "content_title": contentTitle,
        "content_desc": contentDesc,
        "video_link": videoLink,
      };
}

class User {
  User({
    this.clientId,
    this.shopName,
    this.industryDetails,
  });

  String? clientId;
  String? shopName;
  IndustryDetails? industryDetails;

  factory User.fromJson(Map<String, dynamic> json) => User(
        clientId: json["client_id"],
        shopName: json["shop_name"],
        industryDetails: IndustryDetails.fromJson(json["industryDetails"]),
      );

  Map<String, dynamic> toJson() => {
        "client_id": clientId,
        "shop_name": shopName,
        "industryDetails": industryDetails!.toJson(),
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

class Video {
  Video({
    this.title,
    this.url,
  });

  String? title;
  String? url;

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        title: json["title"],
        url: json["URL"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "URL": url,
      };
}
