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
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 52),
          const _appBar(),
          const _dividerLine(),
          const _searchBar(),
          const SizedBox(height: 5),
          const listProductsUser()
        ],
      ),
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

class _appBar extends StatelessWidget {
  const _appBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            const Text('Inicio',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.manage_accounts),
              onPressed: () {},
            ),
            const SizedBox(width: 8),
            IconButton(
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
                  Navigator.pushNamed(context, 'addproduct');
                },
                icon: const Icon(Icons.checkroom)))
      ],
    );
  }
}

class listProductsUser extends StatefulWidget {
  const listProductsUser({super.key});

  @override
  State<listProductsUser> createState() => _listProductsUserState();
}

class _listProductsUserState extends State<listProductsUser> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 550,
        width: 400,
        child: GridView.builder(
          itemBuilder: ((context, index) => const Card()),
          itemCount: 10,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisExtent: 350, mainAxisSpacing: 30),
        ),
      ),
    );
  }
}

class Card extends StatelessWidget {
  const Card({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController customController = TextEditingController();

    createAlertDialog(context, customController) {
      return showDialog(
          builder: (BuildContext context) {
            return AlertDialog(
                title: const Text('Editar prenda',
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                content: SingleChildScrollView(child: const _ColorBox()),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)));
          },
          context: context);
    }

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
                child: const ClipRRect(
                  child: FadeInImage(
                    placeholder: AssetImage('assets/no-image.jpg'),
                    image: AssetImage('assets/no-image.jpg'),
                    width: 300,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                  right: 0,
                  child: IconButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white)),
                      iconSize: 30,
                      onPressed: () {
                        createAlertDialog(context, customController);
                      },
                      icon: const Icon(Icons.edit_outlined)))
            ]),
            const SizedBox(
              height: 5,
            ),
            Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Text('Prenda',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
              ],
            ),
            Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Text('€32,00',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
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
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
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
                        onConfirmBtnTap: () {
                          Navigator.pop(context);
                        },
                        showCancelBtn: true,
                        onCancelBtnTap: () {
                          Navigator.pop(context);
                        },
                      );
                    },
                    icon: const Icon(Icons.remove_shopping_cart_outlined))
              ],
            )
          ],
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
  @override
  Widget build(BuildContext context) {
    final addForm = Provider.of<AddFormProvider>(context);
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
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    focusColor: Colors.black,
                    hintText: 'Tipo de prenda',
                    labelText: 'Tipo',
                    suffixIcon: Icon(Icons.checkroom),
                    border: UnderlineInputBorder(),
                  ),
                  onChanged: (value) => addForm.tipo = value,
                  validator: (value) {}),
              const SizedBox(height: 10),
              TextFormField(
                autocorrect: false,
                decoration: const InputDecoration(
                    focusColor: Colors.black,
                    hintText: 'Color de prenda',
                    labelText: 'Color',
                    border: UnderlineInputBorder(),
                    suffixIcon: Icon(Icons.color_lens)),
                onChanged: (value) => addForm.color = value,
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField(
                  icon: const Icon(Icons.accessibility_sharp),
                  value: dropdownValue,
                  items: list.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    addForm.talla = value!;
                    dropdownValue = value;
                  }),
              const SizedBox(height: 10),
              TextFormField(
                autocorrect: false,
                decoration: const InputDecoration(
                    focusColor: Colors.black,
                    hintText: 'Material de la prenda',
                    labelText: 'Material',
                    border: UnderlineInputBorder(),
                    suffixIcon: Icon(Icons.style)),
                onChanged: (value) => addForm.material = value,
              ),
              const SizedBox(height: 10),
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
                onChanged: (value) => addForm.precio = value as int,
              ),
              const SizedBox(height: 10),
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
