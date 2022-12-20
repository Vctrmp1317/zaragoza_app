import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter/material.dart';

class SpeechApi {
  static final _speech = SpeechToText();

  static Future<bool> toggleRecording(
      {required Function(String text) onResult,
      required ValueChanged<bool> onListening}) async {
    if (_speech.isListening) {
      _speech.stop();
      return true;
    }
    final isAvaible = await _speech.initialize(
        onStatus: (status) => onListening(_speech.isListening),
        onError: (e) => print('Error: $e'));

    if (isAvaible) {
      _speech.listen(onResult: (value) => onResult(value.recognizedWords));

      return isAvaible;
    }

    return isAvaible;
  }
}
