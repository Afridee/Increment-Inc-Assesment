// To parse this JSON data, do
//
//     final imdbItem = imdbItemFromJson(jsonString);

import 'dart:convert';

ImdbItem imdbItemFromJson(String str) => ImdbItem.fromJson(json.decode(str));

String imdbItemToJson(ImdbItem data) => json.encode(data.toJson());

class ImdbItem {
  ImdbItem({
    required this.i,
    required this.id,
    required this.l,
    required this.q,
  });

  I i;
  String id;
  String l;
  String q;

  factory ImdbItem.fromJson(Map<String, dynamic> json) => ImdbItem(
    i: I.fromJson(json["i"]),
    id: json["id"],
    l: json["l"],
    q: json["q"],
  );

  Map<String, dynamic> toJson() => {
    "i": i.toJson(),
    "id": id,
    "l": l,
    "q": q,
  };
}

class I {
  I({
    required this.height,
    required this.imageUrl,
    required this.width,
  });

  int height;
  String imageUrl;
  int width;

  factory I.fromJson(Map<String, dynamic> json) => I(
    height: json["height"],
    imageUrl: json["imageUrl"],
    width: json["width"],
  );

  Map<String, dynamic> toJson() => {
    "height": height,
    "imageUrl": imageUrl,
    "width": width,
  };
}
