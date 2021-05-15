import 'package:flutter/material.dart';
import 'package:stack_finance_assignment/routes/sf_routes.dart';
import 'package:stack_finance_assignment/ui/auth/social_login.dart';
import 'package:stack_finance_assignment/util/enum.dart';
import 'package:stack_finance_assignment/util/helper.dart';
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

  /// used to show and hide password
  bool obscureText = true;

  /// email focus Node
  FocusNode emailFocusNode = FocusNode();

  /// password focus Node
  FocusNode passwordFocusNode = FocusNode();

  /// login screen email text controller
  TextEditingController emailTextController = TextEditingController();

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

  /// progress update call back
  void progressIndicatorUpdateCallback(bool status) {
    updateProgressIndicatorStatus(status);
  }

  /// google sign in
  void googleSignIn() {
    socialLogin.signInWithGoogle();
  }

  /// on login success
  void onLoginSuccess() {
    updateProgressIndicatorStatus(false);
    Navigator.popAndPushNamed(scaffoldKey.currentContext, SFRoutes.home);
  }

  void onClickOfSignInOrSingUp(AuthType type) {
    dismissErrorWidget();
    dismissKeyboard(scaffoldKey.currentContext);
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
    Map<String, dynamic> data = {};
    data['title'] = title;
    data['url'] = url;
    Navigator.pushNamed(scaffoldKey.currentContext, SFRoutes.webView,
        arguments: data);
  }
}
