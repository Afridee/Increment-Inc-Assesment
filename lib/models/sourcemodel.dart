// To parse this JSON data, do
//
//     final sourceModel = sourceModelFromJson(jsonString);

import 'dart:convert';

SourceModel sourceModelFromJson(String str) => SourceModel.fromJson(json.decode(str));

String sourceModelToJson(SourceModel data) => json.encode(data.toJson());

class SourceModel {
  SourceModel({
    required this.displayName,
    required this.id,
    required this.url,
    required this.name,
    required this.icon,
  });

  String displayName;
  String id;
  String url;
  String name;
  String icon;

  factory SourceModel.fromJson(Map<String, dynamic> json) => SourceModel(
    displayName: json["display_name"],
    id: json["id"],
    url: json["url"],
    name: json["name"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "display_name": displayName,
    "id": id,
    "url": url,
    "name": name,
    "icon": icon,
  };
}
