import 'dart:io';
import 'dart:math';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:zaragoza_app/providers/add_form_provider.dart';
import 'package:zaragoza_app/screens/screens.dart';
import 'package:zaragoza_app/services/carrito_service.dart';
import 'package:zaragoza_app/utils.dart';

import '../api/speech_api.dart';
import '../models/models.dart';
import '../services/services.dart';

final ttsOutfit = FlutterTts();

class OutfitScreen extends StatefulWidget {
  const OutfitScreen({Key? key}) : super(key: key);

  @override
  State<OutfitScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<OutfitScreen> {
  final double total = 0;
  bool pantalonSelected = true;
  bool gorroSelected = true;
  bool camisetaSelected = true;
  bool zapatosSelected = true;
  int idGorro = 0;
  int idCamiseta = 0;
  int idPantalon = 0;
  int idZapatos = 0;

  List<Articulos> articulos = [];
  List<Articulos> gorros = [];
  List<Articulos> camisetas = [];
  List<Articulos> pantalones = [];
  List<Articulos> zapatos = [];
  final compradosService = ArticulosCompradosServices();

  Future refresh() async {
    setState(() => articulos.clear());
    setState(() => gorros.clear());
    setState(() => camisetas.clear());
    setState(() => pantalones.clear());
    setState(() => zapatos.clear());
    await compradosService.getArticulos();
    setState(() {
      var rng = Random();
      articulos = compradosService.articulos;
      gorros = compradosService.articulos
          .where((element) => element.tipo!.toLowerCase().contains('gorro'))
          .toList();
      camisetas = compradosService.articulos
          .where((element) => element.tipo!.toLowerCase().contains('camiseta'))
          .toList();
      pantalones = compradosService.articulos
          .where((element) => element.tipo!.toLowerCase().contains('pantalon'))
          .toList();
      zapatos = compradosService.articulos
          .where((element) => element.tipo!.toLowerCase().contains('zapatos'))
          .toList();
      if (gorros.isNotEmpty) idGorro = rng.nextInt(gorros.length);
      if (camisetas.isNotEmpty) idCamiseta = rng.nextInt(camisetas.length);
      if (pantalones.isNotEmpty) idPantalon = rng.nextInt(pantalones.length);
      if (zapatos.isNotEmpty) idZapatos = rng.nextInt(zapatos.length);
      ttsOutfit.awaitSpeakCompletion(true);
      String textGorro = 'No hay gorros en tu inventario.';
      String textCamiseta = 'No hay camisetas en tu inventario';
      String textPantalones = 'No hay pantalla en tu inventario';
      String textZapatos = 'No hay zapatos en tu inventario';
      if (gorros.isNotEmpty)
        textGorro = gorros[idGorro].modelo!.toString() +
            '. color: ' +
            gorros[idGorro].color!.toString() +
            ', marca:' +
            gorros[idGorro].marca!.toString() +
            '. ';
      if (camisetas.isNotEmpty)
        textCamiseta = camisetas[idCamiseta].modelo!.toString() +
            '. color: negro' +
            'marca:' +
            camisetas[idCamiseta].marca!.toString() +
            '. ';
      // textCamiseta = camisetas[idCamiseta].modelo!.toString() +
      //     '. color: ' +
      //     camisetas[idCamiseta].color!.toString() +
      //     ', marca:' +
      //     camisetas[idCamiseta].marca!.toString() +
      //  '. ';

      if (pantalones.isNotEmpty)
        textPantalones = pantalones[idPantalon].modelo!.toString() +
            '. color: azul ' +
            ', marca:' +
            pantalones[idPantalon].marca!.toString() +
            '. ';
//pantalones[idPantalon].color!.toString() +
      if (zapatos.isNotEmpty)
        textZapatos = zapatos[idZapatos].modelo!.toString() +
            '. color: ' +
            zapatos[idZapatos].color!.toString() +
            ', marca:' +
            zapatos[idZapatos].marca!.toString() +
            '. ';

      ttsOutfit.speak('Gorro: ' +
          textGorro +
          ' Camiseta: ' +
          textCamiseta +
          ' Pantalones: ' +
          textPantalones +
          ' Zapatos: ' +
          textZapatos);
    });
  }

  String text = 'Press the button and start speaking';

  bool isListening = false;

  Future toggleRecording() => SpeechApi.toggleRecording(
      onResult: (text) => setState(() => this.text = text),
      onListening: (isListening) {
        setState(() => this.isListening = isListening = isListening);
      });

  @override
  void initState() {
    super.initState();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appbar(context),
        body: GestureDetector(
          onLongPressEnd: (details) {
            if (text == 'generar' || text == 'general') {
              Navigator.pushReplacementNamed(context, 'outfitscreen');
            }
            if (text.contains('ir a') || text.contains('buscar')) {
              print(text);
              Utils.scanText(text, context);
            }
          },
          onLongPress: toggleRecording,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const SizedBox(height: 5),
                    Container(
                        margin: const EdgeInsets.only(left: 10),
                        height: 140,
                        width: 400,
                        child: Stack(children: [
                          gorros.isEmpty
                              ? Container(
                                  child: Center(
                                    child: const Text(
                                      'NO HAY GORROS EN TU INVENTARIO',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                )
                              : Visibility(
                                  visible: gorroSelected,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      padding: const EdgeInsets.all(8.0),
                                      width: 330,
                                      height: 150,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black54),
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(2),
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
                                          Row(
                                            children: [
                                              Positioned(
                                                left: 2,
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.yellow,
                                                  ),
                                                  width: 100,
                                                  height: 100,
                                                  // ignore: prefer_const_literals_to_create_immutables
                                                  child: const ClipRRect(
                                                    child: FadeInImage(
                                                      placeholder: AssetImage(
                                                          'assets/no-image.jpg'),
                                                      image: AssetImage(
                                                          'assets/no-image.jpg'),
                                                      width: 100,
                                                      height: 100,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 5, right: 5),
                                                  width: 1,
                                                  height: 100,
                                                  color: Colors.black),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    top: 0),
                                                height: 100,
                                                width: 100,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  // ignore: prefer_const_literals_to_create_immutables
                                                  children: [
                                                    SizedBox(
                                                      height: 20,
                                                      child: Text(
                                                        gorros[idPantalon]
                                                            .modelo!,
                                                        style: const TextStyle(
                                                            fontSize: 18),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      gorros[idGorro]
                                                              .precio
                                                              .toString() +
                                                          '€',
                                                      style: const TextStyle(
                                                          fontSize: 18),
                                                    ),
                                                    Text(
                                                      gorros[idGorro].talla!,
                                                      style: const TextStyle(
                                                          fontSize: 18),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                        ])),
                    Container(
                        margin: const EdgeInsets.only(left: 10),
                        height: 140,
                        width: 400,
                        child: Stack(children: [
                          camisetas.isEmpty
                              ? Container(
                                  child: Center(
                                    child: const Text(
                                      'NO HAY CAMISETAS EN TU INVENTARIO',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                )
                              : Visibility(
                                  visible: camisetaSelected,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      padding: const EdgeInsets.all(8.0),
                                      width: 330,
                                      height: 150,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black54),
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(2),
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
                                          Row(
                                            children: [
                                              Positioned(
                                                left: 2,
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.yellow,
                                                  ),
                                                  width: 100,
                                                  height: 100,
                                                  // ignore: prefer_const_literals_to_create_immutables
                                                  child: const ClipRRect(
                                                    child: FadeInImage(
                                                      placeholder: AssetImage(
                                                          'assets/no-image.jpg'),
                                                      image: AssetImage(
                                                          'assets/camiseta.jpg'),
                                                      width: 100,
                                                      height: 100,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 5, right: 5),
                                                  width: 1,
                                                  height: 100,
                                                  color: Colors.black),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    top: 0),
                                                height: 100,
                                                width: 100,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  // ignore: prefer_const_literals_to_create_immutables
                                                  children: [
                                                    SizedBox(
                                                      height: 20,
                                                      child: Text(
                                                        camisetas[idCamiseta]
                                                            .modelo!,
                                                        style: const TextStyle(
                                                            fontSize: 18),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      camisetas[idCamiseta]
                                                              .precio
                                                              .toString() +
                                                          '€',
                                                      style: const TextStyle(
                                                          fontSize: 18),
                                                    ),
                                                    Text(
                                                      camisetas[idCamiseta]
                                                          .talla!,
                                                      style: const TextStyle(
                                                          fontSize: 18),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                        ])),
                    Container(
                        margin: const EdgeInsets.only(left: 10),
                        height: 140,
                        width: 400,
                        child: Stack(children: [
                          pantalones.isEmpty
                              ? Container(
                                  child: Center(
                                    child: const Text(
                                      'NO HAY PANTALONES EN TU INVENTARIO',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                )
                              : Visibility(
                                  visible: pantalonSelected,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      padding: const EdgeInsets.all(8.0),
                                      width: 330,
                                      height: 150,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black54),
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(2),
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
                                          Row(
                                            children: [
                                              Positioned(
                                                left: 2,
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.yellow,
                                                  ),
                                                  width: 100,
                                                  height: 100,
                                                  // ignore: prefer_const_literals_to_create_immutables
                                                  child: const ClipRRect(
                                                    child: FadeInImage(
                                                      placeholder: AssetImage(
                                                          'assets/no-image.jpg'),
                                                      image: AssetImage(
                                                          'assets/pantalon.jpg'),
                                                      width: 100,
                                                      height: 100,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 5, right: 5),
                                                  width: 1,
                                                  height: 100,
                                                  color: Colors.black),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    top: 0),
                                                height: 100,
                                                width: 100,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  // ignore: prefer_const_literals_to_create_immutables
                                                  children: [
                                                    SizedBox(
                                                      height: 20,
                                                      child: Text(
                                                        pantalones[idPantalon]
                                                            .modelo!,
                                                        style: const TextStyle(
                                                            fontSize: 18),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      pantalones[idPantalon]
                                                              .precio
                                                              .toString() +
                                                          '€',
                                                      style: const TextStyle(
                                                          fontSize: 18),
                                                    ),
                                                    Text(
                                                      pantalones[idPantalon]
                                                          .talla!,
                                                      style: const TextStyle(
                                                          fontSize: 18),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                        ])),
                    const SizedBox(height: 5),
                    Container(
                        margin: const EdgeInsets.only(left: 10),
                        height: 140,
                        width: 400,
                        child: Stack(children: [
                          zapatos.isEmpty
                              ? Container(
                                  // ignore: prefer_const_constructors
                                  child: Center(
                                    child: const Text(
                                      'NO HAY ZAPATOS EN TU INVENTARIO',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                )
                              : Visibility(
                                  visible: zapatosSelected,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      padding: const EdgeInsets.all(8.0),
                                      width: 330,
                                      height: 150,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black54),
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(2),
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
                                          Row(
                                            children: [
                                              Positioned(
                                                left: 2,
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.yellow,
                                                  ),
                                                  width: 100,
                                                  height: 100,
                                                  // ignore: prefer_const_literals_to_create_immutables
                                                  child: const ClipRRect(
                                                    child: FadeInImage(
                                                      placeholder: AssetImage(
                                                          'assets/no-image.jpg'),
                                                      image: AssetImage(
                                                          'assets/no-image.jpg'),
                                                      width: 100,
                                                      height: 100,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 5, right: 5),
                                                  width: 1,
                                                  height: 100,
                                                  color: Colors.black),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    top: 0),
                                                height: 100,
                                                width: 100,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  // ignore: prefer_const_literals_to_create_immutables
                                                  children: [
                                                    SizedBox(
                                                      height: 20,
                                                      child: Text(
                                                        zapatos[idZapatos]
                                                            .modelo!,
                                                        style: const TextStyle(
                                                            fontSize: 18),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      zapatos[idZapatos]
                                                              .precio
                                                              .toString() +
                                                          '€',
                                                      style: const TextStyle(
                                                          fontSize: 18),
                                                    ),
                                                    Text(
                                                      zapatos[idZapatos].talla!,
                                                      style: const TextStyle(
                                                          fontSize: 18),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                        ])),
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
      leading: IconButton(
        color: Colors.white,
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(
              context, 'userscreen', (route) => false);
        },
        icon: const Icon(Icons.logout),
      ),
      elevation: 0,
      title: Row(
        children: [
          const Text('Generador',
              style: TextStyle(color: Colors.white, fontSize: 25)),
          const Spacer(),
          IconButton(
              color: Colors.white,
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, 'outfitscreen', (route) => false);
              },
              icon: const Icon(Icons.swap_horizontal_circle)),
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
    return Container(
      margin: const EdgeInsetsDirectional.only(
        top: 20,
      ),
      height: 30,
      width: 200,
      child: TextField(
        onSubmitted: (value) =>
            Navigator.pushReplacementNamed(context, 'userscreen'),
        textInputAction: TextInputAction.search,
        onChanged: ((value) => updateList(value)),
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.search),
          focusColor: Colors.black87,
          border: InputBorder.none,
          hintText: "Buscar",
        ),
      ),
    );
  }
}
