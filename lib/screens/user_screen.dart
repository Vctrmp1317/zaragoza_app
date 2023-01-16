import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:zaragoza_app/providers/add_form_provider.dart';

final tts2 = FlutterTts();

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    tts2.awaitSpeakCompletion(true);
    tts2.speak('Bienvenido estas en la pantalla de inicio');
    return Scaffold(
        appBar: _appbar(context),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _dividerLine(),
              Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const _searchBar(),
                  const SizedBox(height: 5),
                  const _fondoImagen(),
                  const ProductsCategoriesUser(),
                ],
              )
            ],
          ),
        ));
  }

  AppBar _appbar(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            const Text('Inicio',
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            const Spacer(),
            IconButton(
              color: Colors.black,
              icon: const Icon(Icons.manage_accounts),
              onPressed: () {},
            ),
            const SizedBox(width: 8),
            IconButton(
              color: Colors.black,
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, 'login', (route) => false);
              },
              icon: const Icon(Icons.logout),
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
          margin:
              const EdgeInsetsDirectional.only(start: 20, top: 5, bottom: 5),
          height: 30,
          width: 250,
          child: TextField(
            onChanged: ((value) => updateList(value)),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              focusColor: Colors.black87,
              border: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Colors.black)),
              hintText: "Buscar",
            ),
          ),
        ),
        const Spacer(),
        Container(
            margin: const EdgeInsets.only(right: 20),
            child: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)))
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
                          onTap: () => {print('categoria')},
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
                          onTap: () => {print('categoria')},
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
                          onTap: () => {print('categoria')},
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
            borderRadius: BorderRadius.circular(2),
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
                height: 150,
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
                  const Positioned(
                      top: 2,
                      left: 5,
                      child: Text('Niño',
                          style: TextStyle(
                              fontSize: 18, backgroundColor: Colors.white38))),
                ]),
              ),
            ]),
            const SizedBox(
              height: 5,
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              height: 0.5,
              color: Colors.black54,
            ),
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
            borderRadius: BorderRadius.circular(2),
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
                height: 150,
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
                  const Positioned(
                      top: 2,
                      left: 5,
                      child: Text('Destacado',
                          style: TextStyle(
                              fontSize: 18, backgroundColor: Colors.white38))),
                ]),
              ),
            ]),
            const SizedBox(
              height: 5,
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              height: 0.5,
              color: Colors.black54,
            ),
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
            borderRadius: BorderRadius.circular(2),
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
                height: 150,
                // ignore: prefer_const_literals_to_create_immutables
                child: Stack(children: [
                  const ClipRRect(
                    child: FadeInImage(
                      placeholder: AssetImage('assets/no-image.jpg'),
                      image: AssetImage('assets/ropaMujer.jpg'),
                      width: 300,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Positioned(
                      top: 2,
                      left: 5,
                      child: Text('Mujer',
                          style: TextStyle(
                              fontSize: 18, backgroundColor: Colors.white38))),
                ]),
              ),
            ]),
            const SizedBox(
              height: 5,
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              height: 0.5,
              color: Colors.black54,
            ),
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
            borderRadius: BorderRadius.circular(2),
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
                height: 150,
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
                  const Positioned(
                      top: 2,
                      left: 5,
                      child: Text('Hombre',
                          style: TextStyle(
                              fontSize: 18, backgroundColor: Colors.white38))),
                ]),
              ),
            ]),
            const SizedBox(
              height: 5,
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              height: 0.5,
              color: Colors.black54,
            ),
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
    return const ClipRRect(
      child: FadeInImage(
        placeholder: AssetImage('assets/no-image.jpg'),
        image: AssetImage('assets/image.jpg'),
        width: 350,
        height: 200,
        fit: BoxFit.cover,
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
