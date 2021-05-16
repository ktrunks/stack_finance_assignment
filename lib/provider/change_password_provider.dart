import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stack_finance_assignment/base_state.dart';

class ChangePasswordProvider extends BaseState {
  /// new password text controller
  TextEditingController newPasswordController = TextEditingController();

  /// new password focus Node
  FocusNode newPasswordNode = FocusNode();

  /// new password text controller
  TextEditingController confirmPasswordController = TextEditingController();

  /// new password focus Node
  FocusNode confirmPasswordNode = FocusNode();

  void onClickOfChangePassword() {
    dismissErrorWidget();
    if (formKey.currentState.validate()) {
      FirebaseAuth.instance.currentUser
          .updatePassword(newPasswordController.text.trim())
          .then((value) {})
          .catchError((err) {
        updateErrorWidget(err);
        debugPrint('password updated error --- $err');
      });
    }
  }
}
