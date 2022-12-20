import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:zaragoza_app/utils.dart';

import '../api/speech_api.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String text = 'Press the button and start speaking';
  bool isListening = false;
  Future toggleRecording() => SpeechApi.toggleRecording(
      onResult: (text) => setState(() => this.text = text),
      onListening: (isListening) {
        setState(() => this.isListening = isListening = isListening);

        if (!isListening) {
          Future.delayed(Duration(seconds: 1), () {
            print(text);
            Utils.scanText(text, context);
          });
        }
      });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        reverse: true,
        padding: const EdgeInsets.all(30).copyWith(bottom: 150),
        child: Text(text),
      ),
      floatingActionButton: AvatarGlow(
        animate: isListening,
        endRadius: 75,
        child: FloatingActionButton(
          child: Icon(isListening ? Icons.mic : Icons.mic_none),
          onPressed: toggleRecording,
        ),
      ),
    );
  }
}
