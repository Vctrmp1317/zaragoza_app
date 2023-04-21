import 'dart:async';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:zaragoza_app/api/speech_api.dart';
import 'package:zaragoza_app/services/services.dart';
import 'package:zaragoza_app/utils.dart';

import '../models/models.dart';

final ttsCompra = FlutterTts();

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final userService = UserServices();
  DataUser user = UserServices().selectedUser;
  Future refresh() async {
    await userService.loadUser();
    ttsCompra.setSpeechRate(0.5);
    ttsCompra.speak('Estás en el trámite de compra.');
    setState(() {
      user = userService.selectedUser;
      print(user.direccion);
    });
  }

  @override
  void initState() {
    super.initState();
    refresh();
  }

  bool isListening = false;
  String text = 'Press the button and start speaking';
  Future toggleRecording() => SpeechApi.toggleRecording(
      onResult: (text) => setState(() => this.text = text),
      onListening: (isListening) {
        setState(() => this.isListening = isListening = isListening);
      });

  @override
  Widget build(BuildContext context) {
    return userService.isLoading
        ? const Center(
            child: SpinKitWave(color: Color.fromRGBO(0, 153, 153, 1), size: 50))
        : Scaffold(
            appBar: _appbar(context),
            body: GestureDetector(
              onLongPress: toggleRecording,
              onLongPressEnd: (details) async {
                if (text.contains('ir a') || text.contains('buscar')) {
                  print(text);
                  Utils.scanText(text, context);
                }
                if (text == 'confirmar compra') {
                  final compraService =
                      Provider.of<CompraServices>(context, listen: false);
                  final String? msg = await compraService.confirmCompra();
                  if (msg == 'Pedido realizado correctamente') {
                    Fluttertoast.showToast(
                        msg: "Pedido efectuado con exito",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.green,
                        textColor: Colors.black,
                        fontSize: 16.0);
                    ttsCompra.speak('Pedido efectuado con éxito.');
                    Timer(const Duration(seconds: 1), () {
                      Navigator.pushReplacementNamed(context, 'userscreen');
                    });
                  } else {
                    CoolAlert.show(
                      context: context,
                      type: CoolAlertType.warning,
                      title: msg,

                      borderRadius: 30,
                      //loopAnimation: true,
                      confirmBtnColor: Colors.blueAccent,
                      confirmBtnText: 'Aceptar',

                      onConfirmBtnTap: () {
                        Navigator.pop(context);
                      },
                    );
                  }
                }
              },
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const SizedBox(height: 5),
                        Container(
                          margin: const EdgeInsets.all(30),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black54),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(2),
                              // ignore: prefer_const_literals_to_create_immutables
                              boxShadow: [
                                const BoxShadow(
                                  color: Colors.black38,
                                  blurRadius: 5,
                                  offset: Offset(0, 0),
                                )
                              ]),
                          width: 300,
                          height: 200,
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  const Text('Mis direcciones',
                                      style: TextStyle(fontSize: 18)),
                                ],
                              ),
                              Container(
                                  height: 1,
                                  width: 300,
                                  color: Colors.black54,
                                  margin: const EdgeInsets.only(
                                      top: 10, bottom: 10)),
                              Row(
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  Text(user.direccion!,
                                      style: TextStyle(fontSize: 18)),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(30),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black54),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(2),
                              // ignore: prefer_const_literals_to_create_immutables
                              boxShadow: [
                                const BoxShadow(
                                  color: Colors.black38,
                                  blurRadius: 5,
                                  offset: Offset(0, 0),
                                )
                              ]),
                          width: 300,
                          height: 200,
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  const Text('Usar otra direccion',
                                      style: TextStyle(fontSize: 18)),
                                ],
                              ),
                              Container(
                                  height: 1,
                                  width: 300,
                                  color: Colors.black54,
                                  margin: const EdgeInsets.only(
                                      top: 10, bottom: 10)),
                              Form(
                                  child: Column(
                                children: [
                                  TextFormField(
                                    autocorrect: false,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: const InputDecoration(
                                      focusColor: Colors.black,
                                      hintText: 'Direccion:',
                                      labelText: 'Direccion:',
                                      suffixIcon: Icon(Icons.fmd_good_sharp),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                  TextFormField(
                                    autocorrect: false,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      focusColor: Colors.black,
                                      hintText: 'Codigo Postal:',
                                      labelText: 'Codigo Postal:',
                                      suffixIcon: Icon(Icons.numbers),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ],
                              ))
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                            style: ButtonStyle(
                                shadowColor:
                                    MaterialStateProperty.all(Colors.black),
                                side: MaterialStateProperty.all(
                                    const BorderSide(color: Colors.black)),
                                elevation: MaterialStateProperty.all(10),
                                fixedSize: MaterialStateProperty.all(
                                    const Size(300, 50)),
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white)),
                            onPressed: () async {
                              final compraService = Provider.of<CompraServices>(
                                  context,
                                  listen: false);
                              final String? msg =
                                  await compraService.confirmCompra();
                              if (msg == 'Pedido realizado correctamente') {
                                Fluttertoast.showToast(
                                    msg: "Pedido efectuado con exito",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.green,
                                    textColor: Colors.black,
                                    fontSize: 16.0);
                                Timer(const Duration(seconds: 1), () {
                                  Navigator.pushReplacementNamed(
                                      context, 'userscreen');
                                });
                              } else {
                                CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.warning,
                                  title: msg,

                                  borderRadius: 30,
                                  //loopAnimation: true,
                                  confirmBtnColor: Colors.blueAccent,
                                  confirmBtnText: 'Aceptar',

                                  onConfirmBtnTap: () {
                                    Navigator.pop(context);
                                  },
                                );
                              }
                            },
                            child: const Text('Confirmar Pedido',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black)))
                      ],
                    )
                  ],
                ),
              ),
            ));
  }

  AppBar _appbar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      elevation: 0,
      title: Row(
        children: [
          const Text('Pedido',
              style: TextStyle(color: Colors.white, fontSize: 25)),
          const Spacer(),
          const SizedBox(width: 8),
          Container(
            child: IconButton(
              color: Colors.white,
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, 'userscreen', (route) => false);
              },
              icon: const Icon(Icons.logout),
            ),
          )
        ],
      ),
    );
  }
}

// ignore: camel_case_types
class _dividerLine extends StatelessWidget {
  const _dividerLine({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: const BoxDecoration(
              color: Colors.black,
              gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.centerLeft,
                  colors: [Colors.black, Colors.black38])),
          height: 1,
          width: 130,
          margin: const EdgeInsets.only(left: 20, bottom: 5, top: 5),
        ),
        Container(
          decoration: const BoxDecoration(
              color: Colors.black,
              gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.centerRight,
                  colors: [Colors.black, Colors.black38])),
          height: 1,
          width: 180,
          margin: const EdgeInsets.only(right: 20, bottom: 5, top: 5),
        ),
      ],
    );
  }
}
