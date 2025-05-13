// To parse this JSON data, do
//
//     final myEventModel = myEventModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<MyEventModel> myEventModelFromJson(String str) => List<MyEventModel>.from(
    json.decode(str).map((x) => MyEventModel.fromJson(x)));

String myEventModelToJson(List<MyEventModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MyEventModel {
  String id;
  String name;
  String eventDetail;
  DateTime datetime;
  DateTime endDatetime;
  int maxParticipants;
  String location;
  bool isOnline;
  String organizerName;
  String organizerId;
  String eventThumbnail;
  List<String> categories;

  MyEventModel({
    required this.id,
    required this.name,
    required this.eventDetail,
    required this.datetime,
    required this.endDatetime,
    required this.maxParticipants,
    required this.location,
    required this.isOnline,
    required this.organizerName,
    required this.organizerId,
    required this.eventThumbnail,
    required this.categories,
  });

  factory MyEventModel.fromJson(Map<String, dynamic> json) => MyEventModel(
        id: json["id"],
        name: json["name"],
        eventDetail: json["event_detail"],
        datetime: DateTime.parse(json["datetime"]),
        endDatetime: DateTime.parse(json["end_datetime"]),
        maxParticipants: json["max_participants"],
        location: json["location"],
        isOnline: json["is_online"],
        organizerName: json["organizer_name"],
        organizerId: json["organizer_id"],
        eventThumbnail: json["event_thumbnail"],
        categories: List<String>.from(json["categories"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "event_detail": eventDetail,
        "datetime": datetime.toIso8601String(),
        "end_datetime": endDatetime.toIso8601String(),
        "max_participants": maxParticipants,
        "location": location,
        "is_online": isOnline,
        "organizer_name": organizerName,
        "organizer_id": organizerId,
        "event_thumbnail": eventThumbnail,
        "categories": List<dynamic>.from(categories.map((x) => x)),
      };
}
