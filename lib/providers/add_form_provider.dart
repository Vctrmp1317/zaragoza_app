import 'package:flutter/material.dart';

class AddFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  String tipo = '';
  String color = '';
  String talla = '';
  String material = '';
  int precio = 0;

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
