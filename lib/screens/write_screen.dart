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

import '../models/models.dart';
import '../services/services.dart';

final ttsWrite = FlutterTts();
var _counter = 0;

class WriteScreen extends StatefulWidget {
  const WriteScreen({Key? key}) : super(key: key);

  @override
  State<WriteScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<WriteScreen> {
  final articuloService = ArticuloService();

  Articulo articulo = Articulo();

  Future refresh() async {
    await articuloService.getArticulo();

    setState(() {
      articulo = articuloService.selectedArticulo;
    });
  }

  @override
  Widget build(BuildContext context) {
    ttsWrite.awaitSpeakCompletion(true);

    return Scaffold(
      appBar: _appbar(context),
      body: GestureDetector(
        onLongPress: () async {
          List<NDEFRecord> lista = [];
          lista.add(NDEFRecord.text(
              'Chaqueta de vestir, color negro, marca: mango, talla: XL'));
          // lista.add(NDEFRecord.text(articulo.modelo! +
          //     '. color:' +
          //     articulo.color! +
          //     ', marca:' +
          //     articulo.marca! +
          //     ', talla:' +
          //     articulo.talla! +

          //     '. '));
          NDEFMessage newMessage = NDEFMessage.withRecords(lista);
          Stream<NDEFTag> stream = NFC.writeNDEF(newMessage, once: true);

          stream.listen((NDEFTag tag) {
            print("only wrote to one tag!");
          });
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
          const SizedBox(width: 8),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: IconButton(
              color: Colors.black,
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, 'tienda', (route) => false);
              },
              icon: const Icon(Icons.logout),
            ),
          )
        ],
      ),
    );
  }
}

StreamSubscription? _nfcStream;
_readNFCAndroid() async {
  NDEFMessage? nfcTag;

  try {
    /// readNDEF starts listening for NDEF formatted tags. Any non-NDEF formatted
    /// tags will be filtered out. So no need to check for NDEF format.

    // ignore: cancel_subscriptions
    StreamSubscription<NDEFMessage> subscription = NFC
        .readNDEF(
      once: false, // keep reading!!
      throwOnUserCancel: true,
    )
        .listen((tag) {
      // NFC read success
      nfcTag = tag;
    },
            // When the stream is done, remove the subscription from state
            onDone: () async {
      _nfcStream = null;
      if (nfcTag!.isEmpty || nfcTag!.payload == null) {
        // invalid tag. Ignore it!
      } else {
        // Its a valid tag. Ignore it!
      }
    },
            // Errors are unlikely to happen on Android unless the NFC tags are
            // poorly formatted or removed too soon, however on iOS at least one
            // error is likely to happen. NFCUserCanceledSessionException will
            // always happen unless you call readNDEF() with the `throwOnUserCancel`
            // argument set to false.
            // NFCSessionTimeoutException will be thrown if the session timer exceeds
            // 60 seconds (iOS only).
            // And then there are of course errors for unexpected stuff. Good fun!
            onError: (e) {
      _stopNFC();
    });

    // set _nfcStream with this subscription so that it can be cancelled.
    _nfcStream = subscription;
  } catch (e) {
    _stopNFC();
  }
}

_stopNFC() {
  _nfcStream?.cancel();
  _nfcStream = null;
}
