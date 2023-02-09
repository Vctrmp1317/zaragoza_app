// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class LoginServices extends ChangeNotifier {
  final String url1 =
      Platform.isAndroid ? '192.168.178.23:3006' : 'localhost:3006';
  final String _baseUrl = '127.0.0.1:8000';

  final storage = const FlutterSecureStorage();

  LoginServices();

  postLogin(String email, String password) async {
    final url =
        Uri.http(url1, '/api/login', {'email': email, 'password': password});

    final response = await http
        .post(url, headers: {HttpHeaders.acceptHeader: 'application/json'});

    var type;
    String error;
    var resp;
    final Map<String, dynamic> login = json.decode(response.body);

    login.forEach((key, value) {
      if (login.containsKey('token')) {
        storage.write(key: 'token', value: value['token']);
        storage.write(key: 'id', value: value['id'].toString());
        type = value['tipo'];
        resp = type;
      } else {
        String? error = '';

        error = 'ERROR AL INICIAR SESION. COMPRUEBA TU EMAIL O CONTRASEÑA';

        resp = error;
      }
    });

    return resp;
  }

  Future logout() async {
    await storage.delete(key: 'token');
    return;
  }

  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }

  Future<String> readId() async {
    String? i = await storage.read(key: 'id') ?? '';
    print(i);
    return i;
  }
}
