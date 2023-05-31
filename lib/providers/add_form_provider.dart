import 'package:flutter/material.dart';

class AddFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  String modelo = '';
  String marca = '';
  String genero = '';
  String stock = '';
  String edad = '';
  String color = '';
  String categoria = '';
  String tipo = '';
  String material = '';
  String precio = '';
  String talla = '';

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
