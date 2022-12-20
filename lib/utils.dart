import 'package:flutter/material.dart';
import 'package:zaragoza_app/screens/screens.dart';

class Command {
  static final all = {browser1, browser2};
  static const browser1 = 'go to';
  static const browser2 = 'open';
}

class Utils {
  static void scanText(String rawText, context) {
    final text = rawText.toLowerCase();

    if (text.contains(Command.browser1)) {
      final body = _getTextAfterCommand(text: text, command: Command.browser1);
      print(body);
      goLogin(body: body, context: context);
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
    print('llega');
    return Navigator.popAndPushNamed(context, 'login');
  }
}
