import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stack_finance_assignment/provider/change_password_provider.dart';
import 'package:stack_finance_assignment/provider/home_provider.dart';
import 'package:stack_finance_assignment/provider/auth_provider.dart';
import 'package:stack_finance_assignment/provider/notes_provider.dart';
import 'package:stack_finance_assignment/ui/auth/auth_screen.dart';
import 'package:stack_finance_assignment/ui/change_password/change_password_screen.dart';
import 'package:stack_finance_assignment/ui/home/home_screen.dart';
import 'package:stack_finance_assignment/ui/notes/notes_editor_screen.dart';
import 'package:stack_finance_assignment/ui/web_view/web_view_screen.dart';

/// root application launch
final Handler rootHandler = Handler(
    handlerFunc: (context, params) =>
        FirebaseAuth.instance.currentUser != null ? getHome() : getLogin());

final Handler homeHandler =
    Handler(handlerFunc: (context, params) => getHome());

final Handler singInHandler =
    Handler(handlerFunc: (context, params) => getLogin());

/// home screen handler
final Handler webViewHandler = Handler(handlerFunc: (context, params) {
  final obj = ModalRoute.of(context).settings.arguments;
  return WebViewScreen(obj);
});


/// notes screen handler
final Handler noteScreenHandler = Handler(handlerFunc: (context, params) {
  final obj = ModalRoute.of(context).settings.arguments;
  return  ChangeNotifierProvider<NotesProvider>(
    create: (context) => NotesProvider(obj),
    child: NoteScreen(),
  );
});


/// change password screen handler
final Handler changePasswordScreenHandler = Handler(handlerFunc: (context, params) {
  final obj = ModalRoute.of(context).settings.arguments;
  return  ChangeNotifierProvider<ChangePasswordProvider>(
    create: (context) => ChangePasswordProvider(),
    child: ChangePassword(),
  );
});


/// get login screen
Widget getLogin() {
  return ChangeNotifierProvider<AuthProvider>(
    create: (context) => AuthProvider(),
    child: AuthScreen(),
  );
}

/// home screen
Widget getHome() {
  return ChangeNotifierProvider<HomeProvider>(
    create: (context) => HomeProvider(),
    child: HomeScreen(),
  );
}
