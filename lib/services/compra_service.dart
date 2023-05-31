import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../models/models.dart';
import 'services.dart';

class CompraServices extends ChangeNotifier {
  final String _baseUrl = 'dressup.allsites.es';

  bool isLoading = true;
  final storage = const FlutterSecureStorage();
  CompraServices() {}

  addCompra(String modelo, int cantidad, String talla) async {
    String? token = await LoginServices().readToken();
    String? id = await LoginServices().readId();
    print('ID: ' + token);
    isLoading = true;

    final url = Uri.http(_baseUrl, '/public/api/compra', {
      'cliente_id': id,
      'modelo': modelo,
      'talla': talla,
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

      error = response.body;

      resp = error;
    }
    return resp;
  }

  confirmCompra() async {
    String? token = await LoginServices().readToken();
    int? idCliente = int.parse(await LoginServices().readId());
    isLoading = true;
    print(idCliente);
    final url = Uri.http(
      _baseUrl,
      '/public/api/compras/confirmar/$idCliente',
    );
    final response = await http.patch(url, headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });

    final Map<String, dynamic> articulossMap = json.decode(response.body);

    String resp;
    if (articulossMap.containsKey("Compras realizadas")) {
      resp = 'Pedido realizado correctamente';
    } else {
      String? error = '';

      error = 'Error al efectuar el pedido';

      resp = error;
    }
    return resp;
  }
}
