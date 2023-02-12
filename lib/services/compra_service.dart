import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../models/models.dart';
import 'services.dart';

class CompraServices extends ChangeNotifier {
  final String _baseUrl = '127.0.0.1:8000';

  bool isLoading = true;
  final storage = const FlutterSecureStorage();
  CompraServices() {}

  addCompra(int clienteId, int articuloId, int cantidad) async {
    String? token = await LoginServices().readToken();
    isLoading = true;

    final url = Uri.http(_baseUrl, '/api/compra', {
      'cliente_id': '$clienteId',
      'articulo_id': '$articuloId',
      'cantidad': '$cantidad',
    });
    final response = await http.post(url, headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });

    final Map<String, dynamic> articulossMap = json.decode(response.body);

    String resp;
    if (articulossMap.containsKey("Compra")) {
      resp = 'Añadido al carrito correctamente';
    } else {
      String? error = '';

      error = 'Error to add';

      resp = error;
    }
    return resp;
  }
}
