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

late int idA = 0;
late int indA = 0;

class AdminScreen extends StatelessWidget {
  const AdminScreen({Key? key}) : super(key: key);

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
                children: [const _listProducts()],
              ),
            ));
  }

  AppBar _appbar(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
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
            IconButton(
              color: Colors.white,
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, 'login2', (route) => false);
                final loginService =
                    Provider.of<LoginServices>(context, listen: false);
                loginService.logout();
              },
              icon: const Icon(Icons.logout),
            )
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

class _listProducts extends StatefulWidget {
  const _listProducts({super.key});

  @override
  State<_listProducts> createState() => _listProductsState();
}

class _listProductsState extends State<_listProducts> {
  List<Articulos> articulos = [];
  final articulosService = ArticulosServices();

  final articuloService = ArticuloService();

  Future refresh() async {
    setState(() => articulos.clear());

    await articulosService.getArticulos();

    setState(() {
      articulos = articulosService.articulos;
    });
  }

  void updateList(String value) {
    setState(() {
      //ind = -1;
      articulos = articulosService.articulos
          .where((element) =>
              element.modelo!.toLowerCase().contains(value.toLowerCase()))
          .toList();

      articulos.addAll(articulosService.articulos
          .where((element) =>
              element.categoria!.toLowerCase().contains(value.toLowerCase()))
          .toList());
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
                  start: 20, top: 10, bottom: 10),
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
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 600,
            width: 400,
            child: GridView.builder(
              itemBuilder: ((context, index) {
                return Padding(
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
                            child: articulos[index].foto == null
                                ? const ClipRRect(
                                    child: FadeInImage(
                                      placeholder:
                                          AssetImage('assets/no-image.jpg'),
                                      image: AssetImage('assets/no-image.jpg'),
                                      width: 300,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : ClipRRect(
                                    child: FadeInImage(
                                      placeholder: const AssetImage(
                                          'assets/no-image.jpg'),
                                      image: NetworkImage(
                                          'http://dressup.allsites.es/public/imagenes/' +
                                              articulos[index].foto!),
                                      width: 300,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ),
                          Positioned(
                              left: 0,
                              child: IconButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white)),
                                  iconSize: 30,
                                  onPressed: () {
                                    final storage =
                                        const FlutterSecureStorage();

                                    final ind = articulos[index].id;

                                    storage.write(
                                        key: 'idArticulo', value: '$ind');
                                    //ArticuloService().getComments();
                                    Navigator.pushReplacementNamed(
                                        context, 'comments');
                                  },
                                  icon: const Icon(Icons.comment))),
                          Positioned(
                              right: 0,
                              child: IconButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white)),
                                  iconSize: 30,
                                  onPressed: () {
                                    final storage =
                                        const FlutterSecureStorage();

                                    final ind = articulos[index].id;

                                    storage.write(
                                        key: 'idArticulo', value: '$ind');
                                    articuloService.getArticulo();
                                    Navigator.pushReplacementNamed(
                                        context, 'editproduct');
                                  },
                                  icon: const Icon(Icons.edit_outlined)))
                        ]),
                        const SizedBox(
                          height: 5,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Text(articulos[index].modelo!,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),
                        Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Text(articulos[index].precio.toString() + '€',
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                            const Spacer(),
                            Text(articulos[index].marca!,
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
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
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const Text('Eliminar producto',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                            const Spacer(),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  CoolAlert.show(
                                    context: context,
                                    type: CoolAlertType.warning,
                                    title: '¿Deseas eliminar este articulo?',

                                    borderRadius: 30,
                                    //loopAnimation: true,
                                    confirmBtnColor: Colors.blueAccent,
                                    confirmBtnText: 'Aceptar',
                                    cancelBtnText: 'Cancelar',
                                    onConfirmBtnTap: () async {
                                      final String? msg =
                                          await ArticuloService()
                                              .deleteArticulo(
                                                  articulos[index].id!);
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
                                    Icons.remove_shopping_cart_outlined)),
                            Spacer(),
                            IconButton(
                                onPressed: () {
                                  final articuloService =
                                      Provider.of<ArticuloService>(context,
                                          listen: false);
                                  setState(() {
                                    final idArticulo;
                                    idArticulo = articulos[indA].id!;

                                    articulosService.loadArticulo(idArticulo);
                                  });
                                  Navigator.pushReplacementNamed(
                                      context, 'writescreen');
                                },
                                icon: Icon(Icons.nfc))
                          ],
                        )
                      ],
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
    final addForm = Provider.of<UpdateFormProvider>(context);
    const List<String> list = <String>['S', 'M', 'L', 'XL', 'XXL'];
    String dropdownValue = list.first;
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
              Stack(
                children: [
                  (imagenPath == '')
                      ? const FadeInImage(
                          placeholder: AssetImage('assets/no-image.jpg'),
                          image: AssetImage('assets/no-image.jpg'),
                          width: 300,
                          height: 150,
                          fit: BoxFit.cover,
                        )
                      : Image.file(
                          File(imagenPath),
                          width: 300,
                          height: 180,
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
                          articulo[indA].tipo!,
                          articulo[indA].marca!,
                          articulo[indA].talla!,
                          idA);

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
          )),
    );
  }
}
