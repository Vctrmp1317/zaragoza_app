import 'package:flutter/material.dart';

class AddFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  String modelo = '';
  String marca = '';
  String genero = '';
  int stock = 0;
  String edad = '';
  String color = '';
  String tipo = '';
  String material = '';
  int precio = 0;

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
