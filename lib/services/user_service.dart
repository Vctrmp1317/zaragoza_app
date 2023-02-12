import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:zaragoza_app/models/user.dart';

import '../models/models.dart';
import 'package:http/http.dart' as http;

import 'login_services.dart';

class UserServices extends ChangeNotifier {
  final String url1 =
      Platform.isAndroid ? '192.168.178.23:3006' : 'localhost:3006';
  final String _baseUrl = '127.0.0.1:8000';

  late DataUser selectedUser = DataUser();
  final storage = const FlutterSecureStorage();

  bool isLoading = true;

  UserServices() {
    loadUser();
  }

  Future loadUser() async {
    String? token = await LoginServices().readToken();
    String? id = await LoginServices().readId();

    notifyListeners();
    final url = Uri.http(_baseUrl, '/api/user/$id');
    final resp = await http.get(url, headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });

    final Map<String, dynamic> usersMap = json.decode(resp.body);

    usersMap.forEach((key, value) {
      if (usersMap.containsKey("user")) {
        final tempUser = DataUser.fromJson(value);

        selectedUser = tempUser;
      }
    });

    isLoading = false;
    notifyListeners();
    return selectedUser;
  }
}
