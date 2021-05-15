import 'dart:ui';

import 'package:flutter/material.dart';

// application main  color
const primaryColor = Color(0xffB90032);
const progressColor = Color(0xffBf8223);
const dialog_bg = Color(0xFFD5A058);
const white = Color(0xFFFFFFFF);

const secondaryColor = Color(0xff000000);

const errorWidgetColor = Color(0xffEA4856);

const cardBorder = Color(0xffe2e6ea);

/// browish grey color
const brownishGreyColor = Color(0xff646464);

const red = Colors.red;

Map<int, Color> color = {
  50: Color.fromRGBO(136, 14, 79, .1),
  100: Color.fromRGBO(136, 14, 79, .2),
  200: Color.fromRGBO(136, 14, 79, .3),
  300: Color.fromRGBO(136, 14, 79, .4),
  400: Color.fromRGBO(136, 14, 79, .5),
  500: Color.fromRGBO(136, 14, 79, .6),
  600: Color.fromRGBO(136, 14, 79, .7),
  700: Color.fromRGBO(136, 14, 79, .8),
  800: Color.fromRGBO(136, 14, 79, .9),
  900: Color.fromRGBO(136, 14, 79, 1),
};

MaterialColor secondaryPrimarySwatchColor = MaterialColor(0xff000000, color);