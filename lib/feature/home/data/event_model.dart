// To parse this JSON data, do
//
//     final eventModel = eventModelFromJson(jsonString);

import 'dart:convert';

List<EventModel> eventModelFromJson(String str) =>
    List<EventModel>.from(json.decode(str).map((x) => EventModel.fromJson(x)));

String eventModelToJson(List<EventModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EventModel {
  String id;
  String name;
  String eventDetail;
  DateTime datetime;
  DateTime endDatetime;
  int maxParticipants;
  String location;
  String status;
  bool isOnline;
  String organizerName;
  String organizerId;
  String eventThumbnail;
  List<String> categories;
  bool? isApproved;
  bool? isLiked;

  EventModel({
    required this.id,
    required this.name,
    required this.eventDetail,
    required this.datetime,
    required this.endDatetime,
    required this.maxParticipants,
    required this.location,
    required this.status,
    required this.isOnline,
    required this.organizerName,
    required this.organizerId,
    required this.eventThumbnail,
    required this.categories,
    this.isApproved,
    this.isLiked,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
        id: json["id"],
        name: json["name"],
        eventDetail: json["event_detail"],
        datetime: DateTime.parse(json["datetime"]),
        endDatetime: DateTime.parse(json["end_datetime"]),
        maxParticipants: json["max_participants"],
        location: json["location"],
        status: json["status"],
        isOnline: json["is_online"],
        organizerName: json["organizer_name"],
        organizerId: json["organizer_id"],
        eventThumbnail: json["event_thumbnail"],
        categories: List<String>.from(json["categories"].map((x) => x)),
        isApproved: json["is_approved"],
        isLiked: json.containsKey("is_liked") ? json["is_liked"] : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "event_detail": eventDetail,
        "datetime": datetime.toIso8601String(),
        "end_datetime": endDatetime.toIso8601String(),
        "max_participants": maxParticipants,
        "location": location,
        "status": status,
        "is_online": isOnline,
        "organizer_name": organizerName,
        "organizer_id": organizerId,
        "event_thumbnail": eventThumbnail,
        "categories": List<dynamic>.from(categories.map((x) => x)),
        "is_approved": isApproved,
        "is_liked": isLiked,
      };
}
