import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:zaragoza_app/providers/register_form_provider.dart';
import 'package:zaragoza_app/screens/screens.dart';

import '../services/services.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appbar(context),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [SizedBox(height: 5), _ColorBox()],
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
      margin: const EdgeInsets.only(top: 10),
      height: size.height * 0.870,
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
              margin: const EdgeInsets.only(top: 5, left: 30),
              child: ChangeNotifierProvider(
                create: (_) => RegisterFormProvider(),
                child: _registerForm(),
              ),
            ),
          ),
          const Positioned(
              left: 50,
              top: 20,
              child: Text(
                'Registro',
                style: TextStyle(
                  fontSize: 28,
                ),
              )),
          Positioned(
            left: 40,
            top: 40,
            child: TextButton(
                onPressed: () {
                  Navigator.popAndPushNamed(context, 'login');
                },
                child: const Text('¿Ya tienes una cuenta?',
                    style: TextStyle(
                      fontSize: 18,
                    ))),
          )
        ],
      ),
    );
  }
}

class _registerForm extends StatefulWidget {
  @override
  State<_registerForm> createState() => _registerFormState();
}

class _registerFormState extends State<_registerForm> {
  String confirmarPassword = '';

  @override
  Widget build(BuildContext context) {
    final addForm = Provider.of<RegisterFormProvider>(context);

    final size = MediaQuery.of(context).size;

    @override
    void initState() {
      super.initState();
    }

    return Container(
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 234, 229, 229),
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [BoxShadow(color: Colors.black)]),
      margin: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      height: 500,
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
              ),
              const SizedBox(height: 5),
              TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  focusColor: Colors.black,
                  hintText: 'Nombre',
                  labelText: 'Nombre',
                  suffixIcon: Icon(Icons.abc_outlined),
                  border: UnderlineInputBorder(),
                ),
                onChanged: (value) => addForm.name = value,
              ),
              const SizedBox(height: 5),
              TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  focusColor: Colors.black,
                  hintText: 'Apellidos',
                  labelText: 'Apellidos',
                  suffixIcon: Icon(Icons.abc_outlined),
                  border: UnderlineInputBorder(),
                ),
                onChanged: (value) => addForm.surname = value,
              ),
              const SizedBox(height: 5),
              const SizedBox(height: 5),
              TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  focusColor: Colors.black,
                  hintText: 'Direccion',
                  labelText: 'Direccion',
                  suffixIcon: Icon(Icons.location_on),
                  border: UnderlineInputBorder(),
                ),
                onChanged: (value) => addForm.direccion = value,
              ),
              const SizedBox(height: 5),
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
              ),
              TextFormField(
                obscureText: true,
                autocorrect: false,
                decoration: const InputDecoration(
                    focusColor: Colors.black,
                    hintText: 'Confirmar Password',
                    labelText: 'Confirmar Password',
                    border: UnderlineInputBorder(),
                    suffixIcon: Icon(Icons.password)),
                onChanged: (value) => addForm.cPassword = value,
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
                    //    if (addForm.isValidForm()) {
                    //    if (users.contains(addForm.email)) {
                    //TO DO: ALERTA DE EMAIL YA EXISTENTE
                    //  } else {
                    //  if (addForm.password == confirmarPassword) {}
                    //}
                    // }
                    final registerService =
                        Provider.of<RegisterServices>(context, listen: false);

                    if (addForm.isValidForm()) {
                      final String? errorMessage =
                          await registerService.postRegister(
                              addForm.name,
                              addForm.surname,
                              addForm.email,
                              addForm.password,
                              addForm.cPassword,
                              addForm.direccion);
                      print(errorMessage);
                      if (errorMessage == 'Usuario registrado correctamente') {
                        Navigator.pushReplacementNamed(context, 'login');
                      } else {
                        CoolAlert.show(
                            context: context,
                            type: CoolAlertType.error,
                            title: 'Datos incorrectos',
                            text: errorMessage);
                      }
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
