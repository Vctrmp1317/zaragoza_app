import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'services/services.dart';

class Command {
  static final all = {browser1, browser2, signIn, signUp, search};
  static const browser1 = 'ir a';
  static const browser2 = 'open';
  static const signIn = 'iniciar sesion';
  static const signUp = 'registrar';
  static const search = 'buscar';
}

class Utils {
  static void scanText(String rawText, context) {
    final text = rawText.toLowerCase();

    if (text.contains(Command.browser1)) {
      if (text.contains('inicio de sesion')) {
        final body =
            _getTextAfterCommand(text: text, command: Command.browser1);

        goLogin(body: body, context: context);
      }
      if (text.contains('registro')) {
        final body =
            _getTextAfterCommand(text: text, command: Command.browser1);

        goRegistro(body: body, context: context);
      }
      if (text.contains('inventario')) {
        final body =
            _getTextAfterCommand(text: text, command: Command.browser1);

        goInventario(body: body, context: context);
      }
      if (text.contains('escaner')) {
        final body =
            _getTextAfterCommand(text: text, command: Command.browser1);

        goScanner(body: body, context: context);
      }
      if (text.contains('generador')) {
        final body =
            _getTextAfterCommand(text: text, command: Command.browser1);

        goGenerador(body: body, context: context);
      }
      if (text.contains('carrito')) {
        final body =
            _getTextAfterCommand(text: text, command: Command.browser1);

        goCarrito(body: body, context: context);
      }
      if (text.contains('menu')) {
        final body =
            _getTextAfterCommand(text: text, command: Command.browser1);

        goMenu(body: body, context: context);
      }
      if (text.contains('hombre')) {
        final body =
            _getTextAfterCommand(text: text, command: Command.browser1);

        goHombre(body: body, context: context);
      }
      if (text.contains('mujer')) {
        final body =
            _getTextAfterCommand(text: text, command: Command.browser1);

        goMujer(body: body, context: context);
      }
      if (text.contains('juvenil')) {
        final body =
            _getTextAfterCommand(text: text, command: Command.browser1);

        goJuvenil(body: body, context: context);
      }
      if (text.contains('inicio de sesión')) {
        final body =
            _getTextAfterCommand(text: text, command: Command.browser1);

        goLogin(body: body, context: context);
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
    return Navigator.pushReplacementNamed(context, 'login');
  }

  static Future goInventario({required String body, required context}) async {
    return Navigator.pushReplacementNamed(context, 'buyscreen');
  }

  static Future goScanner({required String body, required context}) async {
    return Navigator.pushReplacementNamed(context, 'scannerscreen');
  }

  static Future goGenerador({required String body, required context}) async {
    return Navigator.pushReplacementNamed(context, 'outfitscreen');
  }

  static Future goDestacados({required String body, required context}) async {
    return Navigator.pushReplacementNamed(context, 'outfitscreen');
  }

  static Future goHombre({required String body, required context}) async {
    return Navigator.pushReplacementNamed(context, 'manclothscreen');
  }

  static Future goMujer({required String body, required context}) async {
    return Navigator.pushReplacementNamed(context, 'womanclothscreen');
  }

  static Future goJuvenil({required String body, required context}) async {
    return Navigator.pushReplacementNamed(context, 'kidsclothscreen');
  }

  static Future goCarrito({required String body, required context}) async {
    return Navigator.pushReplacementNamed(context, 'shoppingcartscreen');
  }

  static Future goMenu({required String body, required context}) async {
    return Navigator.pushReplacementNamed(context, 'userscreen');
  }

  static Future goRegistro({required String body, required context}) async {
    return Navigator.pushReplacementNamed(context, 'registro');
  }

  static Future signIn({required String body, required context}) async {
    //LLAMA A LA API PARA INICIAR SESION
    String email;
    String password;
    var cadena = [];
    cadena = body.split('/');
    email = cadena[0];
    password = cadena[1];

    final loginService = Provider.of<LoginServices>(context, listen: false);
    final userServices = Provider.of<UserServices>(context, listen: false);
    final String? errorMessage = await loginService.postLogin(email, password);

    if (errorMessage == 'A') {
      Navigator.pushNamed(context, 'tienda');
    } else if (errorMessage == 'U') {
      Navigator.pushNamed(context, 'userscreen');
      userServices.loadUser;

      Navigator.pushNamed(context, 'userscreen');
    } else {
      CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          title: 'Datos incorrectos',
          text: 'Email o Password incorrecto');
    }

    return errorMessage;
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
    return Navigator.pushReplacementNamed(context, 'searchscreen');
  }
}
