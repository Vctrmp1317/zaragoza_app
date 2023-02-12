import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/models.dart';
import 'services.dart';

class AddArticulosServices extends ChangeNotifier {
  final String _baseUrl = '127.0.0.1:8000';

  final List<Articulos> articulos = [];
  bool isLoading = true;

  AddArticulosServices() {}

  addArticulo(String modelo, String marca, String tipo, String genero,
      String edad, String material, String color, int stock, int precio) async {
    String? token = await LoginServices().readToken();
    isLoading = true;

    final url = Uri.http(_baseUrl, '/api/articulo', {
      'modelo': modelo,
      'marca': marca,
      'tipo': tipo,
      'genero': genero,
      'edad': genero,
      'material': material,
      'color': color,
      'stock': '$stock',
      'precio': '$precio',
    });
    final response = await http.post(url, headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });

    final Map<String, dynamic> articulossMap = json.decode(response.body);

    String resp;
    if (articulossMap.containsValue(true)) {
      resp = 'articulo añadido correctamente';
    } else {
      String? error = '';

      error = 'Error to add';

      resp = error;
    }
    return resp;
  }

  updateArticulo(String modelo, int stock, int precio, int id) async {
    String? token = await LoginServices().readToken();
    isLoading = true;

    final url = Uri.http(_baseUrl, '/api/articulo/$id', {
      'modelo': modelo,
      'stock': '$stock',
      'precio': '$precio',
      'marca': 'marca',
      'tipo': 'tipo'
    });
    final response = await http.put(url, headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });

    final Map<String, dynamic> articulossMap = json.decode(response.body);
    print(articulossMap);
    String resp;
    if (articulossMap.containsKey('id')) {
      resp = 'articulo actualizado correctamente';
    } else {
      String? error = '';

      error = 'Error to add';

      resp = error;
    }
    return resp;
  }
}
