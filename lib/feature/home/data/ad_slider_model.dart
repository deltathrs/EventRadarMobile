// To parse this JSON data, do
//
//     final adSliderModel = adSliderModelFromJson(jsonString);

import 'dart:convert';

List<AdSliderModel> adSliderModelFromJson(String str) =>
    List<AdSliderModel>.from(
        json.decode(str).map((x) => AdSliderModel.fromJson(x)));

String adSliderModelToJson(List<AdSliderModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AdSliderModel {
  String id;
  String image;
  String adUrl;

  AdSliderModel({
    required this.id,
    required this.image,
    required this.adUrl,
  });

  factory AdSliderModel.fromJson(Map<String, dynamic> json) => AdSliderModel(
        id: json["id"],
        image: json["image"],
        adUrl: json["ad_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "ad_url": adUrl,
      };
}
