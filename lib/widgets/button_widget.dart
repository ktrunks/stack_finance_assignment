import 'package:flutter/material.dart';
import 'package:stack_finance_assignment/util/color/colors.dart';

class ButtonWidget extends StatelessWidget {
  ButtonWidget(
      {@required this.callBack,
      @required this.buttonText,
      @required this.fillColor,
      @required this.textColor,
      @required this.textStyle,
      this.buttonStatus,
      this.borderRadius});

  final Function callBack;
  final String buttonText;
  final Color fillColor;
  final Color textColor;
  final TextStyle textStyle;
  final bool buttonStatus;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: borderRadius != null
                  ? BorderRadius.circular(borderRadius)
                  : BorderRadius.circular(0)),
          onPressed:
              buttonStatus != null && buttonStatus ? () => callBack() : null,
          color: secondaryColor,
          disabledColor: cardBorder,
          disabledTextColor: Colors.red,
          child: Container(
              height: 45,
              child: Center(
                  child: Text(buttonText.toUpperCase(), style: textStyle))),
        ),
      ),
    );
  }
}
