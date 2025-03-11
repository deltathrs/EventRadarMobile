class Event {
  int id;
  String name;
  DateTime datetime;
  int maxParticipants;
  String location;
  bool isApproved;
  bool isOnline;
  int organizerId;
  String categoryName;
  String organizerName;

  Event({
    required this.id,
    required this.name,
    required this.datetime,
    required this.maxParticipants,
    required this.location,
    required this.isApproved,
    required this.isOnline,
    required this.organizerId,
    required this.categoryName,
    required this.organizerName,
  });

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        id: json["id"],
        name: json["name"],
        datetime: DateTime.parse(json["datetime"]),
        maxParticipants: json["max_participants"],
        location: json["location"],
        isApproved: json["is_approved"],
        isOnline: json["is_online"],
        organizerId: json["organizer_id"],
        categoryName: json["category_name"],
        organizerName: json["organizer_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "datetime": datetime.toIso8601String(),
        "max_participants": maxParticipants,
        "location": location,
        "is_approved": isApproved,
        "is_online": isOnline,
        "organizer_id": organizerId,
        "category_name": categoryName,
        "organizer_name": organizerName,
      };
}
