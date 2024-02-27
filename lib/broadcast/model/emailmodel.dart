// To parse this JSON data, do
//
//     final clientEmail = clientEmailFromJson(jsonString);

import 'dart:convert';

List<ClientEmail> clientEmailFromJson(String str) => List<ClientEmail>.from(
    json.decode(str).map((x) => ClientEmail.fromJson(x)));

String clientEmailToJson(List<ClientEmail> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ClientEmail {
  String emailId;
  String deviceId;

  ClientEmail({
    required this.emailId,
    required this.deviceId,
  });

  factory ClientEmail.fromJson(Map<String, dynamic> json) => ClientEmail(
        emailId: json["email_id"],
        deviceId: json["device_id"],
      );

  Map<String, dynamic> toJson() => {
        "email_id": emailId,
        "device_id": deviceId,
      };
}
