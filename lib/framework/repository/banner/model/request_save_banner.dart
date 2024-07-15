// To parse this JSON data, do
//
//     final requestSaveBanner = requestSaveBannerFromJson(jsonString);

import 'dart:convert';

RequestSaveBanner requestSaveBannerFromJson(String str) => RequestSaveBanner.fromJson(json.decode(str));

String requestSaveBannerToJson(RequestSaveBanner data) => json.encode(data.toJson());

class RequestSaveBanner {
  RequestSaveBanner({
    this.offerName,
    this.offerDesc,
    this.offerId,
  });

  String? offerName;
  String? offerDesc;
  int? offerId;

  factory RequestSaveBanner.fromJson(Map<String, dynamic> json) => RequestSaveBanner(
        offerName: json["offerName"],
        offerDesc: json["offerDesc"],
        offerId: json["offerId"],
      );

  Map<String, dynamic> toJson() => {
        "offerName": offerName,
        "offerDesc": offerDesc,
        "offerId": offerId,
      };
}
