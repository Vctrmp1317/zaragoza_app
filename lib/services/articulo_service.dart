import 'dart:convert';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:zaragoza_app/models/comments.dart';

import '../models/models.dart';
import 'services.dart';

class ArticuloService extends ChangeNotifier {
  final String _baseUrl = 'dressup.allsites.es';
  final List<Comments> comments = [];
  Comments selectedComment = Comments();
  Articulo selectedArticulo = Articulo();
  bool isLoading = true;
  final storage = const FlutterSecureStorage();

  ArticuloService() {
    //getArticulo();
    // getComments();
  }

  Future deleteArticulo(int id) async {
    String? token = await LoginServices().readToken();

    notifyListeners();
    final url = Uri.http(_baseUrl, 'public/api/articulo/delete/$id');
    final resp = await http.put(url, headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });

    isLoading = false;
    notifyListeners();
    return 'Eliminado correctamente';
  }

  Future getArticulo() async {
    String? token = await LoginServices().readToken();
    String? id = await ArticulosServices().readId();
    print('ID: ' + id);
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
    print(selectedArticulo.modelo);
    print(selectedArticulo.stock);

    isLoading = false;
    print(isLoading);
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
      'puntuacion': '$mark',
      'user_id': id,
      'articulo_id': idArt
    };
    final url = Uri.http(_baseUrl, '/public/api/valoracion', {
      'comentario': comment,
      'puntuacion': '$mark',
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

  getComments() async {
    comments.clear();
    String? token = await LoginServices().readToken();
    String? id = await ArticulosServices().readId();
    isLoading = true;
    notifyListeners();
    final url = Uri.http(_baseUrl, '/public/api/articulos/$id/valoraciones');
    final resp = await http.get(url, headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });
    print(json.decode(resp.body));
    final Map<String, dynamic> commentsMap = json.decode(resp.body);
    print('hola');
    commentsMap.forEach((key, value) {
      if (commentsMap.containsKey('Valoraciones')) {
        final List<dynamic> commentsMap1 = value;
        for (int i = 0; i < commentsMap1.length; i++) {
          final tempComment = Comments.fromJson(commentsMap1[i]);

          comments.add(tempComment);
        }
      }
    });

    isLoading = false;

    notifyListeners();
    return comments;
  }

  Future getComment() async {
    String? token = await LoginServices().readToken();
    String? id = await ArticuloService().readIdComment();

    isLoading = true;
    notifyListeners();
    final url = Uri.http(_baseUrl, '/public/api/valoracion/$id');
    final resp = await http.get(url, headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });

    final Map<String, dynamic> articuloMap = json.decode(resp.body);

    articuloMap.forEach((key, value) {
      if (articuloMap.containsKey("Valoracion")) {
        final tempComment = Comments.fromJson(value);

        selectedComment = tempComment;
      }
    });

    isLoading = false;
    print(isLoading);
    notifyListeners();
    return selectedComment;
  }

  Future deleteComments(int id) async {
    String? token = await LoginServices().readToken();

    notifyListeners();
    final url = Uri.http(_baseUrl, 'public/api/valoracion/$id');
    final resp = await http.delete(url, headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });

    isLoading = false;
    notifyListeners();
    return 'Eliminado correctamente';
  }

  editComment(String comentario) async {
    String? token = await LoginServices().readToken();
    String? id = await ArticuloService().readIdComment();
    isLoading = true;

    final url = Uri.http(_baseUrl, '/public/api/valoraciones/$id', {
      'comentario': comentario,
    });
    final response = await http.put(url, headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });

    final Map<String, dynamic> articulossMap = json.decode(response.body);
    print(articulossMap);
    String resp;
    if (articulossMap.containsKey('id')) {
      resp = 'Valoracion actualizada correctamente';
    } else {
      String? error = '';

      error = response.body;

      resp = error;
    }
    return resp;
  }

  Future<String> readIdComment() async {
    return await storage.read(key: 'idComment') ?? '';
  }
}
