// To parse this JSON data, do
//
//     final eventModel = eventModelFromJson(jsonString);

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

List<EventModel> eventModelFromJson(String str) =>
    List<EventModel>.from(json.decode(str).map((x) => EventModel.fromJson(x)));

String eventModelToJson(List<EventModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EventModel {
  int id;
  String name;
  DateTime datetime;
  DateTime registrationEnd;
  int maxParticipants;
  String location;
  bool isApproved;
  bool isOnline;
  int organizerId;
  String eventThumbnail;
  List<String> categories;
  String organizerName;

  EventModel({
    required this.id,
    required this.name,
    required this.datetime,
    required this.registrationEnd,
    required this.maxParticipants,
    required this.location,
    required this.isApproved,
    required this.isOnline,
    required this.organizerId,
    required this.eventThumbnail,
    required this.categories,
    required this.organizerName,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
        id: json["id"],
        name: json["name"],
        datetime: DateTime.parse(json["datetime"]),
        registrationEnd: DateTime.parse(json["registration_end"]),
        maxParticipants: json["max_participants"],
        location: json["location"],
        isApproved: json["is_approved"],
        isOnline: json["is_online"],
        organizerId: json["organizer_id"],
        eventThumbnail: json["event_thumbnail"],
        categories: List<String>.from(json["categories"].map((x) => x)),
        organizerName: json["organizer_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "datetime": datetime.toIso8601String(),
        "registration_end": registrationEnd.toIso8601String(),
        "max_participants": maxParticipants,
        "location": location,
        "is_approved": isApproved,
        "is_online": isOnline,
        "organizer_id": organizerId,
        "event_thumbnail": eventThumbnail,
        "categories": List<dynamic>.from(categories.map((x) => x)),
        "organizer_name": organizerName,
      };
}
