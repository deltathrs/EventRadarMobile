// To parse this JSON data, do
//
//     final atendeesModel = atendeesModelFromJson(jsonString);

import 'dart:convert';

List<AtendeesModel> atendeesModelFromJson(String str) =>
    List<AtendeesModel>.from(
        json.decode(str).map((x) => AtendeesModel.fromJson(x)));

String atendeesModelToJson(List<AtendeesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AtendeesModel {
  String id;
  String fullname;
  String email;
  String? profile;
  String ticketType;
  String? profileGoogle;

  AtendeesModel({
    required this.id,
    required this.fullname,
    required this.email,
    this.profile,
    required this.ticketType,
    this.profileGoogle,
  });

  factory AtendeesModel.fromJson(Map<String, dynamic> json) => AtendeesModel(
        id: json["id"],
        fullname: json["fullname"],
        email: json["email"],
        profile: json["profile"] ?? "",
        ticketType: json["ticket_type"],
        profileGoogle: json["profile_google"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullname": fullname,
        "email": email,
        "profile": profile,
        "ticket_type": ticketType,
        "profile_google": profileGoogle,
      };
}
