// To parse required this JSON data, do
//
//     final users = usersFromMap(jsonString);

// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class Users {
  List<DataUsers>? users;

  Users({this.users});

  Users.fromJson(Map<String, dynamic> json) {
    if (json['users'] != null) {
      users = <DataUsers>[];
      json['users'].forEach((v) {
        users!.add(DataUsers.fromJson(v));
      });
    }
  }
}

// class DataUsers {
//   DataUsers({
//     this.id,
//     this.name,
//     this.surname,
//     this.actived,
//     this.email,
//     this.email_verified_at,
//     this.direccion,
//     this.deleted,
//     this.tipo,
//   });

//   int? id;
//   String? name;
//   String? surname;
//   String? direccion;
//   int? actived;
//   String? email;
//   String? tipo;
//   int? email_verified_at;
//   int? deleted;

//   factory DataUsers.fromJson(String str) => DataUsers.fromMap(json.decode(str));

//   factory DataUsers.fromMap(Map<String, dynamic> json) => DataUsers(
//         id: json["id"],
//         direccion: json["direccion"],
//         name: json["name"],
//         surname: json["surname"],
//         actived: json["actived"],
//         email: json["email"],
//         tipo: json["tipo"],
//         email_verified_at: json["email_verified_at"],
//         deleted: json["deleted"],
//       );
// }

class DataUsers {
  DataUsers({
    this.id,
    this.nombre,
    this.apellidos,
    this.actived,
    this.email,
    this.email_verified_at,
    this.direccion,
    this.deleted,
    this.tipo,
  });

  int? id;
  String? nombre;
  String? apellidos;
  String? direccion;
  int? actived;
  String? email;
  String? tipo;
  String? email_verified_at;
  int? deleted;

  DataUsers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nombre = json['nombre'];
    apellidos = json['apellidos'];
    direccion = json['direccion'];
    email = json['email'];
    email_verified_at = json['email_verified_at'];
    tipo = json['tipo'];
    actived = json['actived'];
    deleted = json['deleted'];
  }

  factory DataUsers.fromMap(Map<String, dynamic> json) => DataUsers(
        id: json["id"],
        direccion: json["direccion"],
        nombre: json["nombre"],
        apellidos: json["apellidos"],
        actived: json["actived"],
        email: json["email"],
        tipo: json["tipo"],
        email_verified_at: json["email_verified_at"],
        deleted: json["deleted"],
      );
}
