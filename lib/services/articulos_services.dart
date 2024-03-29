import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../models/models.dart';
import 'services.dart';

class ArticulosServices extends ChangeNotifier {
  final String _baseUrl = 'dressup.allsites.es';

  final List<Articulos> articulos = [];

  Articulo selectedArticulo = Articulo();
  bool isLoading = true;
  final storage = const FlutterSecureStorage();
  ArticulosServices() {
    getArticulos();
  }

  getArticulos() async {
    articulos.clear();
    String? token = await LoginServices().readToken();
    isLoading = true;

    notifyListeners();
    final url = Uri.http(_baseUrl, '/public/api/articulos');
    final response = await http.get(url, headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });
    print(json.decode(response.body));
    final Map<String, dynamic> articulossMap = json.decode(response.body);

    articulossMap.forEach((key, value) {
      if (articulossMap.containsKey('Articulos')) {
        final List<dynamic> articulosMap1 = value;
        for (int i = 0; i < articulosMap1.length; i++) {
          final tempArticulo = Articulos.fromJson(articulosMap1[i]);
          if (tempArticulo.deleted == 0) articulos.add(tempArticulo);
        }
      }
    });
    isLoading = false;
    notifyListeners();
    return articulos;
  }

  getArticulosGenero(String genero) async {
    String? token = await LoginServices().readToken();
    isLoading = true;

    notifyListeners();
    final url = Uri.http(_baseUrl, '/public/api/articulos/genero/$genero');
    final response = await http.get(url, headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });

    final Map<String, dynamic> articulossMap = json.decode(response.body);

    articulossMap.forEach((key, value) {
      if (articulossMap.containsKey('Articulos')) {
        final List<dynamic> articulosMap1 = value;
        for (int i = 0; i < articulosMap1.length; i++) {
          final tempArticulo = Articulos.fromJson(articulosMap1[i]);

          articulos.add(tempArticulo);
        }
      }
    });
    isLoading = false;
    notifyListeners();
    return articulos;
  }

  getArticulosEdad(String edad) async {
    String? token = await LoginServices().readToken();
    isLoading = true;

    notifyListeners();
    final url = Uri.http(_baseUrl, '/public/api/articulos/edad/$edad');
    final response = await http.get(url, headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });

    final Map<String, dynamic> articulossMap = json.decode(response.body);

    articulossMap.forEach((key, value) {
      if (articulossMap.containsKey('Articulos')) {
        final List<dynamic> articulosMap1 = value;
        for (int i = 0; i < articulosMap1.length; i++) {
          final tempArticulo = Articulos.fromJson(articulosMap1[i]);

          articulos.add(tempArticulo);
        }
      }
    });
    isLoading = false;
    notifyListeners();
    return articulos;
  }

  Future loadArticulo(int id) async {
    String? token = await LoginServices().readToken();
    storage.write(key: 'idArticulo', value: id.toString());
    isLoading = true;
    notifyListeners();
    final url = Uri.http(_baseUrl, '/public/api/articulos/$id');
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

  Future loadArticuloEdit() async {
    String? token = await LoginServices().readToken();
    String? id = await readId();
    isLoading = true;
    notifyListeners();
    final url = Uri.http(_baseUrl, '/public/api/articulos/$id');
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

  Future<String> readId() async {
    String? i = await storage.read(key: 'idArticulo') ?? '';
    print(i);
    return i;
  }
}
