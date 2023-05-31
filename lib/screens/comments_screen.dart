import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:zaragoza_app/providers/add_form_provider.dart';
import 'package:zaragoza_app/providers/update_form_provider.dart';
import 'package:zaragoza_app/services/add_articulos_services.dart';

import '../models/models.dart';
import '../services/services.dart';

late int idc = 0;
late int indC = 0;

class CommentsScreen extends StatelessWidget {
  const CommentsScreen({Key? key}) : super(key: key);

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
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  const _listProducts()
                ],
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
            Navigator.pushReplacementNamed(context, 'adminscreen');
          },
          icon: const Icon(Icons.logout),
        ),
        title: Row(
          children: [
            const Text('Tienda',
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            const Spacer(),
            IconButton(
              color: Colors.white,
              icon: const Icon(Icons.manage_accounts),
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'adminusersscreen');
              },
            ),
            const SizedBox(width: 8),
          ],
        ));
  }
}

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

class _searchBar extends StatefulWidget {
  const _searchBar({super.key});

  @override
  State<_searchBar> createState() => __searchBarState();
}

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
              const EdgeInsetsDirectional.only(start: 20, top: 10, bottom: 10),
          height: 40,
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
            child: IconButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, 'addproduct');
                },
                icon: const Icon(Icons.checkroom)))
      ],
    );
  }
}

class _listProducts extends StatefulWidget {
  const _listProducts({super.key});

  @override
  State<_listProducts> createState() => _listProductsState();
}

class _listProductsState extends State<_listProducts> {
  List<Comments> comments = [];
  final articulosService = ArticuloService();

  Future refresh() async {
    setState(() => comments.clear());

    await articulosService.getComments();

    setState(() {
      comments = articulosService.comments;
    });
  }

  @override
  void initState() {
    super.initState();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return articulosService.isLoading
        ? const Center(
            child: SpinKitWave(color: Color.fromRGBO(0, 153, 153, 1), size: 50))
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 700,
              width: 400,
              child: ListView.builder(
                itemBuilder: ((context, index) {
                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 5, bottom: 5),
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              const BoxShadow(
                                  color: Colors.black, blurRadius: 5)
                            ]),
                        child: Column(children: [
                          Row(
                            children: [
                              Text(
                                'User: ${comments[index].username}',
                                style: const TextStyle(fontSize: 17),
                              ),
                              const Spacer(),
                              IconButton(
                                  onPressed: () {
                                    CoolAlert.show(
                                      context: context,
                                      type: CoolAlertType.warning,
                                      title:
                                          '¿Deseas eliminar esta valoración?',

                                      borderRadius: 30,
                                      //loopAnimation: true,
                                      confirmBtnColor: Colors.blueAccent,
                                      confirmBtnText: 'Aceptar',
                                      cancelBtnText: 'Cancelar',
                                      onConfirmBtnTap: () async {
                                        final String? msg =
                                            await ArticuloService()
                                                .deleteComments(
                                                    comments[index].id!);
                                        Fluttertoast.showToast(msg: msg!);
                                        Navigator.pushReplacementNamed(
                                            context, 'adminscreen');
                                      },
                                      showCancelBtn: true,
                                      onCancelBtnTap: () {
                                        Navigator.pop(context);
                                      },
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    size: 20,
                                  )),
                              IconButton(
                                  onPressed: () {
                                    const storage = FlutterSecureStorage();
                                    final ind = comments[index].id;
                                    storage.write(
                                        key: 'idComment', value: '$ind');
                                    Navigator.pushReplacementNamed(
                                        context, 'editComment');
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    size: 20,
                                  ))
                            ],
                          ),
                          Container(
                              padding: const EdgeInsets.all(20),
                              child: Text(
                                comments[index].comentario!,
                                style: const TextStyle(fontSize: 18),
                              )),
                          SizedBox(
                            height: 50,
                          ),
                          Row(
                            children: [
                              Positioned(
                                  bottom: 0,
                                  left: 0,
                                  child: Text(
                                    'Valoracion: ' +
                                        comments[index].puntuacion.toString(),
                                    style: TextStyle(fontSize: 16),
                                  )),
                            ],
                          )
                        ]),
                      ));
                }),
                itemCount: comments.length,
              ),
            ),
          );
  }
}
