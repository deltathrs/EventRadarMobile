// To parse this JSON data, do
//
//     final eventDetailModel = eventDetailModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

EventDetailModel eventDetailModelFromJson(String str) =>
    EventDetailModel.fromJson(json.decode(str));

String eventDetailModelToJson(EventDetailModel data) =>
    json.encode(data.toJson());

class EventDetailModel {
  String id;
  String name;
  String eventDetail;
  DateTime datetime;
  DateTime endDatetime;
  int maxParticipants;
  String location;
  bool isApproved;
  bool isOnline;
  String organizerName;
  String organizerId;
  String eventThumbnail;
  List<String> categories;
  List<Ticket> tickets;

  EventDetailModel({
    required this.id,
    required this.name,
    required this.eventDetail,
    required this.datetime,
    required this.endDatetime,
    required this.maxParticipants,
    required this.location,
    required this.isApproved,
    required this.isOnline,
    required this.organizerName,
    required this.organizerId,
    required this.eventThumbnail,
    required this.categories,
    required this.tickets,
  });

  factory EventDetailModel.fromJson(Map<String, dynamic> json) =>
      EventDetailModel(
        id: json["id"],
        name: json["name"],
        eventDetail: json["event_detail"] ?? "",
        datetime: DateTime.parse(json["datetime"]),
        endDatetime: DateTime.parse(json["end_datetime"]),
        maxParticipants: json["max_participants"],
        location: json["location"] ?? "Online",
        isApproved: json["is_approved"] ?? true,
        isOnline: json["is_online"],
        organizerName: json["organizer_name"],
        organizerId: json["organizer_id"],
        eventThumbnail: json["event_thumbnail"] ?? "",
        categories: List<String>.from(json["categories"].map((x) => x)),
        tickets: List<Ticket>.from(
          (json["tickets"] ?? []).map((x) => Ticket.fromJson(x)),
        ),
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
        "is_online": isOnline,
        "organizer_name": organizerName,
        "organizer_id": organizerId,
        "event_thumbnail": eventThumbnail,
        "categories": List<dynamic>.from(categories.map((x) => x)),
        "tickets": List<dynamic>.from(tickets.map((x) => x.toJson())),
      };
}

class Ticket {
  String id;
  String ticketType;
  int ticketLimit;
  double price;
  String description;
  DateTime registrationEnd;

  Ticket({
    required this.id,
    required this.ticketType,
    required this.ticketLimit,
    required this.price,
    required this.description,
    required this.registrationEnd,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
        id: json["id"],
        ticketType: json["ticket_type"],
        ticketLimit: json["ticket_limit"],
        price: json["price"]?.toDouble(),
        description: json["description"],
        registrationEnd: DateTime.parse(json["registration_end"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ticket_type": ticketType,
        "ticket_limit": ticketLimit,
        "price": price,
        "description": description,
        "registration_end": registrationEnd.toIso8601String(),
      };
}
