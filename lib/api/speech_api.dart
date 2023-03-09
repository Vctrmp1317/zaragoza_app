import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter/material.dart';

class SpeechApi {
  static final _speech = SpeechToText();

  static Future<bool> toggleRecording(
      {required Function(String text) onResult,
      required ValueChanged<bool> onListening}) async {
    if (_speech.isListening) {
      _speech.stop();
      print('Para');
      return true;
    }

    final isAvaible = await _speech.initialize(
        onStatus: (status) {
          print('ADIOS');
          print(status);
          print('HOLA' + _speech.isListening.toString());
          onListening(_speech.isListening);
        },
        // ignore: avoid_print
        onError: (e) => print('Error: $e'));

    if (isAvaible) {
      print('entra');
      await _speech.listen(onResult: (value) {
        print(value.recognizedWords + ' escucha');
        onResult(value.recognizedWords);
      });
      print('sale');
      return isAvaible;
    }
    print('sale2');
    return isAvaible;
  }
}
