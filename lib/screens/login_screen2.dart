import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:zaragoza_app/providers/add_form_provider.dart';
import 'package:zaragoza_app/providers/login_form_provider.dart';
import 'package:zaragoza_app/screens/screens.dart';

const users = {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};

class Login2Screen extends StatelessWidget {
  const Login2Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 52),
          const _appBar(),
          const _dividerLine(),
          const SizedBox(height: 5),
          const _ColorBox()
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
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.30,
            ),
            const Text('Dress Up',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          ],
        ));
  }
}

class _ColorBox extends StatelessWidget {
  const _ColorBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(top: 50),
      height: size.height * 0.8,
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
                create: (_) => LoginFormProvider(),
                child: _loginForm(),
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
                  Navigator.popAndPushNamed(context, 'login');
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

class _loginForm extends StatefulWidget {
  @override
  State<_loginForm> createState() => _loginFormState();
}

class _loginFormState extends State<_loginForm> {
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
                    if (addForm.isValidForm()) {
                      if (users.containsKey(addForm.email)) {
                        if (users[addForm.email] == addForm.password) {
                          Navigator.pushNamedAndRemoveUntil(
                              context, 'tienda', (route) => false);
                        }
                      }

                      //Navigator.p ushNamed(context, 'edit');
                    }
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
