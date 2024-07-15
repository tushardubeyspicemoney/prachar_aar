import 'package:flutter/material.dart';

class DashboardModel {
  DashboardModel({
    required this.title,
    required this.isEnabled,
    required this.globalKey,
  });

  String title;
  GlobalKey globalKey;
  bool isEnabled;

  factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
        title: json['title'],
        isEnabled: json['isEnabled'],
        globalKey: json['globalKey'],
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'isEnabled': isEnabled,
        'globalKey': globalKey,
      };
}
