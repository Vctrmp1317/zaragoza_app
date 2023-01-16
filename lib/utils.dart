import 'dart:html';

import 'package:flutter/material.dart';
import 'package:zaragoza_app/screens/screens.dart';

class Command {
  static final all = {browser1, browser2, signIn, signUp};
  static const browser1 = 'go to';
  static const browser2 = 'open';
  static const signIn = 'iniciar sesion';
  static const signUp = 'registrar';
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
    } else if (text.contains('iniciar sesion')) {
      //LLAMA A LA API PARA INICIAR SESION
    } else if (text.contains('registrar')) {
      //LLAMA A LA API PARA REGISTRAR
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

  static Future signIn({required String body, required context}) async {}
}
