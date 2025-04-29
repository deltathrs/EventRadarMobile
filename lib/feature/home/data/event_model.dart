// To parse this JSON data, do
//
//     final eventModel = eventModelFromJson(jsonString);

import 'dart:convert';

List<EventModel> eventModelFromJson(String str) =>
    List<EventModel>.from(json.decode(str).map((x) => EventModel.fromJson(x)));

String eventModelToJson(List<EventModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EventModel {
  int id;
  String name;
  String eventDetail;
  DateTime datetime;
  int maxParticipants;
  String location;
  bool isApproved;
  bool isOnline;
  int organizerId;
  String eventThumbnail;
  List<String> categories;
  OrganizerName organizerName;

  EventModel({
    required this.id,
    required this.name,
    required this.eventDetail,
    required this.datetime,
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
        eventDetail: json["event_detail"],
        datetime: DateTime.parse(json["datetime"]),
        maxParticipants: json["max_participants"],
        location: json["location"],
        isApproved: json["is_approved"],
        isOnline: json["is_online"],
        organizerId: json["organizer_id"],
        eventThumbnail: json["event_thumbnail"],
        categories: List<String>.from(json["categories"].map((x) => x)),
        organizerName: organizerNameValues.map[json["organizer_name"]]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "event_detail": eventDetail,
        "datetime": datetime.toIso8601String(),
        "max_participants": maxParticipants,
        "location": location,
        "is_approved": isApproved,
        "is_online": isOnline,
        "organizer_id": organizerId,
        "event_thumbnail": eventThumbnail,
        "categories": List<dynamic>.from(categories.map((x) => x)),
        "organizer_name": organizerNameValues.reverse[organizerName],
      };
}

enum OrganizerName { BOB_JOHNSON, JANE_DOE }

final organizerNameValues = EnumValues({
  "Bob Johnson": OrganizerName.BOB_JOHNSON,
  "Jane Doe": OrganizerName.JANE_DOE
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
