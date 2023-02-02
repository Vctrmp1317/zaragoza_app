import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:fluttertoast/fluttertoast.dart';

final ttsOrder = FlutterTts();

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    ttsOrder.awaitSpeakCompletion(true);
    ttsOrder.speak('Estas en la pantalla de trámite de pedido');
    return Scaffold(
        appBar: _appbar(context),
        body: SingleChildScrollView(
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
                            margin: const EdgeInsets.only(top: 10, bottom: 10)),
                        Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const Text('Calle Hernan Cortes Nº20',
                                style: TextStyle(fontSize: 18)),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const Text('Codigo Postal: 11245',
                                style: TextStyle(fontSize: 18)),
                          ],
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
                            margin: const EdgeInsets.only(top: 10, bottom: 10)),
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
                          shadowColor: MaterialStateProperty.all(Colors.black),
                          side: MaterialStateProperty.all(
                              const BorderSide(color: Colors.black)),
                          elevation: MaterialStateProperty.all(10),
                          fixedSize:
                              MaterialStateProperty.all(const Size(300, 50)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white)),
                      onPressed: () {
                        ttsOrder.speak('Pedido efectuado con exito');
                        Fluttertoast.showToast(
                            msg: "Pedido efectuado con exito",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.green,
                            textColor: Colors.black,
                            fontSize: 16.0);
                        Timer(const Duration(seconds: 1), () {
                          Navigator.pushReplacementNamed(context, 'userscreen');
                        });
                      },
                      child: const Text('Confirmar Pedido',
                          style: TextStyle(fontSize: 18, color: Colors.black)))
                ],
              )
            ],
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
