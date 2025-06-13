// To parse this JSON data, do
//
//     final balanceModel = balanceModelFromJson(jsonString);

import 'dart:convert';

BalanceModel balanceModelFromJson(String str) => BalanceModel.fromJson(json.decode(str));

String balanceModelToJson(BalanceModel data) => json.encode(data.toJson());

class BalanceModel {
    String currency;
    String organizerId;
    int totalBalance;

    BalanceModel({
        required this.currency,
        required this.organizerId,
        required this.totalBalance,
    });

    factory BalanceModel.fromJson(Map<String, dynamic> json) => BalanceModel(
        currency: json["currency"],
        organizerId: json["organizer_id"],
        totalBalance: json["total_balance"],
    );

    Map<String, dynamic> toJson() => {
        "currency": currency,
        "organizer_id": organizerId,
        "total_balance": totalBalance,
    };
}
