import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:provider/provider.dart';
import 'package:zaragoza_app/providers/add_form_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zaragoza_app/providers/editComment_form_provider.dart';
import 'package:zaragoza_app/providers/edit_form_provider.dart';

import '../models/models.dart';
import '../services/services.dart';

class EditCommentScreen extends StatelessWidget {
  const EditCommentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(context),
        body: SingleChildScrollView(
          child: Stack(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // ignore: prefer_const_literals_to_create_immutables
              children: [_ColorBox()],
            ),
          ]),
        ));
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
            const Text('Editar Valoracion',
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

class _ColorBox extends StatelessWidget {
  const _ColorBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.all(25),
      height: size.height * 0.25,
      decoration: const BoxDecoration(
          boxShadow: [BoxShadow(color: Colors.black, blurRadius: 5)],
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30))),
      width: size.width * 0.90,
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
  late XFile? pickedFile;
  final articuloService = ArticuloService();

  Comments user = Comments();
  late String? comentario = 'Hola';

  Future refresh() async {
    await articuloService.getComment();

    setState(() {
      user = articuloService.selectedComment;
      print(articuloService.selectedComment.comentario);
      // print(user.name);
      comentario = articuloService.selectedComment.comentario;
    });
  }

  @override
  void initState() {
    super.initState();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    final addForm = Provider.of<EditCommentFormProvider>(context);

    return articuloService.isLoading
        ? const Center(
            child: SpinKitWave(color: Color.fromRGBO(0, 153, 153, 1), size: 50))
        : Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            height: 610,
            child: Form(
                key: addForm.formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                          initialValue: comentario,
                          autocorrect: false,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            focusColor: Colors.black,
                            hintText: 'Comentario',
                            labelText: 'Comentario',
                            suffixIcon: Icon(Icons.checkroom),
                            border: UnderlineInputBorder(),
                          ),
                          onChanged: (value) => addForm.comentario = value,
                          validator: (value) {}),
                      const SizedBox(height: 10),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: 300,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            )),
                            backgroundColor: MaterialStateProperty.all(
                                Colors.blueAccent[100]),
                            fixedSize: MaterialStateProperty.all(
                                const Size(double.infinity, 30)),
                          ),
                          onPressed: () async {
                            FocusScope.of(context).requestFocus(FocusNode());

                            //Navigator.pushNamed(context, 'edit');
                            if (addForm.isValidForm()) {
                              //Navigator.pushNamed(context, 'edit');
                              final editCommentService =
                                  Provider.of<ArticuloService>(context,
                                      listen: false);

                              final resp = await editCommentService
                                  .editComment(addForm.comentario);
                              await CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.info,
                                  text: resp,
                                  onConfirmBtnTap: () =>
                                      Navigator.pushReplacementNamed(
                                          context, 'adminusersscreen'));
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
                  ),
                )),
          );
  }
}
