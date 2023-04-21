import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../models/models.dart';
import 'services.dart';

class AddArticulosServices extends ChangeNotifier {
  final String _baseUrl = 'dressup.allsites.es';

  final List<Articulos> articulos = [];
  bool isLoading = true;

  AddArticulosServices() {}

  addArticulo(
      String modelo,
      String marca,
      String tipo,
      String genero,
      String edad,
      String material,
      String color,
      String talla,
      int stock,
      int precio,
      XFile image) async {
    String? token = await LoginServices().readToken();
    isLoading = true;
    print(modelo);
    final Map<String, String> art = {
      'modelo': modelo,
      'marca': marca,
      'tipo': tipo,
      'genero': genero,
      'edad': genero,
      'material': material,
      'color': color,
      'talla': talla,
      'stock': '$stock',
      'precio': '$precio',
    };
    final url = Uri.http(_baseUrl, '/public/api/articulo', {
      'modelo': modelo,
      'marca': marca,
      'tipo': tipo,
      'genero': genero,
      'edad': genero,
      'material': material,
      'color': color,
      'talla': talla,
      'stock': '$stock',
      'precio': '$precio',
    });

    final request = http.MultipartRequest('POST', url)
      ..headers['Authorization'] = 'Bearer $token'
      ..headers['Accept'] = 'application/json'
      ..fields.addAll(art)
      ..files.add(await http.MultipartFile.fromPath('foto', image.path));
    // final response = await http.post(url, headers: {
    //   HttpHeaders.acceptHeader: 'application/json',
    //   HttpHeaders.fauthorizationHeader: 'Bearer $token'
    // });

    print(request.fields);
    print('añade');

    final response = await http.Response.fromStream(await request.send());

    final Map<String, dynamic> articulossMap = json.decode(response.body);
    print('envia');
    print(response.body);
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

  updateArticulo(String modelo, int stock, int precio, String tipo,
      String marca, String talla, int id) async {
    String? token = await LoginServices().readToken();
    isLoading = true;

    final url = Uri.http(_baseUrl, '/public/api/articulo/$id', {
      'modelo': modelo,
      'stock': '$stock',
      'precio': '$precio',
      'marca': marca,
      'tipo': tipo,
      'talla': talla,
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
