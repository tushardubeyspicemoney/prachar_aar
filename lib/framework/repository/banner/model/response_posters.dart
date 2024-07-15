// To parse this JSON data, do
//
//     final responsePosters = responsePostersFromJson(jsonString);

import 'dart:convert';

import 'package:my_flutter_module/framework/repository/banner/model/response_user_industry.dart';

ResponsePosters responsePostersFromJson(String str) => ResponsePosters.fromJson(json.decode(str));

String responsePostersToJson(ResponsePosters data) => json.encode(data.toJson());

class ResponsePosters {
  ResponsePosters({
    this.respStatus,
    this.respCode,
    this.respDesc,
    this.data,
  });

  String? respStatus;
  String? respCode;
  String? respDesc;
  Data? data;

  factory ResponsePosters.fromJson(Map<String, dynamic> json) => ResponsePosters(
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
    this.banners,
  });

  List<Poster>? banners;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        banners: json["banners"] == null ? [] : List<Poster>.from(json["banners"]!.map((x) => Poster.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "banners": banners == null ? [] : List<dynamic>.from(banners!.map((x) => x.toJson())),
      };
}
