// To parse this JSON data, do
//
//     final requestSavePoster = requestSavePosterFromJson(jsonString);

import 'dart:convert';

RequestSavePoster requestSavePosterFromJson(String str) => RequestSavePoster.fromJson(json.decode(str));

String requestSavePosterToJson(RequestSavePoster data) => json.encode(data.toJson());

class RequestSavePoster {
  RequestSavePoster(
      {required this.offerName, required this.offerDesc, required this.imageUrl, required this.createFor});

  String offerName;
  String offerDesc;
  String imageUrl;
  String createFor;

  factory RequestSavePoster.fromJson(Map<String, dynamic> json) => RequestSavePoster(
        offerName: json["offerName"],
        offerDesc: json["offerDesc"],
        imageUrl: json["imageUrl"],
        createFor: json["createdFor"],
      );

  Map<String, dynamic> toJson() => {
        "offerName": offerName,
        "offerDesc": offerDesc,
        "imageUrl": imageUrl,
        "createdFor": createFor,
      };
}
