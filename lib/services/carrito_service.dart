import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../models/models.dart';
import 'services.dart';

class CarritoServices extends ChangeNotifier {
  final String _baseUrl = '127.0.0.1:8000';
  final List<Articulos> articulos = [];
  double total = 0.0;
  bool isLoading = true;
  final storage = const FlutterSecureStorage();

  CarritoServices() {}

  getCarrito() async {
    String? token = await LoginServices().readToken();
    String? idCliente = await LoginServices().readId();
    isLoading = true;

    notifyListeners();
    final url = Uri.http(_baseUrl, '/api/carrito/$idCliente');
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
          total = total + tempArticulo.precio!;
          articulos.add(tempArticulo);
        }
      }
    });
    isLoading = false;
    notifyListeners();
    return articulos;
  }
}
