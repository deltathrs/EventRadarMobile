// To parse this JSON data, do
//
//     final eoEventModel = eoEventModelFromJson(jsonString);

import 'dart:convert';

List<EoEventModel> eoEventModelFromJson(String str) => List<EoEventModel>.from(
    json.decode(str).map((x) => EoEventModel.fromJson(x)));

String eoEventModelToJson(List<EoEventModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EoEventModel {
  String id;
  String name;
  String eventDetail;
  DateTime datetime;
  DateTime endDatetime;
  int maxParticipants;
  String location;
  bool isApproved;
  String status;
  bool isOnline;
  String organizerName;
  String organizerId;
  String eventThumbnail;
  List<String> categories;
  bool? isLiked;

  EoEventModel({
    required this.id,
    required this.name,
    required this.eventDetail,
    required this.datetime,
    required this.endDatetime,
    required this.maxParticipants,
    required this.location,
    required this.isApproved,
    required this.status,
    required this.isOnline,
    required this.organizerName,
    required this.organizerId,
    required this.eventThumbnail,
    required this.categories,
    this.isLiked,
  });

  factory EoEventModel.fromJson(Map<String, dynamic> json) => EoEventModel(
        id: json["id"],
        name: json["name"],
        eventDetail: json["event_detail"],
        datetime: DateTime.parse(json["datetime"]),
        endDatetime: DateTime.parse(json["end_datetime"]),
        maxParticipants: json["max_participants"],
        location: json["location"],
        isApproved: json["is_approved"] ?? true,
        status: json["status"],
        isOnline: json["is_online"], 
        organizerName: json["organizer_name"],
        organizerId: json["organizer_id"],
        eventThumbnail: json["event_thumbnail"],
        categories: List<String>.from(json["categories"].map((x) => x)),
        isLiked: json["is_liked"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "event_detail": eventDetail,
        "datetime": datetime.toIso8601String(),
        "end_datetime": endDatetime.toIso8601String(),
        "max_participants": maxParticipants,
        "location": location,
        "is_approved": isApproved,
        "status": status,
        "is_online": isOnline,
        "organizer_name": organizerName,
        "organizer_id": organizerId,
        "event_thumbnail": eventThumbnail,
        "categories": List<dynamic>.from(categories.map((x) => x)),
        "is_liked": isLiked,
      };
}
