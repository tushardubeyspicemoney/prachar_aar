// To parse this JSON data, do
//
//     final responseIndustryList = responseIndustryListFromJson(jsonString);

import 'dart:convert';

ResponseIndustryList responseIndustryListFromJson(String str) => ResponseIndustryList.fromJson(json.decode(str));

String responseIndustryListToJson(ResponseIndustryList data) => json.encode(data.toJson());

class ResponseIndustryList {
  ResponseIndustryList({
    this.respStatus,
    this.respCode,
    this.respDesc,
    this.data,
  });

  String? respStatus;
  String? respCode;
  String? respDesc;
  Data? data;

  factory ResponseIndustryList.fromJson(Map<String, dynamic> json) => ResponseIndustryList(
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
    this.industries,
  });

  List<Industry>? industries;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        industries: List<Industry>.from(json["industries"].map((x) => Industry.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "industries": List<dynamic>.from(industries!.map((x) => x.toJson())),
      };
}

class Industry {
  Industry({
    this.industryImage,
    this.industryId,
    this.industryName,
  });

  String? industryImage;
  int? industryId;
  String? industryName;

  factory Industry.fromJson(Map<String, dynamic> json) => Industry(
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
