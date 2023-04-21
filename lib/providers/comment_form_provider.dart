import 'package:flutter/material.dart';

class CommentFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  String comment = '';
  String mark = '';

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
