import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:zaragoza_app/api/speech_api.dart';
import 'package:zaragoza_app/providers/add_form_provider.dart';
import 'package:zaragoza_app/screens/screens.dart';
import 'package:zaragoza_app/utils.dart';

import '../models/models.dart';
import '../services/services.dart';

final _counter = 0;
final tallas = {'XL', 'L', 'M', 'S', 'XS'};
late String talla = '';
final ttsProduct = FlutterTts();

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
  final articuloService = ArticuloService();

  Articulo articulo = Articulo();
  Future refresh() async {
    await articuloService.getArticulo();

    setState(() {
      articulo = articuloService.selectedArticulo;

      ttsProduct.speak(articulo.modelo! +
          '. color:' +
          articulo.color! +
          ', marca:' +
          articulo.marca! +
          ', talla:' +
          articulo.talla! +
          ', precio:' +
          articulo.precio.toString() +
          '. ');
    });
  }

  String text = 'Press the button and start speaking';

  bool isListening = false;

  Future _toggleRecordingProduct() async {
    SpeechApi.toggleRecording(onResult: (text) {
      setState(() => this.text = text);
      print('ENTRA 2');
    }, onListening: (isListening) {
      setState(() => this.isListening = isListening = isListening);
      print('ENTRA');
    });
  }

  Future command() async {
    if (!isListening) {
      Future.delayed(const Duration(seconds: 1), () async {
        print(text);
        if (text == 'añadir al carrito') {
          final compraService =
              Provider.of<CompraServices>(context, listen: false);
          final userService =
              Provider.of<LoginServices>(context, listen: false);
          int userId = int.parse(await userService.readId());

          print(userId);

          String? msg = await compraService.addCompra(
              userId, articulo.modelo!, 1, articulo.talla!);
          CoolAlert.show(
            context: context,
            type: CoolAlertType.warning,
            title: msg,
            autoCloseDuration: const Duration(seconds: 2),
            borderRadius: 30,
            //loopAnimation: true,
            confirmBtnColor: Colors.blueAccent,

            onConfirmBtnTap: () {
              Navigator.pop(context);
            },
            showCancelBtn: true,
            onCancelBtnTap: () {
              Navigator.pop(context);
            },
          );

          ttsProduct.speak('Añadido al carrito correctamente');
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return articuloService.isLoading
        ? const Center(
            child: SpinKitWave(color: Color.fromRGBO(0, 153, 153, 1), size: 50))
        : Scaffold(
            appBar: _appbar(context),
            body: GestureDetector(
              onLongPress: _toggleRecordingProduct,
              onLongPressEnd: (details) {
                if (text == 'añadir al carrito') {
                  command();
                } else if (text.contains('ir a') || text.contains('buscar')) {
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
                        SizedBox(
                          height: 10,
                        ),
                        _fondoImagen(
                          foto: articulo.foto,
                        ),
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 30, left: 20, bottom: 10),
                              child: Text(
                                articulo.modelo!,
                                style: const TextStyle(fontSize: 18),
                                overflow: TextOverflow.clip,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.only(left: 20, bottom: 10),
                              child: Text('${articulo.precio}€',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.only(left: 20, bottom: 20),
                              child: const Text('Talla',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Spacer(),
                            Container(
                                margin: const EdgeInsets.only(
                                    bottom: 20, right: 20),
                                child: LikeButton(
                                  size: 25,
                                ))
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
                                      duration:
                                          const Duration(milliseconds: 1000),
                                      onPressed: () {},
                                      child: GestureDetector(
                                        child: AnimatedContainer(
                                          margin: const EdgeInsets.only(
                                              right: 20, bottom: 20),
                                          height: 50,
                                          width: 50,
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: (articulo.talla != 'XL')
                                                  ? Colors.transparent
                                                  : Colors.greenAccent[200],
                                              border: Border.all(
                                                  color: Colors.black)),
                                          duration:
                                              const Duration(milliseconds: 200),
                                          child: Text(tallas.elementAt(0),
                                              style: const TextStyle(
                                                  color: Colors.black)),
                                        ),
                                        onTap: () {
                                          setState(() {
                                            talla = tallas.elementAt(0);
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
                                      duration:
                                          const Duration(milliseconds: 1000),
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
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: (articulo.talla != 'L')
                                                  ? Colors.transparent
                                                  : Colors.greenAccent[200],
                                              border: Border.all(
                                                  color: Colors.black)),
                                          duration:
                                              const Duration(milliseconds: 200),
                                          child: Text(tallas.elementAt(1),
                                              style: const TextStyle(
                                                  color: Colors.black)),
                                        ),
                                        onTap: () {
                                          setState(() {
                                            talla = tallas.elementAt(1);
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
                                      duration:
                                          const Duration(milliseconds: 1000),
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
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: (articulo.talla != 'M')
                                                  ? Colors.transparent
                                                  : Colors.greenAccent[200],
                                              border: Border.all(
                                                  color: Colors.black)),
                                          duration:
                                              const Duration(milliseconds: 200),
                                          child: Text(tallas.elementAt(2),
                                              style: const TextStyle(
                                                  color: Colors.black)),
                                        ),
                                        onTap: () {
                                          setState(() {
                                            talla = tallas.elementAt(2);
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
                                      duration:
                                          const Duration(milliseconds: 1000),
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
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: (articulo.talla != 'S')
                                                  ? Colors.transparent
                                                  : Colors.greenAccent[200],
                                              border: Border.all(
                                                  color: Colors.black)),
                                          duration:
                                              const Duration(milliseconds: 200),
                                          child: Text(tallas.elementAt(3),
                                              style: const TextStyle(
                                                  color: Colors.black)),
                                        ),
                                        onTap: () {
                                          setState(() {
                                            talla = tallas.elementAt(3);
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
                                      duration:
                                          const Duration(milliseconds: 1000),
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
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: (articulo != 'XS')
                                                  ? Colors.transparent
                                                  : Colors.greenAccent[200],
                                              border: Border.all(
                                                  color: Colors.black)),
                                          duration:
                                              const Duration(milliseconds: 200),
                                          child: Text(tallas.elementAt(4),
                                              style: const TextStyle(
                                                  color: Colors.black)),
                                        ),
                                        onTap: () {
                                          setState(() {
                                            talla = tallas.elementAt(4);
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
                          onPressed: () async {
                            final compraService = Provider.of<CompraServices>(
                                context,
                                listen: false);
                            final userService = Provider.of<LoginServices>(
                                context,
                                listen: false);
                            int userId = int.parse(await userService.readId());

                            print(userId);

                            String? msg = await compraService.addCompra(
                                userId, articulo.modelo!, 1, articulo.talla!);
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
                              showCancelBtn: true,
                              onCancelBtnTap: () {
                                Navigator.pop(context);
                              },
                            );
                          },
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
                          child: const Text('Añadir al carrito',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black)),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
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
            Navigator.pushReplacementNamed(context, 'userscreen');
          },
          icon: const Icon(Icons.logout),
        ),
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
  String? foto;
  _fondoImagen({super.key, this.foto});

  @override
  Widget build(BuildContext context) {
    return foto == null
        ? const ClipRRect(
            child: FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'),
              image: AssetImage('assets/no-image.jpg'),
              width: 300,
              height: 200,
              fit: BoxFit.scaleDown,
            ),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: const AssetImage('assets/no-image.jpg'),
              image: NetworkImage(
                  'http://dressup.allsites.es/public/imagenes/' + foto!),
              width: 200,
              height: 300,
              fit: BoxFit.fill,
            ),
          );
  }
}
