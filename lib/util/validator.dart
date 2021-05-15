import 'package:flutter/material.dart';

/// email validation
String validateEmail(String value) {
  if (value.isEmpty) return 'pleas enter email id';
  final emailRegEx = RegExp(r"^[a-zA-Z0-9.-_]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  if (!emailRegEx.hasMatch(value.trim())) return 'Invalid email id';
  return null;
}

/// password validation
bool passwordValidation(String value){
  String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regExp = new RegExp(pattern);
  return regExp.hasMatch(value);
}