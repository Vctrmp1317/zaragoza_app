import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:zaragoza_app/api/speech_api.dart';
import 'package:zaragoza_app/providers/add_form_provider.dart';
import 'package:zaragoza_app/utils.dart';

import '../services/services.dart';

final _counter = 0;
final ttsUser = FlutterTts();

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  String text = 'Press the button and start speaking';

  bool isListening = false;
  Future _toggleRecording() async {
    SpeechApi.toggleRecording(onResult: (text) {
      setState(() => this.text = text);
      print('ENTRA 2');
    }, onListening: (isListening) {
      setState(() => this.isListening = isListening = isListening);
      print('ENTRA');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appbar(context),
        body: GestureDetector(
          onLongPress: _toggleRecording,
          onLongPressEnd: (details) {
            Utils.scanText(text, context);
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const _searchBar(),
                    const SizedBox(height: 5),
                    Container(
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        child: const _fondoImagen()),
                    const ProductsCategoriesUser(),
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
        leading: IconButton(
          color: Colors.white,
          onPressed: () {
            final loginService =
                Provider.of<LoginServices>(context, listen: false);
            loginService.logout();
            Navigator.pushNamedAndRemoveUntil(
                context, 'login2', (route) => false);
          },
          icon: const Icon(Icons.logout),
        ),
        title: Row(
          children: [
            const Text('Inicio',
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            const Spacer(),
            Stack(children: [
              IconButton(
                color: Colors.white,
                icon: const Icon(Icons.shopping_bag),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, 'shoppingcartscreen');
                },
              ),
              Positioned(
                child: Text('$_counter',
                    style: const TextStyle(color: Colors.black)),
              )
            ]),
            IconButton(
              color: Colors.white,
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'buyscreen');
              },
              icon: const Icon(Icons.schedule_send_sharp),
            )
          ],
        ));
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

// ignore: camel_case_types
class _searchBar extends StatefulWidget {
  const _searchBar({super.key});

  @override
  State<_searchBar> createState() => __searchBarState();
}

// ignore: camel_case_types
class __searchBarState extends State<_searchBar> {
  void updateList(String value) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            margin: const EdgeInsetsDirectional.only(start: 10, bottom: 10),
            height: 30,
            width: 250,
            child: Row(children: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, 'searchscreen');
                },
              ),
            ])),
        const Spacer(),
        Container(
            margin: const EdgeInsets.only(right: 20),
            child: IconButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, 'scannerscreen');
                },
                icon: const Icon(Icons.nfc)))
      ],
    );
  }
}

class ProductsCategoriesUser extends StatefulWidget {
  const ProductsCategoriesUser({super.key});

  @override
  State<ProductsCategoriesUser> createState() => _ProductsCategoriesUserState();
}

class _ProductsCategoriesUserState extends State<ProductsCategoriesUser> {
  @override
  void initState() {
    super.initState();
    ttsUser.speak('Bienvenido a la pantalla de inicio.');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 10),
        height: 400,
        width: 400,
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.48,
                        height: 200,
                        child: GestureDetector(
                          child: const Card(
                            categoria: 'Niño',
                          ),
                          onTap: () => {
                            Navigator.pushReplacementNamed(
                                context, 'kidsclothscreen')
                          },
                        ))
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.48,
                        height: 200,
                        child: GestureDetector(
                          child: const Card2(categoria: 'Hombre'),
                          onTap: () => {
                            Navigator.pushReplacementNamed(
                                context, 'manclothscreen')
                          },
                        ))
                  ],
                )
              ],
            ),
            Row(
              children: [
                Column(
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.48,
                        height: 200,
                        child: GestureDetector(
                          child: const Card3(categoria: 'Mujer'),
                          onTap: () => {
                            Navigator.pushReplacementNamed(
                                context, 'womanclothscreen')
                          },
                        ))
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.48,
                        height: 200,
                        child: GestureDetector(
                          child: const Card4(categoria: 'Destacados'),
                          onTap: () => {print('categoria')},
                        ))
                  ],
                )
              ],
            ),
          ],
        ));
  }
}

class Card extends StatelessWidget {
  const Card({
    super.key,
    required String categoria,
  });

  static final String categoria = categoria;

  @override
  Widget build(BuildContext context) {
    TextEditingController customController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        width: 10,
        height: 220,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black54),
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            // ignore: prefer_const_literals_to_create_immutables
            boxShadow: [
              const BoxShadow(
                color: Colors.black38,
                blurRadius: 5,
                offset: Offset(0, 0),
              )
            ]),
        child: Column(
          children: [
            Stack(children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.yellow,
                ),
                width: 300,
                height: 145,
                // ignore: prefer_const_literals_to_create_immutables
                child: Stack(children: [
                  const ClipRRect(
                    child: FadeInImage(
                      placeholder: AssetImage('assets/no-image.jpg'),
                      image: AssetImage('assets/ropaNino.jpg'),
                      width: 300,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ]),
              ),
            ]),
            const Positioned(
                top: 2,
                left: 5,
                child: Text('Niño',
                    style: TextStyle(
                        fontSize: 18, backgroundColor: Colors.white38))),
          ],
        ),
      ),
    );
  }
}

class Card4 extends StatelessWidget {
  const Card4({
    super.key,
    required String categoria,
  });

  static final String categoria = categoria;

  @override
  Widget build(BuildContext context) {
    TextEditingController customController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        width: 10,
        height: 220,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black54),
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            // ignore: prefer_const_literals_to_create_immutables
            boxShadow: [
              const BoxShadow(
                color: Colors.black38,
                blurRadius: 5,
                offset: Offset(0, 0),
              )
            ]),
        child: Column(
          children: [
            Stack(children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.yellow,
                ),
                width: 300,
                height: 145,
                // ignore: prefer_const_literals_to_create_immutables
                child: Stack(children: [
                  const ClipRRect(
                    child: FadeInImage(
                      placeholder: AssetImage('assets/no-image.jpg'),
                      image: AssetImage('assets/ropaDestacado.jpg'),
                      width: 300,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ]),
              ),
            ]),
            const Positioned(
                top: 2,
                left: 5,
                child: Text('Destacado',
                    style: TextStyle(
                        fontSize: 18, backgroundColor: Colors.white38))),
          ],
        ),
      ),
    );
  }
}

class Card3 extends StatelessWidget {
  const Card3({
    super.key,
    required String categoria,
  });

  static final String categoria = categoria;

  @override
  Widget build(BuildContext context) {
    TextEditingController customController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        width: 10,
        height: 220,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black54),
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            // ignore: prefer_const_literals_to_create_immutables
            boxShadow: [
              const BoxShadow(
                color: Colors.black38,
                blurRadius: 5,
                offset: Offset(0, 0),
              )
            ]),
        child: Column(
          children: [
            Stack(children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.yellow,
                ),
                width: 300,
                height: 145,
                // ignore: prefer_const_literals_to_create_immutables
                child: Stack(children: [
                  const ClipRRect(
                    child: FadeInImage(
                      placeholder: AssetImage('assets/no-image.jpg'),
                      image: AssetImage('assets/ropaMujer.jpg'),
                      width: 300,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                  ),
                ]),
              ),
            ]),
            const Positioned(
                left: 1,
                child: Text('Mujer',
                    style: TextStyle(
                        fontSize: 18, backgroundColor: Colors.white38))),
          ],
        ),
      ),
    );
  }
}

class Card2 extends StatelessWidget {
  const Card2({
    super.key,
    required String categoria,
  });

  static final String categoria = categoria;

  @override
  Widget build(BuildContext context) {
    TextEditingController customController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        width: 10,
        height: 220,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black54),
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            // ignore: prefer_const_literals_to_create_immutables
            boxShadow: [
              const BoxShadow(
                color: Colors.black38,
                blurRadius: 5,
                offset: Offset(0, 0),
              )
            ]),
        child: Column(
          children: [
            Stack(children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.yellow,
                ),
                width: 300,
                height: 145,
                // ignore: prefer_const_literals_to_create_immutables
                child: Stack(children: [
                  const ClipRRect(
                    child: FadeInImage(
                      placeholder: AssetImage('assets/no-image.jpg'),
                      image: AssetImage('assets/ropaHombre.jpg'),
                      width: 300,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ]),
              ),
            ]),
            const Positioned(
                top: 2,
                left: 5,
                child: Text('Hombre',
                    style: TextStyle(
                        fontSize: 18, backgroundColor: Colors.white38))),
          ],
        ),
      ),
    );
  }
}

class _fondoImagen extends StatelessWidget {
  const _fondoImagen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(color: Colors.black, blurRadius: 5)]),
      width: 351,
      height: 201,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: FadeInImage(
          placeholder: AssetImage('assets/no-image.jpg'),
          image: AssetImage('assets/cartel.jpg'),
          width: 350,
          height: 200,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _ColorBox extends StatelessWidget {
  const _ColorBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(top: 10),
      height: size.height * 0.8,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned(top: 100, child: Container()),
          Container(
            width: 300,
            margin: const EdgeInsets.only(top: 10, left: 10),
          ),
        ],
      ),
    );
  }
}
