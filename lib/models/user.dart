// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

// To parse this JSON data, do
//
//     final user = userFromMap(jsonString);

class DataUser {
  int? id;
  String? nombre;
  String? apellidos;
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
      this.nombre,
      this.apellidos,
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
    nombre = json['nombre'];
    apellidos = json['apellidos'];
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
    data['nombre'] = this.nombre;
    data['apellidos'] = this.apellidos;
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
