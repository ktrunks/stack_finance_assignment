import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stack_finance_assignment/provider/change_password_provider.dart';
import 'package:stack_finance_assignment/util/color/colors.dart';
import 'package:stack_finance_assignment/util/style/style.dart';
import 'package:stack_finance_assignment/util/validator.dart';
import 'package:stack_finance_assignment/widgets/button_widget.dart';
import 'package:stack_finance_assignment/widgets/custom_progress_indicator.dart';
import 'package:stack_finance_assignment/widgets/error_widget.dart';

class ChangePassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ChangePasswordProvider changePasswordProvider =
        Provider.of<ChangePasswordProvider>(context);
    return SafeArea(
      child: Scaffold(
        key: changePasswordProvider.scaffoldKey,
        appBar: AppBar(title: Text('Change Password')),
        body: Stack(
          children: [
            ListView(
              children: [
                Selector<ChangePasswordProvider, String>(
                    builder: (context, data, child) {
                      return data != ''
                          ? CustomErrorWidget(
                              data, changePasswordProvider.dismissErrorWidget)
                          : Container();
                    },
                    selector: (buildContext, provider) => provider.error),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: screenSpacing,
                  child: Column(
                    children: [
                      Form(
                          key: changePasswordProvider.formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'New Password',
                                style: textStyle16PrimaryColor,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.text,
                                onFieldSubmitted: (terms) {},
                                textInputAction: TextInputAction.next,
                                controller: changePasswordProvider
                                    .newPasswordController,
                                focusNode:
                                    changePasswordProvider.newPasswordNode,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey)),
                                  errorBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.red)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black26)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: progressColor)),
                                  hintText: 'New Password',
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(10, 5, 0, 5),
                                  //border: InputBorder.none,
                                ),
                                validator: (data) {
                                  if (data.isEmpty) {
                                    return 'New Password is required ';
                                  } else if (data.length < 8) {
                                    return 'New Password should be greater than 8 character';
                                  } else if (!passwordValidation(data)) {
                                    return 'Password Should contain alpha, numeric and special character';
                                  } else
                                    return null;
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Confirm Password',
                                style: textStyle16PrimaryColor,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.text,
                                onFieldSubmitted: (terms) {
                                  changePasswordProvider
                                      .onClickOfChangePassword();
                                },
                                textInputAction: TextInputAction.done,
                                focusNode:
                                    changePasswordProvider.confirmPasswordNode,
                                controller: changePasswordProvider
                                    .confirmPasswordController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey)),
                                  errorBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.red)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black26)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: progressColor)),
                                  hintText: 'Confirm Password',
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(10, 5, 0, 5),
                                  //border: InputBorder.none,
                                ),
                                validator: (data) {
                                  if (data.isEmpty) {
                                    return "Please enter confirm password";
                                  } else if (data !=
                                      changePasswordProvider
                                          .newPasswordController.text
                                          .trim()) {
                                    return "password and confirm password dosen't match";
                                  } else
                                    return null;
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: <Widget>[
                                  ButtonWidget(
                                    buttonText: 'Save',
                                    fillColor: primaryColor,
                                    textColor: Colors.white,
                                    callBack: () {
                                      changePasswordProvider
                                          .onClickOfChangePassword();
                                    },
                                    textStyle: buttonTextStyle16WhiteColor,
                                    buttonStatus: true,
                                    borderRadius: 2,
                                  ),
                                ],
                              )
                            ],
                          )),
                    ],
                  ),
                )
              ],
            ),
            Selector<ChangePasswordProvider, bool>(
                builder: (context, data, child) {
                  return data ? CustomProgressIndicator() : Container();
                },
                selector: (buildContext, provider) =>
                    provider.progressIndicatorStatus)
          ],
        ),
      ),
    );
  }
}
