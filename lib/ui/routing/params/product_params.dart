// To parse this JSON data, do
//
//     final productParams = productParamsFromJson(jsonString);

import 'dart:convert';

ProductParams productParamsFromJson(String str) => ProductParams.fromJson(json.decode(str));

String productParamsToJson(ProductParams data) => json.encode(data.toJson());

class ProductParams {
  ProductParams({
    this.product = "",
    this.clientId = "",
    this.token = "",
    this.aggId = "",
    this.udf1 = "",
    this.lang = "en",
    this.bcAgentId = "",
    this.loginId = "",
    this.type = "",
  });

  String product;
  String clientId;
  String token;
  String aggId;
  String udf1;
  String lang;
  String bcAgentId;
  String loginId;
  String type;

  factory ProductParams.fromJson(Map<String, dynamic> json) => ProductParams(
        product: json["product"] ?? "",
        clientId: json["clientId"] ?? "",
        token: json["token"] ?? "",
        aggId: json["aggId"] ?? "",
        udf1: json["udf1"] ?? "",
        lang: json["lang"] ?? "",
        bcAgentId: json["bcAgentId"] ?? "",
        loginId: json["loginId"] ?? "",
        type: json["type"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "product": product,
        "clientId": clientId,
        "token": token,
        "aggId": aggId,
        "udf1": udf1,
        "lang": lang,
        "bcAgentId": bcAgentId,
        "loginId": loginId,
        "type": type,
      };
}
