import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:zaragoza_app/providers/add_form_provider.dart';
import 'package:zaragoza_app/screens/screens.dart';

final ttsProduct = FlutterTts();
final _counter = 0;
final tallas = {'XL', 'L', 'M', 'S', 'XS'};

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  bool xl = true;
  bool l = true;
  bool m = true;
  bool s = true;
  bool xs = true;
  @override
  Widget build(BuildContext context) {
    ttsProduct.awaitSpeakCompletion(true);
    ttsProduct.speak('Bienvenido a la pantalla del producto');

    return Scaffold(
        appBar: _appbar(context),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const _fondoImagen(),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                            top: 30, left: 20, bottom: 10),
                        child: const Text('Nombre del producto',
                            style: TextStyle(fontSize: 16)),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 20, bottom: 10),
                        child: const Text('52,00€',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.all(20),
                    child: const Text('ENVIO TOTALMENTE GRATUITO',
                        style: TextStyle(fontSize: 18)),
                  ),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 20, bottom: 20),
                        child: const Text('Seleccione una talla',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  Container(
                      margin: const EdgeInsets.only(left: 50),
                      width: double.infinity,
                      height: 150,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Bounce(
                                duration: Duration(milliseconds: 1000),
                                onPressed: () {},
                                child: GestureDetector(
                                  child: AnimatedContainer(
                                    margin: const EdgeInsets.only(
                                        right: 20, bottom: 20),
                                    height: 50,
                                    width: 50,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: (xl == true)
                                            ? Colors.transparent
                                            : Colors.greenAccent[100],
                                        border:
                                            Border.all(color: Colors.black)),
                                    duration: const Duration(milliseconds: 200),
                                    child: Text(tallas.elementAt(0),
                                        style: const TextStyle(
                                            color: Colors.black)),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      xl = false;
                                      l = true;
                                      m = true;
                                      s = true;
                                      xs = true;
                                    });
                                  },
                                ),
                              ),
                              Bounce(
                                duration: Duration(milliseconds: 1000),
                                onPressed: () {},
                                child: GestureDetector(
                                  child: AnimatedContainer(
                                    margin: const EdgeInsets.only(
                                      right: 20,
                                      bottom: 20,
                                    ),
                                    height: 50,
                                    width: 50,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: (l == true)
                                            ? Colors.transparent
                                            : Colors.greenAccent[100],
                                        border:
                                            Border.all(color: Colors.black)),
                                    duration: const Duration(milliseconds: 200),
                                    child: Text(tallas.elementAt(1),
                                        style: const TextStyle(
                                            color: Colors.black)),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      xl = true;
                                      l = false;
                                      m = true;
                                      s = true;
                                      xs = true;
                                    });
                                  },
                                ),
                              ),
                              Bounce(
                                onPressed: () {},
                                duration: Duration(milliseconds: 1000),
                                child: GestureDetector(
                                  child: AnimatedContainer(
                                    margin: const EdgeInsets.only(
                                      right: 20,
                                      bottom: 20,
                                    ),
                                    height: 50,
                                    width: 50,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: (m == true)
                                            ? Colors.transparent
                                            : Colors.greenAccent[100],
                                        border:
                                            Border.all(color: Colors.black)),
                                    duration: const Duration(milliseconds: 200),
                                    child: Text(tallas.elementAt(2),
                                        style: const TextStyle(
                                            color: Colors.black)),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      xl = true;
                                      l = true;
                                      m = false;
                                      s = true;
                                      xs = true;
                                    });
                                  },
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Bounce(
                                duration: Duration(milliseconds: 1000),
                                onPressed: () {},
                                child: GestureDetector(
                                  child: AnimatedContainer(
                                    margin: const EdgeInsets.only(
                                      right: 20,
                                      bottom: 20,
                                    ),
                                    height: 50,
                                    width: 50,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: (s == true)
                                            ? Colors.transparent
                                            : Colors.greenAccent[100],
                                        border:
                                            Border.all(color: Colors.black)),
                                    duration: const Duration(milliseconds: 200),
                                    child: Text(tallas.elementAt(3),
                                        style: const TextStyle(
                                            color: Colors.black)),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      xl = true;
                                      l = true;
                                      m = true;
                                      s = false;
                                      xs = true;
                                    });
                                  },
                                ),
                              ),
                              Bounce(
                                duration: Duration(milliseconds: 1000),
                                onPressed: () {},
                                child: GestureDetector(
                                  child: AnimatedContainer(
                                    margin: const EdgeInsets.only(
                                      right: 20,
                                      bottom: 20,
                                    ),
                                    height: 50,
                                    width: 50,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: (xs == true)
                                            ? Colors.transparent
                                            : Colors.greenAccent[100],
                                        border:
                                            Border.all(color: Colors.black)),
                                    duration: const Duration(milliseconds: 200),
                                    child: Text(tallas.elementAt(4),
                                        style: const TextStyle(
                                            color: Colors.black)),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      xl = true;
                                      l = true;
                                      m = true;
                                      s = true;
                                      xs = false;
                                    });
                                  },
                                ),
                              )
                            ],
                          )
                        ],
                      )),
                  ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                        shadowColor: MaterialStateProperty.all(Colors.black),
                        side: MaterialStateProperty.all(
                            const BorderSide(color: Colors.black)),
                        elevation: MaterialStateProperty.all(10),
                        fixedSize:
                            MaterialStateProperty.all(const Size(300, 50)),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white)),
                    child: const Text('Añadir al carrito',
                        style: TextStyle(fontSize: 18, color: Colors.black)),
                  ),
                  const SizedBox(
                    height: 30,
                  )
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
            const _searchBar(),
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
            const SizedBox(width: 8),
            IconButton(
              color: Colors.white,
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'userscreen');
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
        IconButton(
          icon: const Icon(Icons.search, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacementNamed(context, 'searchscreen');
          },
        ),
      ],
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
        image: AssetImage('assets/no-image.jpg'),
        width: double.infinity,
        height: 260,
        fit: BoxFit.cover,
      ),
    );
  }
}
