// To parse this JSON data, do
//
//     final listEoModel = listEoModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<ListEoModel> listEoModelFromJson(String str) => List<ListEoModel>.from(
    json.decode(str).map((x) => ListEoModel.fromJson(x)));

String listEoModelToJson(List<ListEoModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListEoModel {
  String id;
  String fullname;
  String email;
  String domicile;
  String phoneNumber;
  String roles;
  String profile;

  ListEoModel({
    required this.id,
    required this.fullname,
    required this.email,
    required this.domicile,
    required this.phoneNumber,
    required this.roles,
    required this.profile,
  });

  factory ListEoModel.fromJson(Map<String, dynamic> json) => ListEoModel(
        id: json["id"],
        fullname: json["fullname"],
        email: json["email"],
        domicile: json["domicile"],
        phoneNumber: json["phone_number"],
        roles: json["roles"],
        profile: json["profile"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullname": fullname,
        "email": email,
        "domicile": domicile,
        "phone_number": phoneNumber,
        "roles": roles,
        "profile": profile,
      };
}
