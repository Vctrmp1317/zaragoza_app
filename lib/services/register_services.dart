import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class RegisterServices extends ChangeNotifier {
  final String _baseUrl = 'dressup.allsites.es';

  final storage = const FlutterSecureStorage();

  RegisterServices();

  postRegister(String name, String surname, String email, String password,
      String cPassword, String direccion) async {
    print(cPassword);
    final url = Uri.http(_baseUrl, '/public/api/register', {
      'nombre': name,
      'apellidos': surname,
      'direccion': direccion,
      'email': email,
      'password': password,
      'c_password': cPassword,
    });
    final response = await http
        .post(url, headers: {HttpHeaders.acceptHeader: 'application/json'});

    String resp = '';
    final Map<String, dynamic> register = json.decode(response.body);
    print(register);
    register.forEach((key, value) {
      if (register.containsKey('success')) {
        String? msg = '';
        msg = 'Usuario registrado correctamente';
        resp = msg;
      } else {
        String? error = '';

        error = 'Error al registrarse, ya existe una cuenta con ese email';

        resp = error;
      }
    });

    return resp;
  }

  Future<String> readId() async {
    return await storage.read(key: 'id') ?? '';
  }
}
