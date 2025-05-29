// To parse this JSON data, do
//
//     final profileDataModel = profileDataModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ProfileDataModel profileDataModelFromJson(String str) =>
    ProfileDataModel.fromJson(json.decode(str));

String profileDataModelToJson(ProfileDataModel data) =>
    json.encode(data.toJson());

class ProfileDataModel {
  String id;
  String fullname;
  String email;
  String roles;
  String domicile;
  String phoneNumber;
  String profile;
  String profileGoogle;

  ProfileDataModel({
    required this.id,
    required this.fullname,
    required this.email,
    required this.roles,
    required this.domicile,
    required this.phoneNumber,
    required this.profile,
    required this.profileGoogle,
  });

  factory ProfileDataModel.fromJson(Map<String, dynamic> json) =>
      ProfileDataModel(
        id: json["id"] ?? "",
        fullname: json["fullname"] ?? "",
        email: json["email"] ?? "",
        roles: json["roles"] ?? "",
        domicile: json['domicile'] ?? "",
        phoneNumber: json['phone_number'] ?? "",
        profile: json['profile'] ?? "",
        profileGoogle: json['profile_google'] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullname": fullname,
        "email": email,
        "domicile": domicile,
        "phone_number": phoneNumber,
        "profile": profile,
        "roles": roles,
      };
}
