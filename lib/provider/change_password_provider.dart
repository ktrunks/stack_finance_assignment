import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stack_finance_assignment/base_state.dart';
import 'package:stack_finance_assignment/util/color/colors.dart';

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
          .then((value) {
        Fluttertoast.showToast(
            msg: "Password updated successfully",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey,
            textColor: primaryColor,
            fontSize: 16.0);
        Navigator.pop(scaffoldKey.currentContext);
        Navigator.pop(scaffoldKey.currentContext);
      }).catchError((err) {
        updateErrorWidget(err);
        debugPrint('password updated error --- $err');
      });
    }
  }
}
