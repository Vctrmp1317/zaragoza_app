import 'dart:convert';
import 'dart:html';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../models/models.dart';
import 'services.dart';

class ArticuloService extends ChangeNotifier {
  final String _baseUrl = 'dressup.allsites.es';

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
    final url = Uri.http(_baseUrl, '/public/api/articulo/$id');
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
      '/public/api/articulo/vistas/$id',
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

  addComment(String comment, int mark) async {
    String? token = await LoginServices().readToken();
    String? id = await LoginServices().readId();
    String? idArt = await LoginServices().readIdArt();

    isLoading = true;

    final Map<String, String> art = {
      'comentario': comment,
      'valoracion': '$mark',
      'user_id': id,
      'articulo_id': idArt
    };
    final url = Uri.http(_baseUrl, '/public/api/valoracion', {
      'comentario': comment,
      'valoracion': '$mark',
      'user_id': id,
      'articulo_id': idArt
    });

    final request = http.MultipartRequest('POST', url)
      ..headers['Authorization'] = 'Bearer $token'
      ..headers['Accept'] = 'application/json'
      ..fields.addAll(art);
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
      resp = 'comentario añadido correctamente';
    } else {
      String? error = '';

      error = 'Error to add';

      resp = error;
    }
    return resp;
  }
}
