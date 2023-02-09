// To parse required this JSON data, do
//
//     final users = usersFromMap(jsonString);

// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class Users {
  Users({
    required this.success,
    required this.data,
    required this.message,
  });

  bool success;
  List<DataUsers> data;
  String message;

  factory Users.fromJson(String str) => Users.fromMap(json.decode(str));

  factory Users.fromMap(Map<String, dynamic> json) => Users(
        success: json["success"],
        data:
            List<DataUsers>.from(json["data"].map((x) => DataUsers.fromMap(x))),
        message: json["message"],
      );
}

class DataUsers {
  DataUsers({
    this.id,
    this.name,
    this.surname,
    this.actived,
    this.email,
    this.email_verified_at,
    this.direccion,
    this.deleted,
    this.tipo,
  });

  int? id;
  String? name;
  String? surname;
  String? direccion;
  int? actived;
  String? email;
  String? tipo;
  int? email_verified_at;
  int? deleted;

  factory DataUsers.fromJson(String str) => DataUsers.fromMap(json.decode(str));

  factory DataUsers.fromMap(Map<String, dynamic> json) => DataUsers(
        id: json["id"],
        direccion: json["direccion"],
        name: json["name"],
        surname: json["surname"],
        actived: json["actived"],
        email: json["email"],
        tipo: json["tipo"],
        email_verified_at: json["email_verified_at"],
        deleted: json["deleted"],
      );
}
