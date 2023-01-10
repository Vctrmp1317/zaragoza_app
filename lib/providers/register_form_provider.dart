import 'package:flutter/material.dart';

class RegisterFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email = '';
  String nombre = '';
  String apellidos = '';
  String nombreEmpresa = '';
  String direccion = '';
  String password = '';

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
