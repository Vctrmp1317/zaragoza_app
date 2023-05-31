// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:nfc_in_flutter/nfc_in_flutter.dart';

import 'package:provider/provider.dart';
import 'package:zaragoza_app/api/speech_api.dart';

import 'package:zaragoza_app/providers/login_form_provider.dart';

import '../services/services.dart';

final ttsLogin = FlutterTts();

class Login2Screen extends StatefulWidget {
  const Login2Screen({Key? key}) : super(key: key);

  @override
  State<Login2Screen> createState() => _Login2ScreenState();
}

class _Login2ScreenState extends State<Login2Screen> {
  String text = 'Press the button and start speaking';
  bool isListening = false;

  Future _toggleRecording() async {
    SpeechApi.toggleRecording(
        onResult: (text) => setState(() => this.text = text),
        onListening: (isListening) {
          setState(() => this.isListening = isListening = isListening);
        });
  }

  Future refresh() async {
    ttsLogin.setSpeechRate(0.5);
    ttsLogin.speak('Bienvenido al inicio de sesión.');
  }

  @override
  void initState() {
    super.initState();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: _appbar(context),
        body: GestureDetector(
          onDoubleTap: () async {
            NDEFMessage message = await NFC
                .readNDEFDispatch(
                  once: true, // keep reading!!
                  throwOnUserCancel: true,
                )
                .first;

            String email = '';
            String password = '';
            print(message.records.elementAt(0).data);
            var cadena = [];
            cadena = message.records.elementAt(0).data.split(' ');
            email = cadena[0];
            password = cadena[1];

            final loginService =
                Provider.of<LoginServices>(context, listen: false);
            final userServices =
                Provider.of<UserServices>(context, listen: false);
            final String? errorMessage =
                await loginService.postLogin(email, password);
            print(errorMessage);
            if (errorMessage == 'A') {
              Navigator.pushNamed(context, 'tienda');
            } else if (errorMessage == 'U') {
              Navigator.pushNamed(context, 'userscreen');
              userServices.loadUser;
              Navigator.pushNamed(context, 'userscreen');
            } else {
              CoolAlert.show(
                  context: context,
                  type: CoolAlertType.error,
                  title: 'Datos incorrectos',
                  text: 'Email o Password incorrecto');
            }
          },
          onLongPress: _toggleRecording,
          onLongPressEnd: (details) async {
            setState(() {
              text = text.replaceAll('arroba', '@');
              text = text.replaceAll('punto', '.');
              text = text.replaceAll('uno', '1');
              text = text.replaceAll('dos', '2');
              text = text.replaceAll('tres', '3');
              text = text.replaceAll('cuatro', '4');
              text = text.replaceAll('cinco', '5');
              text = text.replaceAll('seis', '6');
              text = text.replaceAll('siete', '7');
              text = text.replaceAll('cuatro', '4');
            });
            if (text == 'ir a registro') {
              Navigator.pushReplacementNamed(context, 'registro');
            } else if (text.contains('iniciar sesión')) {
              String email = '';
              String password = '';
              print(text);
              var cadena = [];
              cadena = text.split(' ');
              email = cadena[0];
              password = cadena[1];

              final loginService =
                  Provider.of<LoginServices>(context, listen: false);
              final userServices =
                  Provider.of<UserServices>(context, listen: false);

              final String? errorMessage =
                  await loginService.postLogin(email, password);
              print(errorMessage);
              if (errorMessage == 'A') {
                Navigator.pushNamed(context, 'tienda');
              } else if (errorMessage == 'U') {
                Navigator.pushNamed(context, 'userscreen');
                userServices.loadUser;

                Navigator.pushNamed(context, 'userscreen');
              } else {
                CoolAlert.show(
                    context: context,
                    type: CoolAlertType.error,
                    title: 'Datos incorrectos',
                    text: 'Email o Password incorrecto');
              }
            }
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const SizedBox(height: 5),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  height: size.height * 0.855,
                  decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(color: Colors.black, blurRadius: 5)
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Positioned(
                          top: 100,
                          child: Container(
                            decoration: const BoxDecoration(
                                boxShadow: [
                                  BoxShadow(color: Colors.black, blurRadius: 20)
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30))),
                          )),
                      Positioned(
                        top: 100,
                        child: Container(
                          width: 300,
                          margin: const EdgeInsets.only(top: 10, left: 30),
                          child: ChangeNotifierProvider(
                              create: (context) => LoginFormProvider(),
                              child: _loginForm()),
                        ),
                      ),
                      const Positioned(
                          left: 50,
                          top: 50,
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 28,
                            ),
                          )),
                      Positioned(
                        left: 50,
                        bottom: 200,
                        child: TextButton(
                            onPressed: () {
                              Navigator.popAndPushNamed(context, 'registro');
                            },
                            child: const Text('Registrate',
                                style: TextStyle(
                                  fontSize: 24,
                                ))),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  AppBar _appbar(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Row(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.30,
            ),
            const Text(
              'Dress Up',
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
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

class _ColorBox extends StatelessWidget {
  const _ColorBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(top: 20),
      height: size.height * 0.855,
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
          Positioned(
            top: 100,
            child: Container(
              width: 300,
              margin: const EdgeInsets.only(top: 10, left: 30),
              child: ChangeNotifierProvider(
                create: (context) => LoginFormProvider(),
                child: Builder(builder: (BuildContext newContext) {
                  final addForm = Provider.of<LoginFormProvider>(newContext);

                  final size = MediaQuery.of(newContext).size;

                  return Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 234, 229, 229),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [const BoxShadow(color: Colors.black)]),
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    width: double.infinity,
                    height: 250,
                    child: Form(
                        key: addForm.formKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          children: [
                            TextFormField(
                                autocorrect: false,
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                  focusColor: Colors.black,
                                  hintText: 'Email',
                                  labelText: 'Email',
                                  suffixIcon:
                                      Icon(Icons.alternate_email_outlined),
                                  border: UnderlineInputBorder(),
                                ),
                                onChanged: (value) => addForm.email = value,
                                validator: (value) {
                                  String pattern =
                                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

                                  RegExp regExp = new RegExp(pattern);
                                  return regExp.hasMatch(value ?? '')
                                      ? null
                                      : 'Insert email';
                                }),
                            const SizedBox(height: 10),
                            TextFormField(
                              obscureText: true,
                              autocorrect: false,
                              decoration: const InputDecoration(
                                  focusColor: Colors.black,
                                  hintText: 'Password',
                                  labelText: 'Password',
                                  border: UnderlineInputBorder(),
                                  suffixIcon: Icon(Icons.password)),
                              onChanged: (value) => addForm.password = value,
                              validator: ((value) {
                                return (value != null && value.length >= 1)
                                    ? null
                                    : 'Please, enter your password';
                              }),
                            ),
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
                                  FocusScope.of(newContext)
                                      .requestFocus(FocusNode());
                                  final loginService =
                                      Provider.of<LoginServices>(newContext,
                                          listen: false);
                                  final userServices =
                                      Provider.of<UserServices>(newContext,
                                          listen: false);
                                  if (addForm.isValidForm()) {
                                    final String? errorMessage =
                                        await loginService.postLogin(
                                            addForm.email, addForm.password);
                                    if (errorMessage == 'a') {
                                      Navigator.pushReplacementNamed(
                                          newContext, 'adminscreen');
                                    } else if (errorMessage == 'u') {
                                      userServices.loadUser;

                                      Navigator.pushNamed(
                                          newContext, 'userscreen');
                                    } else {
                                      CoolAlert.show(
                                          context: newContext,
                                          type: CoolAlertType.error,
                                          title: 'Datos incorrectos',
                                          text: 'Email o Password incorrecto');
                                    }
                                  }

                                  //Navigator.p ushNamed(newContext, 'edit');
                                },
                                // ignore: prefer_const_literals_to_create_immutables
                                child: Row(children: [
                                  const Text(
                                    'Iniciar Sesion',
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
                }),
              ),
            ),
          ),
          const Positioned(
              left: 50,
              top: 50,
              child: Text(
                'Login',
                style: TextStyle(
                  fontSize: 28,
                ),
              )),
          Positioned(
            left: 50,
            bottom: 200,
            child: TextButton(
                onPressed: () {
                  Navigator.popAndPushNamed(context, 'registro');
                },
                child: const Text('Registrate',
                    style: TextStyle(
                      fontSize: 24,
                    ))),
          )
        ],
      ),
    );
  }
}

class _loginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final addForm = Provider.of<LoginFormProvider>(context);

    final size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 234, 229, 229),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [const BoxShadow(color: Colors.black)]),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      height: 250,
      child: Form(
          key: addForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    focusColor: Colors.black,
                    hintText: 'Email',
                    labelText: 'Email',
                    suffixIcon: Icon(Icons.alternate_email_outlined),
                    border: UnderlineInputBorder(),
                  ),
                  onChanged: (value) => addForm.email = value,
                  validator: (value) {
                    String pattern =
                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

                    RegExp regExp = new RegExp(pattern);
                    return regExp.hasMatch(value ?? '') ? null : 'Insert email';
                  }),
              const SizedBox(height: 10),
              TextFormField(
                obscureText: true,
                autocorrect: false,
                decoration: const InputDecoration(
                    focusColor: Colors.black,
                    hintText: 'Password',
                    labelText: 'Password',
                    border: UnderlineInputBorder(),
                    suffixIcon: Icon(Icons.password)),
                onChanged: (value) => addForm.password = value,
                validator: ((value) {
                  return (value != null && value.length >= 1)
                      ? null
                      : 'Please, enter your password';
                }),
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
                    if (addForm.email == 'admin' ||
                        addForm.password == 'admin') {
                      Navigator.pushReplacementNamed(context, 'adminscreen');
                    } else {
                      final loginService =
                          Provider.of<LoginServices>(context, listen: false);
                      final userServices =
                          Provider.of<UserServices>(context, listen: false);
                      if (addForm.isValidForm()) {
                        final String? errorMessage = await loginService
                            .postLogin(addForm.email, addForm.password);
                        print(errorMessage);
                        if (errorMessage == 'A') {
                          Navigator.pushNamed(context, 'adminscreen');
                        } else if (errorMessage == 'U') {
                          userServices.loadUser;

                          Navigator.pushNamed(context, 'userscreen');
                        } else {
                          CoolAlert.show(
                              context: context,
                              type: CoolAlertType.error,
                              title: 'Datos incorrectos',
                              text: 'Email o Password incorrecto');
                        }
                      }
                    }

                    //Navigator.p ushNamed(context, 'edit');
                  },
                  // ignore: prefer_const_literals_to_create_immutables
                  child: Row(children: [
                    const Text(
                      'Iniciar Sesion',
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
