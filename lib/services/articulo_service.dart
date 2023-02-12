import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../models/models.dart';
import 'services.dart';

class ArticuloService extends ChangeNotifier {
  final String _baseUrl = '127.0.0.1:8000';

  Articulo selectedArticulo = Articulo();
  bool isLoading = true;
  final storage = const FlutterSecureStorage();

  ArticuloService() {
    getArticulo();
  }

  Future getArticulo() async {
    String? token = await LoginServices().readToken();
    String? id = await ArticulosServices().readId();
    isLoading = true;
    notifyListeners();
    final url = Uri.http(_baseUrl, '/api/articulo/$id');
    final resp = await http.get(url, headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });

    final Map<String, dynamic> articuloMap = json.decode(resp.body);

    articuloMap.forEach((key, value) {
      if (articuloMap.containsKey("Articulo")) {
        final tempArticulo = Articulo.fromJson(value);

        selectedArticulo = tempArticulo;
      }
    });

    isLoading = false;

    notifyListeners();
    return selectedArticulo;
  }

  addVistaArticulo(int id) async {
    String? token = await LoginServices().readToken();

    isLoading = true;

    final url = Uri.http(
      _baseUrl,
      '/api/articulo/vistas/$id',
    );
    final response = await http.patch(url, headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });

    final Map<String, dynamic> articulossMap = json.decode(response.body);

    String resp;
    if (articulossMap.containsKey("Articulo")) {
      resp = 'articulo añadido correctamente';
    } else {
      String? error = '';

      error = 'Error to add';

      resp = error;
    }
    print(resp);
    return resp;
  }
}
