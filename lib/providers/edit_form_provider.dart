import 'package:flutter/material.dart';

class EditFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String nombre = '';
  String apellidos = '';
  String direccion = '';

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
