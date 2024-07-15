// To parse this JSON data, do
//
//     final responseUserImages = responseUserImagesFromJson(jsonString);

import 'dart:convert';

ResponseUserImages responseUserImagesFromJson(String str) => ResponseUserImages.fromJson(json.decode(str));

String responseUserImagesToJson(ResponseUserImages data) => json.encode(data.toJson());

class ResponseUserImages {
  ResponseUserImages({
    this.respStatus,
    this.respCode,
    this.respDesc,
    this.data,
  });

  String? respStatus;
  String? respCode;
  String? respDesc;
  Data? data;

  factory ResponseUserImages.fromJson(Map<String, dynamic> json) => ResponseUserImages(
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
    this.userImages,
  });

  List<UserImage>? userImages;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userImages: json["user_images"] == null
            ? []
            : List<UserImage>.from(json["user_images"]!.map((x) => UserImage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "user_images": userImages == null ? [] : List<dynamic>.from(userImages!.map((x) => x.toJson())),
      };
}

class UserImage {
  UserImage({this.url, this.isActive, this.signedUrl, this.isDefault});

  String? url;
  String? signedUrl;
  int? isActive;
  int? isDefault;

  factory UserImage.fromJson(Map<String, dynamic> json) => UserImage(
        url: json["url"],
        signedUrl: json["signedUrl"],
        isActive: json["is_active"] ?? 0,
        isDefault: json["is_default"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "signedUrl": url,
        "is_active": isActive,
        "is_default": isDefault,
      };
}
