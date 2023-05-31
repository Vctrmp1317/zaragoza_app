import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:zaragoza_app/models/user.dart';

import '../models/models.dart';
import 'package:http/http.dart' as http;

import 'login_services.dart';
import 'services.dart';

class UserServices extends ChangeNotifier {
  final String _baseUrl = 'dressup.allsites.es';

  late DataUser selectedUser = DataUser();
  late DataUser selectedUserE = DataUser();

  final List<DataUsers> users = [];
  final storage = const FlutterSecureStorage();

  bool isLoading = true;

  UserServices() {
    loadUser();
    loadUserId();
    getUsers();
  }

  Future loadUser() async {
    String? token = await LoginServices().readToken();
    String? id = await LoginServices().readId();

    notifyListeners();
    final url = Uri.http(_baseUrl, '/public/api/user/$id');
    final resp = await http.get(url, headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });

    final Map<String, dynamic> usersMap = json.decode(resp.body);

    usersMap.forEach((key, value) {
      if (usersMap.containsKey("user")) {
        final tempUser = DataUser.fromJson(value);

        selectedUser = tempUser;
        print(selectedUser.direccion);
      }
    });

    isLoading = false;
    notifyListeners();
    return selectedUser;
  }

  Future loadUserId() async {
    String? token = await LoginServices().readToken();
    String? id = await RegisterServices().readIdEdit();

    notifyListeners();
    final url = Uri.http(_baseUrl, '/public/api/user/$id');

    final resp = await http.get(url, headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });

    final Map<String, dynamic> usersMap = json.decode(resp.body);

    usersMap.forEach((key, value) {
      if (usersMap.containsKey("user")) {
        // print(value);
        final tempUser = DataUser.fromJson(value);
        print(tempUser.nombre);
        selectedUserE = tempUser;
      }
    });

    isLoading = false;
    notifyListeners();
    return selectedUserE;
  }

  Future deleteUser() async {
    String? token = await LoginServices().readToken();
    String? id = await RegisterServices().readIdEdit();
    print(id);
    notifyListeners();
    final url = Uri.http(_baseUrl, 'public/api/user/delete/$id');

    final resp = await http.put(url, headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });

    print(resp.body);

    isLoading = false;
    notifyListeners();
    return selectedUserE;
  }

  Future getUsers() async {
    users.clear();
    String? token = await LoginServices().readToken();
    isLoading = true;

    notifyListeners();
    final url = Uri.http(_baseUrl, '/public/api/users');
    final response = await http.get(url, headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });

    final Map<String, dynamic> usersMap = json.decode(response.body);
    //  print(response.body);
    usersMap.forEach((key, value) {
      if (usersMap.containsKey('users')) {
        final List<dynamic> usersMap1 = value;

        for (int i = 0; i < usersMap1.length; i++) {
          final tempUser = DataUsers.fromJson(usersMap1[i]);
          if (tempUser.deleted == 0) users.add(tempUser);
        }
      }
    });
    //   if (usersMap.containsKey('users')) {
    //     final List<dynamic> usersMap1 =value;

    //     for (int i = 0; i < usersMap1.length; i++) {
    //       final tempUser = DataUsers.fromJson(usersMap1[i]);
    //       users.add(tempUser);
    //     }
    //   }
    //   isLoading = false;
    //   notifyListeners();
    //   return users;
    // }
  }
}
