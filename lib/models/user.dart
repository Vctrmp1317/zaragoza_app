// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

// To parse this JSON data, do
//
//     final user = userFromMap(jsonString);

class User {
  User({
    required this.success,
    required this.data,
    required this.message,
  });

  bool success;
  DataUser data;
  String message;

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  factory User.fromMap(Map<String, dynamic> json) => User(
        success: json["success"],
        data: DataUser.fromMap(json["data"]),
        message: json["message"],
      );
}

class DataUser {
  DataUser({
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

  factory DataUser.fromJson(String str) => DataUser.fromMap(json.decode(str));

  factory DataUser.fromMap(Map<String, dynamic> json) => DataUser(
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
