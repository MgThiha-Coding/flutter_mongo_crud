// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

Mongomodel welcomeFromJson(String str) => Mongomodel.fromJson(json.decode(str));

String welcomeToJson(Mongomodel data) => json.encode(data.toJson());

class Mongomodel {
  ObjectId id;
  String firstName;
  String lastName;
  String address;

  Mongomodel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.address,
  });

  factory Mongomodel.fromJson(Map<String, dynamic> json) => Mongomodel(
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "address": address,
      };
}
