import 'dart:html';

import 'package:flutter/material.dart';
import 'package:zaragoza_app/screens/screens.dart';

class Command {
  static final all = {browser1, browser2, signIn, signUp, search};
  static const browser1 = 'go to';
  static const browser2 = 'open';
  static const signIn = 'iniciar sesion';
  static const signUp = 'registrar';
  static const search = 'buscar';
}

class Utils {
  static void scanText(String rawText, context) {
    final text = rawText.toLowerCase();

    if (text.contains(Command.browser1)) {
      if (text.contains('login')) {
        final body =
            _getTextAfterCommand(text: text, command: Command.browser1);

        goLogin(body: body, context: context);
      }
      if (text.contains('registro')) {
        final body =
            _getTextAfterCommand(text: text, command: Command.browser1);

        goRegistro(body: body, context: context);
      }
    } else if (text.contains('iniciar sesion')) {
      final body = _getTextAfterCommand(text: text, command: Command.signIn);
      signIn(body: body, context: context);
    } else if (text.contains('registrar')) {
      final body = _getTextAfterCommand(text: text, command: Command.signUp);
      signIn(body: body, context: context);
    } else if (text.contains('buscar')) {
      final body = _getTextAfterCommand(text: text, command: Command.signUp);
      search(body: body, context: context);
    }
  }

  static String _getTextAfterCommand({
    required String text,
    required String command,
  }) {
    final indexCommand = text.indexOf(command);
    final indexAfter = indexCommand + command.length;

    if (indexCommand == -1) {
      return '';
    } else {
      return text.substring(indexAfter).trim();
    }
  }

  static Future goLogin({required String body, required context}) async {
    return Navigator.popAndPushNamed(context, 'login');
  }

  static Future goRegistro({required String body, required context}) async {
    return Navigator.popAndPushNamed(context, 'registro');
  }

  static Future signIn({required String body, required context}) async {
    //LLAMA A LA API PARA INICIAR SESION
    String email;
    String password;
    var cadena = [];
    cadena = body.split('/');
    email = cadena[0];
    password = cadena[1];
  }

  static Future signUp({required String body, required context}) async {
    //LLAMA A LA API PARA REGISTRAR
    String email;
    String? nombre;
    String? apellidos;
    String? nombreDeEmpresa;
    String direccion;
    String password;

    if (nombreDeEmpresa != null) {
      var cadena = [];
      cadena = body.split('/');
      email = cadena[0];
      nombreDeEmpresa = cadena[1];
      direccion = cadena[2];
      password = cadena[3];
    } else {
      var cadena = [];
      cadena = body.split('/');
      email = cadena[0];
      nombre = cadena[1];
      apellidos = cadena[2];
      direccion = cadena[3];
      password = cadena[4];
    }
  }

  static Future search({required String body, required context}) async {
    return Navigator.popAndPushNamed(context, 'buscar');
  }
}
