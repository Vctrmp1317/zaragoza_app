import 'dart:async';
import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nfc_in_flutter/nfc_in_flutter.dart';
import 'package:provider/provider.dart';
import 'package:zaragoza_app/providers/add_form_provider.dart';

final ttsScanner = FlutterTts();
var _counter = 0;

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({Key? key}) : super(key: key);

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  @override
  Widget build(BuildContext context) {
    ttsScanner.awaitSpeakCompletion(true);
    ttsScanner.speak('Bienvenido estas en la pantalla de escaner');
    return Scaffold(
      appBar: _appbar(context),
      body: GestureDetector(
        onDoubleTap: () {
          Navigator.pushReplacementNamed(context, 'userscreen');
        },
        onLongPress: () async {
          NDEFMessage message = await NFC
              .readNDEFDispatch(
                once: true, // keep reading!!
                throwOnUserCancel: true,
              )
              .first;
          print(message.records.elementAt(0).data);
          ttsScanner.speak(message.records.elementAt(0).data);
        },
        child: const ClipRRect(
          child: FadeInImage(
            placeholder: AssetImage('assets/no-image.jpg'),
            image: AssetImage('assets/no-image.jpg'),
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  AppBar _appbar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Row(
        children: [
          const Spacer(),
          Container(
            child: IconButton(
              color: Colors.black,
              icon: const Icon(Icons.shopping_bag),
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'shoppingcartscreen');
              },
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      leading: IconButton(
        color: Colors.black,
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(
              context, 'userscreen', (route) => false);
        },
        icon: const Icon(Icons.logout),
      ),
    );
  }
}
