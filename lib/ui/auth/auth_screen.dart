import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stack_finance_assignment/provider/auth_provider.dart';
import 'package:stack_finance_assignment/util/color/colors.dart';
import 'package:stack_finance_assignment/util/enum.dart';
import 'package:stack_finance_assignment/util/style/style.dart';
import 'package:stack_finance_assignment/util/validator.dart';
import 'package:stack_finance_assignment/widgets/button_widget.dart';
import 'package:stack_finance_assignment/widgets/custom_progress_indicator.dart';
import 'package:stack_finance_assignment/widgets/error_widget.dart';

/// sign in or sign up
/// which contains username/password
class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          key: authProvider.scaffoldKey,
          body: DefaultTabController(
            length: 2,
            child: Scaffold(
              body: Column(
                children: [
                  Container(
                    color: secondaryColor,
                    child: TabBar(
                      tabs: [
                        Tab(
                          text: 'Sign In',
                        ),
                        Tab(
                          text: 'Sing Up',
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        authWidget(authProvider, AuthType.SignIn),
                        authWidget(authProvider, AuthType.SignUp)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Widget authWidget(AuthProvider authProvider, AuthType type) {
    return Stack(
      children: <Widget>[
        ListView(
          shrinkWrap: true,
          children: <Widget>[
            Selector<AuthProvider, String>(
                builder: (context, data, child) {
                  return data != ''
                      ? CustomErrorWidget(data, authProvider.dismissErrorWidget)
                      : Container();
                },
                selector: (buildContext, provider) => provider.error),
            Padding(
              padding: screenSpacing,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    controller: authProvider.emailTextController,
                    enableSuggestions: false,
                    autofocus: false,
                    onFieldSubmitted: (term) {
                      authProvider.emailFocusNode.unfocus();
                      FocusScope.of(authProvider.scaffoldKey.currentContext)
                          .requestFocus(authProvider.passwordFocusNode);
                    },
                    validator: (data) {
                      return validateEmail(data);
                    },
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black26)),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: progressColor)),
                      hintText: 'Email',
                      contentPadding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    ),
                    onSaved: (email) {},
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Selector<AuthProvider, bool>(
                      builder: (context, data, child) {
                        return TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          onFieldSubmitted: (terms) {},
                          textInputAction: TextInputAction.next,
                          obscureText: authProvider.obscureText,
                          controller: authProvider.passwordTextController,
                          decoration: InputDecoration(
                            suffixIcon: InkWell(
                                onTap: authProvider.showHidePass,
                                child: Icon(
                                  authProvider.obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: secondaryColor,
                                )),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black26)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: progressColor)),
                            hintText: 'Password',
                            contentPadding:
                                const EdgeInsets.fromLTRB(10, 5, 0, 5),
                            //border: InputBorder.none,
                          ),
                          validator: (data) {
                            if (data.isEmpty) {
                              return 'Password is required';
                            } else
                              return null;
                          },
                        );
                      },
                      selector: (buildContext, provider) =>
                          provider.obscureText),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      ButtonWidget(
                        buttonText:
                            type == AuthType.SignIn ? 'Sign In' : 'Sign Up',
                        fillColor: secondaryColor,
                        textColor: Colors.white,
                        callBack: (){
                          authProvider.onClickOfSignInOrSingUp(type);
                        },
                        textStyle: buttonTextStyle16WhiteColor,
                        buttonStatus: true,
                        borderRadius: 2,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          height: 45,
                          child: FlatButton(
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(2),
                                ),
                                side: BorderSide(color: secondaryColor)),
                            color: white,
                            onPressed: () {
                              authProvider.googleSignIn();
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8),
                              child: Row(
                                children: <Widget>[
                                  Image.asset(
                                    'assets/google_icon.png',
                                    height: 25,
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        type == AuthType.SignIn
                                            ? 'Google Sign In'
                                            : 'Google Sign Up',
                                        style:
                                            textStyle12SecondaryColor,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 25,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  type == AuthType.SignUp
                      ? Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text:
                                        'By Singing up, you are agreeing to our  ',
                                    style: textStyle12BrownishGrey),
                                TextSpan(
                                  text: 'Terms and conditions',
                                  style: textStyle14SecondarySemiBold,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      authProvider.launchWebView(
                                        'Terms & Conditions',
                                        'https://www.modista.co/terms-conditions',
                                      );
                                    },
                                ),
                              ],
                            ),
                          ),
                        )
                      : Container()
                ],
              ),
            ),
          ],
        ),
        Selector<AuthProvider, bool>(
            builder: (context, data, child) {
              return data ? CustomProgressIndicator() : Container();
            },
            selector: (buildContext, provider) =>
                provider.progressIndicatorStatus)
      ],
    );
  }
}
