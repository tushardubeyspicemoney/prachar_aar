// To parse this JSON data, do
//
//     final responseFaq = responseFaqFromJson(jsonString);

import 'dart:convert';

ResponseFaq responseFaqFromJson(String str) => ResponseFaq.fromJson(json.decode(str));

String responseFaqToJson(ResponseFaq data) => json.encode(data.toJson());

class ResponseFaq {
  ResponseFaq({
    this.respStatus,
    this.respCode,
    this.respDesc,
    this.data,
  });

  String? respStatus;
  String? respCode;
  String? respDesc;
  Data? data;

  factory ResponseFaq.fromJson(Map<String, dynamic> json) => ResponseFaq(
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
    this.faq,
  });

  List<FaqItem>? faq;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        faq: List<FaqItem>.from(json["faq"].map((x) => FaqItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "faq": List<dynamic>.from(faq!.map((x) => x.toJson())),
      };
}

class FaqItem {
  FaqItem({
    this.question,
    this.answer,
  });

  String? question;
  String? answer;

  factory FaqItem.fromJson(Map<String, dynamic> json) => FaqItem(
        question: json["question"],
        answer: json["answer"],
      );

  Map<String, dynamic> toJson() => {
        "question": question,
        "answer": answer,
      };
}
