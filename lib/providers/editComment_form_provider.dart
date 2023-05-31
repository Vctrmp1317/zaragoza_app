import 'package:flutter/material.dart';

class EditCommentFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String comentario = '';

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
