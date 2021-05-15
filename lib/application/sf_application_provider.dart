import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// application state
class SFApplication extends ChangeNotifier {
  SFApplication();

  SharedPreferences sharedPreferences;
}
