import 'package:flutter/material.dart';

/// used to dismiss keyboard
void dismissKeyboard(BuildContext context) {
  FocusScope.of(context).requestFocus(FocusNode());
}
