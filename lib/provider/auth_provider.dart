import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stack_finance_assignment/routes/sf_routes.dart';
import 'package:stack_finance_assignment/ui/auth/social_login.dart';
import 'package:stack_finance_assignment/util/enum.dart';
import 'package:stack_finance_assignment/util/validator.dart';

import '../base_state.dart';

/// state of sign in or sign up
class AuthProvider extends BaseState {
  /// social login service
  SocialLogin socialLogin;

  /// sign in provider constructor
  AuthProvider() {
    socialLogin = SocialLogin(
      progressIndicatorUpdateCallback: progressIndicatorUpdateCallback,
      errorCallback: updateErrorWidget,
      onLoginSuccess: onLoginSuccess,
    );
  }

  /// login screen password text controller
  TextEditingController passwordTextController = TextEditingController();

  bool isMail = true;

  /// used to show and hide password
  bool obscureText = true;

  /// check box status
  bool agreeCheckBoxStatus = true;

  /// login form key
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  /// email focus Node
  FocusNode emailFocusNode = FocusNode();

  /// password focus Node
  FocusNode passwordFocusNode = FocusNode();

  /// login screen email text controller
  TextEditingController emailTextController = TextEditingController();

  StreamController<bool> obscureTextStreamController =
      StreamController.broadcast();

  ///method to show or hide password
  void showHidePass() {
    if (obscureText) {
      obscureText = false;
      notifyListeners();
    } else {
      obscureText = true;
      notifyListeners();
    }
  }

  /// on click of manual login
  void onClickOfSign() {
    if (loginFormKey.currentState.validate()) {
      registerUser(
          emailTextController.text.trim(), passwordTextController.text.trim());
    } else {
      /*doLogin(emailTextController.text.trim(),
            passwordTextController.text.trim());*/
    }
  }

  /// progress update call back
  void progressIndicatorUpdateCallback(bool status) {
    updateProgressIndicatorStatus(status);
  }

  /// email and password login method
  Future<void> doLogin(String email, String password) async {
    updateErrorWidget('');
    await socialLogin.emailAndPasswordLogin(
      email: email,
      password: password,
    );
  }

  /// email and password login method
  Future<void> registerUser(String email, String password) async {
    updateErrorWidget('');
    await socialLogin.createUserWithEmailAndPassword(
      email,
      password,
    );
  }

  /// google sign in
  void googleSignIn() {
    socialLogin.signInWithGoogle();
  }

  /// facebook sign in
  void facebookSignIn() {
    socialLogin.facebook();
  }

  /// on login success
  void onLoginSuccess() {
    updateProgressIndicatorStatus(false);
    Navigator.popAndPushNamed(scaffoldKey.currentContext, SFRoutes.home);
  }

  void onClickOfSignInOrSingUp(AuthType type) {
    dismissErrorWidget();
    if (emailTextController.text.trim().isNotEmpty) {
      if (passwordTextController.text.trim().isNotEmpty) {
        debugPrint(
            'password validation  -- ${passwordValidation(passwordTextController.text.trim())}');
        if (passwordValidation(passwordTextController.text.trim())) {
          type == AuthType.SignUp
              ? socialLogin.createUserWithEmailAndPassword(
                  emailTextController.text.trim(),
                  passwordTextController.text.trim())
              : socialLogin.emailAndPasswordLogin(
                  email: emailTextController.text.trim(),
                  password: passwordTextController.text.trim());
        } else {
          updateErrorWidget(
              'Password Should contain alpha, numeric and special character');
        }
      } else {
        updateErrorWidget('Please Enter password');
      }
    } else {
      updateErrorWidget('Please Enter Email ID');
    }
  }

  void launchWebView(String title, String url) {
    Navigator.pushNamed(scaffoldKey.currentContext, SFRoutes.web_view);
  }
}
