import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:provider/provider.dart';
import 'package:zaragoza_app/api/speech_api.dart';
import 'package:zaragoza_app/providers/add_form_provider.dart';
import 'package:zaragoza_app/providers/comment_form_provider.dart';

import '../models/models.dart';
import '../services/services.dart';
import '../utils.dart';

const storage = FlutterSecureStorage();

class BuyScreen extends StatefulWidget {
  const BuyScreen({Key? key}) : super(key: key);

  @override
  State<BuyScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<BuyScreen> {
  final double total = 0;
  bool pantalonSelected = false;
  bool gorroSelected = false;
  bool camisetaSelected = false;
  bool zapatosSelected = false;
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
    });
  }

  @override
  void initState() {
    super.initState();
    refresh();
  }

  String text = 'Press the button and start speaking';

  bool isListening = false;

  Future toggleRecording() => SpeechApi.toggleRecording(
      onResult: (text) => setState(() => this.text = text),
      onListening: (isListening) {
        setState(() => this.isListening = isListening = isListening);
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appbar(context),
        body: GestureDetector(
          onLongPress: toggleRecording,
          onLongPressEnd: (details) {
            isListening = false;
            if (text.contains('ir a') || text.contains('buscar')) {
              print(text);
              Utils.scanText(text, context);
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
                        margin: const EdgeInsets.only(left: 10),
                        height: 140,
                        width: 400,
                        child: Stack(children: [
                          gorros.isEmpty
                              ? Container(
                                  child: const Center(
                                    child: Text(
                                      'NO HAY GORROS EN TU INVENTARIO',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: ((context, index) {
                                    TextEditingController customController =
                                        TextEditingController();

                                    createAlertDialog(
                                        context, customController) {
                                      return showDialog(
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                                title: const Text(
                                                    'Editar prenda',
                                                    style: TextStyle(
                                                        fontSize: 22,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                content:
                                                    const SingleChildScrollView(
                                                        child: _ColorBox()),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)));
                                          },
                                          context: context);
                                    }

                                    return GestureDetector(
                                      onTap: (() {
                                        setState(() {
                                          idGorro = index;
                                          gorroSelected = true;
                                        });
                                      }),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          padding: const EdgeInsets.all(8.0),
                                          width: 330,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black54),
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
                                                      child:
                                                          articulos[index]
                                                                      .foto ==
                                                                  null
                                                              ? const ClipRRect(
                                                                  child:
                                                                      FadeInImage(
                                                                    placeholder:
                                                                        AssetImage(
                                                                            'assets/no-image.jpg'),
                                                                    image: AssetImage(
                                                                        'assets/no-image.jpg'),
                                                                    width: 300,
                                                                    height: 200,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                )
                                                              : ClipRRect(
                                                                  child:
                                                                      FadeInImage(
                                                                    placeholder:
                                                                        const AssetImage(
                                                                            'assets/no-image.jpg'),
                                                                    image: NetworkImage(
                                                                        'http://dressup.allsites.es/public/imagenes/' +
                                                                            articulos[index].foto!),
                                                                    width: 300,
                                                                    height: 200,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                    ),
                                                  ),
                                                  Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 5,
                                                              right: 5),
                                                      width: 1,
                                                      height: 100,
                                                      color: Colors.black),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 0),
                                                    height: 100,
                                                    width: 100,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      // ignore: prefer_const_literals_to_create_immutables
                                                      children: [
                                                        SizedBox(
                                                          height: 20,
                                                          child: Text(
                                                            gorros[index]
                                                                .modelo!,
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        18),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          gorros[index]
                                                                  .precio
                                                                  .toString() +
                                                              '€',
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 18),
                                                        ),
                                                        Text(
                                                          gorros[index].talla!,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 18),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  IconButton(
                                                      onPressed: () {
                                                        storage.write(
                                                            key: 'idArt',
                                                            value: gorros[index]
                                                                .id
                                                                .toString());

                                                        createAlertDialog(
                                                            context,
                                                            customController);
                                                      },
                                                      icon: Icon(Icons
                                                          .post_add_outlined))
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                  itemCount: gorros.length,
                                ),
                        ])),
                    Container(
                        margin: const EdgeInsets.only(left: 10),
                        height: 140,
                        width: 400,
                        child: Stack(children: [
                          camisetas.isEmpty
                              ? Container(
                                  child: const Center(
                                    child: Text(
                                      'NO HAY CAMISETAS EN TU INVENTARIO',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: ((context, index) {
                                    TextEditingController customController =
                                        TextEditingController();

                                    return GestureDetector(
                                      onTap: (() {
                                        setState(() {
                                          idCamiseta = index;
                                          camisetaSelected = true;
                                        });
                                      }),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          padding: const EdgeInsets.all(8.0),
                                          width: 330,
                                          height: 150,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black54),
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
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 5,
                                                              right: 5),
                                                      width: 1,
                                                      height: 100,
                                                      color: Colors.black),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 0),
                                                    height: 100,
                                                    width: 100,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      // ignore: prefer_const_literals_to_create_immutables
                                                      children: [
                                                        SizedBox(
                                                          height: 20,
                                                          child: Text(
                                                            camisetas[index]
                                                                .modelo!,
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        18),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          camisetas[index]
                                                                  .precio
                                                                  .toString() +
                                                              '€',
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 18),
                                                        ),
                                                        Text(
                                                          camisetas[index]
                                                              .talla!,
                                                          style:
                                                              const TextStyle(
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
                                    );
                                  }),
                                  itemCount: camisetas.length,
                                ),
                        ])),
                    Container(
                        margin: const EdgeInsets.only(left: 10),
                        height: 140,
                        width: 400,
                        child: Stack(children: [
                          pantalones.isEmpty
                              ? Container(
                                  child: const Center(
                                    child: Text(
                                      'NO HAY PANTALONES EN TU INVENTARIO',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: ((context, index) {
                                    TextEditingController customController =
                                        TextEditingController();

                                    return GestureDetector(
                                      onTap: (() {
                                        setState(() {
                                          idPantalon = index;
                                          pantalonSelected = true;
                                        });
                                      }),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          padding: const EdgeInsets.all(8.0),
                                          width: 330,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black54),
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
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 5,
                                                              right: 5),
                                                      width: 1,
                                                      height: 100,
                                                      color: Colors.black),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 0),
                                                    height: 100,
                                                    width: 100,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      // ignore: prefer_const_literals_to_create_immutables
                                                      children: [
                                                        SizedBox(
                                                          height: 20,
                                                          child: Text(
                                                            pantalones[index]
                                                                .modelo!,
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        18),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          pantalones[index]
                                                                  .precio
                                                                  .toString() +
                                                              '€',
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 18),
                                                        ),
                                                        Text(
                                                          pantalones[index]
                                                              .talla!,
                                                          style:
                                                              const TextStyle(
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
                                    );
                                  }),
                                  itemCount: pantalones.length,
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
                              : ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: ((context, index) {
                                    TextEditingController customController =
                                        TextEditingController();

                                    return GestureDetector(
                                      onTap: (() {
                                        setState(() {
                                          idZapatos = index;
                                          zapatosSelected = true;
                                        });
                                      }),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          padding: const EdgeInsets.all(8.0),
                                          width: 330,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black54),
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
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 5,
                                                              right: 5),
                                                      width: 1,
                                                      height: 100,
                                                      color: Colors.black),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 0),
                                                    height: 100,
                                                    width: 100,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      // ignore: prefer_const_literals_to_create_immutables
                                                      children: [
                                                        SizedBox(
                                                          height: 20,
                                                          child: Text(
                                                            pantalones[index]
                                                                .modelo!,
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        18),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          zapatos[index]
                                                                  .precio
                                                                  .toString() +
                                                              '€',
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 18),
                                                        ),
                                                        Text(
                                                          zapatos[index].talla!,
                                                          style:
                                                              const TextStyle(
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
                                    );
                                  }),
                                  itemCount: zapatos.length,
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
          const Text('Inventario',
              style: TextStyle(color: Colors.white, fontSize: 25)),
          const Spacer(),
          IconButton(
              color: Colors.white,
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'outfitscreen');
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
            child: ChangeNotifierProvider(
              create: (_) => AddFormProvider(),
              child: _AddForm(),
            ),
          ),
        ],
      ),
    );
  }
}

class _AddForm extends StatefulWidget {
  @override
  State<_AddForm> createState() => _AddFormState();
}

class _AddFormState extends State<_AddForm> {
  late String imagenPath = '';
  double value = 3.5;
  List<Articulos> articulo = [];

  @override
  void initState() {
    super.initState();
    final articulosService =
        Provider.of<ArticulosServices>(context, listen: false);
    articulo = articulosService.articulos;
  }

  @override
  Widget build(BuildContext context) {
    final addForm = Provider.of<CommentFormProvider>(context);

    final size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      height: 610,
      child: Form(
          key: addForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                autocorrect: false,
                decoration: const InputDecoration(
                    focusColor: Colors.black,
                    hintText: 'Escriba un comentario',
                    labelText: 'Comentario',
                    border: UnderlineInputBorder(),
                    suffixIcon: Icon(Icons.color_lens)),
                onChanged: (value) => addForm.comment = value,
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
              const SizedBox(height: 5),
              RatingStars(
                value: value,
                onValueChanged: (v) {
                  //
                  setState(() {
                    value = v;
                  });
                },
                starBuilder: (index, color) => Icon(
                  Icons.ac_unit_outlined,
                  color: color,
                ),
                starCount: 5,
                starSize: 20,
                valueLabelColor: const Color(0xff9b9b9b),
                valueLabelTextStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 12.0),
                valueLabelRadius: 10,
                maxValue: 5,
                starSpacing: 2,
                maxValueVisibility: true,
                valueLabelVisibility: true,
                animationDuration: Duration(milliseconds: 1000),
                valueLabelPadding:
                    const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                valueLabelMargin: const EdgeInsets.only(right: 8),
                starOffColor: const Color(0xffe7e8ea),
                starColor: Colors.yellow,
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: 300,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    )),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.blueAccent[100]),
                    fixedSize: MaterialStateProperty.all(
                        const Size(double.infinity, 30)),
                  ),
                  onPressed: () async {
                    FocusScope.of(context).requestFocus(FocusNode());
                    if (addForm.isValidForm()) {
                      //Navigator.pushNamed(context, 'edit');
                      final addArticuloService =
                          Provider.of<ArticuloService>(context, listen: false);

                      // addArticuloService.updateArticulo(
                      //     addForm.modelo,
                      //     int.parse(addForm.stock),
                      //     int.parse(addForm.precio),
                      //     articulo[ind].tipo!,
                      //     articulo[ind].marca!,
                      //     articulo[ind].talla!,
                      //     id);

                      final articulosService = ArticuloService();

                      articulosService.addComment(
                          addForm.comment, int.parse(addForm.mark));
                      Navigator.pushReplacementNamed(context, 'buyscreen');
                    }
                  },
                  // ignore: prefer_const_literals_to_create_immutables
                  child: Row(children: [
                    const Text(
                      'Guardar',
                      style: TextStyle(fontSize: 15),
                    ),
                    const Spacer(),
                    const Icon(Icons.save)
                  ]),
                ),
              ),
            ],
          )),
    );
  }
}
