import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:provider/provider.dart';
import 'package:zaragoza_app/providers/add_form_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zaragoza_app/providers/update_form_provider.dart';

import '../models/models.dart';
import '../services/services.dart';

class EditProductScreen extends StatelessWidget {
  const EditProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(context),
        body: Stack(children: [
          const _backGroundAuth(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const SizedBox(height: 20),
            ],
          ),
        ]));
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, 'adminscreen', (route) => false);
            },
            icon: const Icon(Icons.logout, color: Colors.white)),
        title: Row(
          children: [
            const Text('Editar Producto',
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            const Spacer(),
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
              gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.centerLeft,
                  colors: [Colors.black, Colors.white38])),
          height: 1,
          width: 130,
          margin: const EdgeInsets.only(left: 20, bottom: 5, top: 5),
        ),
        Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.centerRight,
                  colors: [Colors.black, Colors.white38])),
          height: 1,
          width: 180,
          margin: const EdgeInsets.only(right: 20, bottom: 5, top: 5),
        ),
      ],
    );
  }
}

class _appBar extends StatelessWidget {
  const _appBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 10,
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              const Text('Editar Producto',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  )),
              const Spacer(),
              const SizedBox(width: 8),
              IconButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, 'tienda', (route) => false);
                  },
                  icon: const Icon(Icons.logout, color: Colors.black)),
            ],
          )),
    );
  }
}

class _classBar extends StatefulWidget {
  const _classBar({super.key});

  @override
  State<_classBar> createState() => __classBarState();
}

class __classBarState extends State<_classBar> {
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
              suffixIcon: const Icon(Icons.search),
              focusColor: Colors.black87,
              border: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Colors.black)),
              hintText: "Search",
            ),
          ),
        ),
        const Spacer(),
        Container(
            margin: const EdgeInsets.only(right: 20),
            child:
                IconButton(onPressed: () {}, icon: const Icon(Icons.checkroom)))
      ],
    );
  }
}

class _backGroundAuth extends StatelessWidget {
  const _backGroundAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color.fromARGB(255, 243, 242, 242),
      ),
      const SingleChildScrollView(
        child: _ColorBox(),
      )
    ]);
  }
}

class _ColorBox extends StatelessWidget {
  const _ColorBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(top: 20),
      height: size.height * 0.9,
      decoration: const BoxDecoration(
          boxShadow: [BoxShadow(color: Colors.black, blurRadius: 5)],
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      width: double.infinity,
      child: Stack(
        children: [
          Positioned(
              top: 100,
              child: Container(
                decoration: const BoxDecoration(
                    boxShadow: [BoxShadow(color: Colors.black, blurRadius: 20)],
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
              )),
          Container(
            width: 300,
            margin: const EdgeInsets.only(top: 10, left: 30),
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

  Articulo articulo = Articulo();
  final articuloService = ArticuloService();
  final articulosService = ArticulosServices();

  Future refresh() async {
    await articuloService.getArticulo();
    setState(() {
      articulo = articuloService.selectedArticulo;
      print(articulo.modelo! + 'Seleccionado');
    });
  }

  @override
  void initState() {
    super.initState();

    refresh();
  }

  @override
  Widget build(BuildContext context) {
    final addForm = Provider.of<UpdateFormProvider>(context);

    return Form(
        key: addForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: articuloService.isLoading
            ? const Center(
                child: SpinKitWave(
                    color: Color.fromRGBO(0, 153, 153, 1), size: 50))
            : Column(
                children: [
                  Stack(
                    children: [
                      (imagenPath == '')
                          ? const FadeInImage(
                              placeholder: AssetImage('assets/no-image.jpg'),
                              image: AssetImage('assets/no-image.jpg'),
                              width: 300,
                              height: 300,
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              File(imagenPath),
                              width: 300,
                              height: 300,
                              fit: BoxFit.cover,
                            ),
                      //  getImage(imagenPath),

                      Row(
                        children: [
                          IconButton(
                              iconSize: 30,
                              color: Colors.black,
                              onPressed: () async {
                                print(imagenPath);
                                final picker = ImagePicker();

                                final PickedFile? pickedFile =
                                    await picker.getImage(
                                        source: ImageSource.camera,
                                        imageQuality: 100);

                                print('tenemos imagen ' + pickedFile!.path);

                                imagenPath = pickedFile.path;

                                pickedFile.readAsBytes().then((value) {});
                                print(imagenPath);

                                pickedFile.readAsBytes().then((value) {});
                                setState(() {});
                              },
                              icon: const Icon(Icons.camera_alt_outlined)),
                          const Spacer(),
                          IconButton(
                              iconSize: 30,
                              color: Colors.black,
                              onPressed: () async {
                                final picker = ImagePicker();

                                final PickedFile? pickedFile =
                                    await picker.getImage(
                                        source: ImageSource.gallery,
                                        imageQuality: 100);

                                print('tenemos imagen ' + pickedFile!.path);

                                imagenPath = pickedFile.path;

                                pickedFile.readAsBytes().then((value) {});

                                setState(() {});
                              },
                              icon: const Icon(Icons.image_outlined))
                        ],
                      ),
                    ],
                  ),
                  TextFormField(
                    initialValue: articulo.modelo,
                    autocorrect: false,
                    decoration: const InputDecoration(
                        focusColor: Colors.black,
                        hintText: 'Modelo de prenda',
                        labelText: 'Modelo',
                        border: UnderlineInputBorder(),
                        suffixIcon: Icon(Icons.color_lens)),
                    onChanged: (value) => addForm.modelo = value,
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    autocorrect: false,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(
                        focusColor: Colors.black,
                        hintText: 'Stock de la prenda',
                        labelText: 'Stock',
                        border: UnderlineInputBorder(),
                        suffixIcon: Icon(Icons.style)),
                    onChanged: (value) => addForm.stock = value,
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    autocorrect: false,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(
                        focusColor: Colors.black,
                        hintText: 'Precio de la prenda',
                        labelText: 'Precio',
                        border: UnderlineInputBorder(),
                        suffixIcon: Icon(Icons.attach_money)),
                    onChanged: (value) => addForm.precio = value,
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
                              Provider.of<AddArticulosServices>(context,
                                  listen: false);

                          addArticuloService.updateArticulo(
                              addForm.modelo,
                              int.parse(addForm.stock),
                              int.parse(addForm.precio),
                              articulo.tipo!,
                              articulo.marca!,
                              articulo.talla!,
                              articulo.id!);

                          final articulosService = ArticulosServices();

                          Future refresh() async {
                            await articulosService.getArticulos();
                          }

                          setState(() {
                            refresh();
                          });

                          Navigator.pushReplacementNamed(context, 'tienda');
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
              ));
  }
}
