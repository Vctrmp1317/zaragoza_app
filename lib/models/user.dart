// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

// To parse this JSON data, do
//
//     final user = userFromMap(jsonString);

class DataUser {
  int? id;
  String? name;
  String? surname;
  String? direccion;
  String? email;
  String? emailVerifiedAt;
  String? tipo;
  int? actived;
  int? deleted;
  String? createdAt;
  String? updatedAt;

  DataUser(
      {this.id,
      this.name,
      this.surname,
      this.direccion,
      this.email,
      this.emailVerifiedAt,
      this.tipo,
      this.actived,
      this.deleted,
      this.createdAt,
      this.updatedAt});

  DataUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    surname = json['surname'];
    direccion = json['direccion'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    tipo = json['tipo'];
    actived = json['actived'];
    deleted = json['deleted'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['surname'] = this.surname;
    data['direccion'] = this.direccion;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['tipo'] = this.tipo;
    data['actived'] = this.actived;
    data['deleted'] = this.deleted;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
