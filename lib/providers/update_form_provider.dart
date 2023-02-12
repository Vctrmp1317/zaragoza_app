import 'package:flutter/material.dart';

class UpdateFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int id = 0;
  String modelo = '';
  String marca = '';
  String tipo = '';
  String stock = '';
  String precio = '';

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
