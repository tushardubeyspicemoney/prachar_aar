// To parse this JSON data, do
//
//     final requestEditAddress = requestEditAddressFromJson(jsonString);

import 'dart:convert';

RequestEditAddress requestEditAddressFromJson(String str) => RequestEditAddress.fromJson(json.decode(str));

String requestEditAddressToJson(RequestEditAddress data) => json.encode(data.toJson());

class RequestEditAddress {
  RequestEditAddress({
    this.contactInfo,
  });

  String? contactInfo;

  factory RequestEditAddress.fromJson(Map<String, dynamic> json) => RequestEditAddress(
        contactInfo: json["contact_info"],
      );

  Map<String, dynamic> toJson() => {
        "contact_info": contactInfo,
      };
}
