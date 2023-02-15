import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:zaragoza_app/providers/add_form_provider.dart';

import '../models/models.dart';
import '../services/services.dart';

var _counter = 0;
late int idArticulo = 0;

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final articulosService = Provider.of<ArticulosServices>(context);

    return articulosService.isLoading
        ? const Center(
            child: SpinKitWave(color: Color.fromRGBO(0, 153, 153, 1), size: 50))
        : Scaffold(
            appBar: _appbar(context),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _dividerLine(),
                  Column(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const SizedBox(height: 5),
                      // const ProductsSearchUser(),
                      const listProducts1()
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
        leading: IconButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, 'userscreen', (route) => false);
          },
          icon: const Icon(Icons.logout),
        ),
        title: const Text(
          'Página de búsqueda',
          style: TextStyle(fontSize: 24, color: Colors.black),
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
  void updateList(String value) {}

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

class listProducts1 extends StatefulWidget {
  const listProducts1({super.key});

  @override
  State<listProducts1> createState() => _listProductsState();
}

class _listProductsState extends State<listProducts1> {
  List<Articulos> articulos = [];
  final articulosService = ArticulosServices();

  void updateList(String value) {
    setState(() {
      articulos = articulosService.articulos
          .where((element) =>
              element.tipo!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  Future refresh() async {
    setState(() => articulos.clear());

    await articulosService.getArticulos();

    setState(() {
      articulos = articulosService.articulos;
    });
  }

  @override
  void initState() {
    super.initState();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              margin: const EdgeInsetsDirectional.only(
                top: 20,
              ),
              height: 30,
              width: 200,
              child: TextField(
                textInputAction: TextInputAction.search,
                onChanged: ((value) => updateList(value)),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  focusColor: Colors.black87,
                  border: InputBorder.none,
                  hintText: "Buscar",
                ),
              ),
            ),
            const Spacer(),
            Container(
              margin: const EdgeInsets.only(top: 20),
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 600,
            width: 400,
            child: GridView.builder(
              itemBuilder: ((context, index) {
                TextEditingController customController =
                    TextEditingController();

                return GestureDetector(
                  onTap: () {
                    final articuloService =
                        Provider.of<ArticuloService>(context, listen: false);
                    setState(() {
                      idArticulo = articulos[index].id!;
                      articuloService.addVistaArticulo(idArticulo);

                      articulosService.loadArticulo(idArticulo);
                    });
                    Navigator.pushReplacementNamed(context, 'productscreen');
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      width: 10,
                      height: 330,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black54),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
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
                              height: 200,
                              child: const ClipRRect(
                                child: FadeInImage(
                                  placeholder:
                                      AssetImage('assets/no-image.jpg'),
                                  image: AssetImage('assets/no-image.jpg'),
                                  width: 300,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ]),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Text(articulos[index].modelo!,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                          Row(
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Text(articulos[index].precio.toString() + '€',
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                              const Spacer(),
                              Text(articulos[index].marca!,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            height: 0.5,
                            color: Colors.black54,
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  final compraService =
                                      Provider.of<CompraServices>(context,
                                          listen: false);
                                  final userService =
                                      Provider.of<LoginServices>(context,
                                          listen: false);
                                  int userId =
                                      int.parse(await userService.readId());

                                  String? msg = await compraService.addCompra(
                                      userId, articulos[index].id!, 1);
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
                                child: const Text(
                                  'Compra \n Rapida',
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                              const Spacer(),
                              IconButton(
                                  onPressed: () async {
                                    final compraService =
                                        Provider.of<CompraServices>(context,
                                            listen: false);
                                    final userService =
                                        Provider.of<LoginServices>(context,
                                            listen: false);
                                    int userId =
                                        int.parse(await userService.readId());

                                    String? msg = await compraService.addCompra(
                                        userId, articulos[index].id!, 1);
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
                                  icon: const Icon(Icons.add_shopping_cart))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
              itemCount: articulos.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisExtent: 350, mainAxisSpacing: 30),
            ),
          ),
        ),
      ],
    );
  }
}

class CardSearch extends StatelessWidget {
  const CardSearch({
    super.key,
  });

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
                height: 145,
                // ignore: prefer_const_literals_to_create_immutables
                child: Stack(children: [
                  const ClipRRect(
                    child: FadeInImage(
                      placeholder: AssetImage('assets/no-image.jpg'),
                      image: AssetImage('assets/no-image.jpg'),
                      width: 300,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ]),
              ),
            ]),
            Container(
              margin: const EdgeInsets.only(top: 10),
              height: 50,
              width: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Text(
                    'Descripcion',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    '45€',
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5),
              height: 1,
              color: Colors.black45,
              width: 200,
            ),
            Container(
              margin: const EdgeInsets.only(top: 5),
              height: 50,
              width: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pushReplacementNamed(
                            context, 'userscreen'),
                        child: const Text(
                          'Compra \n Rapida',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            _counter = _counter++;
                          },
                          icon: const Icon(Icons.add_shopping_cart))
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
