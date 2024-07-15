// To parse this JSON data, do
//
//     final requestUpdateBanner = requestUpdateBannerFromJson(jsonString);

import 'dart:convert';

RequestUpdateBanner requestUpdateBannerFromJson(String str) => RequestUpdateBanner.fromJson(json.decode(str));

String requestUpdateBannerToJson(RequestUpdateBanner data) => json.encode(data.toJson());

class RequestUpdateBanner {
  RequestUpdateBanner({
    this.offerName,
    this.offerDesc,
    this.offerId,
    this.bannerId,
  });

  String? offerName;
  String? offerDesc;
  int? offerId;
  int? bannerId;

  factory RequestUpdateBanner.fromJson(Map<String, dynamic> json) => RequestUpdateBanner(
        offerName: json["offerName"],
        offerDesc: json["offerDesc"],
        offerId: json["offerId"],
        bannerId: json["bannerId"],
      );

  Map<String, dynamic> toJson() => {
        "offerName": offerName,
        "offerDesc": offerDesc,
        "offerId": offerId,
        "bannerId": bannerId,
      };
}
