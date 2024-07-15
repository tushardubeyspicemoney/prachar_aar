// To parse this JSON data, do
//
//     final requestSavePoster = requestSavePosterFromJson(jsonString);

import 'dart:convert';

RequestEditPoster requestSavePosterFromJson(String str) => RequestEditPoster.fromJson(json.decode(str));

String requestEditPosterToJson(RequestEditPoster data) => json.encode(data.toJson());

class RequestEditPoster {
  RequestEditPoster({
    required this.bannerId,
    required this.offerName,
    required this.offerDesc,
    required this.imageUrl,
  });

  String offerName;
  String bannerId;
  String offerDesc;
  String imageUrl;

  factory RequestEditPoster.fromJson(Map<String, dynamic> json) => RequestEditPoster(
        offerName: json["offerName"],
        bannerId: json["bannerId"],
        offerDesc: json["offerDesc"],
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "bannerId": bannerId,
        "offerName": offerName,
        "offerDesc": offerDesc,
        "imageUrl": imageUrl,
      };
}
