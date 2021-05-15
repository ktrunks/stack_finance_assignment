import 'dart:ui';

import 'package:flutter/material.dart';

// application main  color
const progressColor = Color(0xffBf8223);
const white = Color(0xFFFFFFFF);

const primaryColor = Color(0xff000000);

const errorWidgetColor = Color(0xffEA4856);

const brownishGreyColor = Color(0xff646464);

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
