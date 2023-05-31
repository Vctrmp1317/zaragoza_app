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
import 'package:flutter_slidable/flutter_slidable.dart';

import '../models/models.dart';
import '../services/services.dart';

late int idAd = 0;
late int indAd = 0;

class AdminUsersScreen extends StatelessWidget {
  const AdminUsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final usersService = Provider.of<UserServices>(context);

    return usersService.isLoading
        ? const Center(
            child: SpinKitWave(color: Color.fromRGBO(0, 153, 153, 1), size: 50))
        : Scaffold(appBar: _appbar(context), body: _listProducts()
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   // ignore: prefer_const_literals_to_create_immutables
            //   children: [
            //     const _searchBar(),
            //     const SizedBox(height: 5),
            //     const _listProducts()
            //   ],
            );
  }

  AppBar _appbar(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          color: Colors.white,
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, 'adminscreen', (route) => false);
            final loginService =
                Provider.of<LoginServices>(context, listen: false);
            loginService.logout();
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
              onPressed: () {},
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
  List<DataUsers> users = [];
  final usersService = UserServices();

  Future refresh() async {
    setState(() => users.clear());

    await usersService.getUsers();

    setState(() {
      users = usersService.users;
      print(users[0].nombre);
    });
  }

  @override
  void initState() {
    super.initState();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: refresh,
        child: ListView.separated(
          itemBuilder: (context, index) {
            bool Act;
            bool Deact;

            return Container(
              color: Colors.white,
              child: Slidable(

                  // Specify a key if the Slidable is dismissible.
                  key: const ValueKey(0),

                  // The start action pane is the one at the left or the top side.
                  startActionPane: ActionPane(
                    // A motion is a widget used to control how the pane animates.
                    motion: const ScrollMotion(),

                    // A pane can dismiss the Slidable.
                    dismissible: DismissiblePane(onDismissed: () {}),
                    dragDismissible: false,

                    // All actions are defined in the children parameter.
                    children: [
                      // A SlidableAction can have an icon and/or a label.
                      SlidableAction(
                        onPressed: (BuildContext _) async {
                          await CoolAlert.show(
                            context: context,
                            type: CoolAlertType.warning,
                            title: '¿Estás seguro?',
                            text: "¿Seguro que quieres eliminar este usuario?",
                            showCancelBtn: true,
                            confirmBtnColor: Colors.red,
                            confirmBtnText: 'Delete',
                            onConfirmBtnTap: () {
                              //  deleteService.postDelete(users[index].id.toString());
                              String? msg = '';
                              // IndexScreen().list.removeAt(index);
                              setState(() {
                                users.removeAt(index);
                                final storage = const FlutterSecureStorage();
                                final ind = users[index].id;
                                storage.write(key: 'idEdit', value: '$ind');
                                usersService.deleteUser();
                              });
                              Fluttertoast.showToast(
                                  msg: 'Usuario eliminado correctamente');
                              Navigator.pop(context);
                            },
                            onCancelBtnTap: () {
                              Navigator.pop(context);
                            },
                          );
                        },
                        backgroundColor: const Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                      SlidableAction(
                        onPressed: (BuildContext context) {
                          final storage = const FlutterSecureStorage();
                          final ind = users[index].id;
                          storage.write(key: 'idEdit', value: '$ind');
                          usersService.loadUserId();
                          Navigator.pushReplacementNamed(context, 'edit');
                        },
                        backgroundColor: const Color(0xFF21B7CA),
                        foregroundColor: Colors.white,
                        icon: Icons.manage_accounts_rounded,
                        label: 'Editar',
                      ),
                    ],
                  ),

                  // The end action pane is the one at the right or the bottom side.
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      Visibility(
                        visible: true, //Deact,
                        child: SlidableAction(
                          onPressed: (BuildContext context) {
                            // deactivateService.postDeactivate(
                            //     users[index].id.toString());

                            // setState(() {
                            //   users[index].actived = 0;
                            // });
                            // //Navigator.restorablePushNamed(context, 'index2');
                          },
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.no_accounts_outlined,
                          label: 'Deactivate',
                        ),
                      ),
                      Visibility(
                        visible: false,
                        child: SlidableAction(
                          onPressed: (BuildContext context) {
                            // sgator.restorablePushNamed(context, 'index2');
                          },
                          backgroundColor: const Color(0xFF7BC043),
                          foregroundColor: Colors.white,
                          icon: Icons.check_outlined,
                          label: 'Activate',
                        ),
                      ),
                    ],
                  ),

                  // The child of the Slidable is what the user sees when the
                  // component is not dragged.
                  child: ListTile(
                    subtitle: Text(users[index].email!),
                    title: Text('${users[index].nombre!}',
                        style: const TextStyle(
                            color: Color.fromARGB(255, 18, 201, 159))),
                    //  subtitle:    (Text(_Index2ScreenState().users[index].email!)),
                    leading: const Icon(Icons.account_circle_rounded, size: 45),
                  )),
            );
          },
          itemCount: users.length,
          separatorBuilder: (BuildContext context, int index) {
            return Container(
                height: 0.5, color: const Color.fromARGB(255, 18, 201, 159));
          },
        ));
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

  List<DataUsers> users = [];

  @override
  void initState() {
    super.initState();
    final usersService = Provider.of<UserServices>(context, listen: false);
    users = usersService.users;
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
                      // final addArticuloService =
                      //     Provider.of<AddArticulosServices>(context,
                      //         listen: false);

                      // addArticuloService.updateArticulo(
                      //     addForm.modelo,
                      //     int.parse(addForm.stock),
                      //     int.parse(addForm.precio),
                      //     users[indAd].tipo!,
                      //     users[indAd].marca!,
                      //     users[indAd].talla!,
                      //     idAd);

                      final usersService = UserServices();

                      Future refresh() async {
                        await usersService.getUsers();
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
