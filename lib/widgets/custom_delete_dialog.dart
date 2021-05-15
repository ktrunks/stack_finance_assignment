import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stack_finance_assignment/util/color/colors.dart';
import 'package:stack_finance_assignment/util/style/style.dart';
import 'package:stack_finance_assignment/widgets/button_widget.dart';

class CustomDeleteDialogBox extends StatefulWidget {
  void Function(Object, Object) onClickOfDelete;

  void Function() onClickCancel;

  Object listData;

  Object data;

  CustomDeleteDialogBox(
      {Key key,
      this.onClickCancel,
      this.onClickOfDelete,
      this.data,
      this.listData}) {
    debugPrint('data --- ${data}');
  }

  @override
  _CustomDeleteDialogBoxState createState() => _CustomDeleteDialogBoxState();
}

class _CustomDeleteDialogBoxState extends State<CustomDeleteDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Container(
      padding: EdgeInsets.only(top: 20, bottom: 20),
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
          ]),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('SF Assignment', style: textStyle14BlackColor),
          const SizedBox(
            height: 10,
          ),
          Text('Are you sure you want delete',
              style: textStyle14BlackColor),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                ButtonWidget(
                  buttonText: 'Cancel',
                  fillColor: primaryColor,
                  textColor: Colors.white,
                  callBack: onClickOfCancel,
                  textStyle: buttonTextStyle16WhiteColor,
                  buttonStatus: true,
                  borderRadius: 2,
                ),
                const SizedBox(
                  width: 10,
                ),
                ButtonWidget(
                  buttonText: 'Delete',
                  fillColor: primaryColor,
                  textColor: Colors.white,
                  callBack: onClickOfDelete,
                  textStyle: buttonTextStyle16WhiteColor,
                  buttonStatus: true,
                  borderRadius: 2,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void onClickOfCancel() {
    Navigator.pop(context);
  }

  void onClickOfDelete() {
    Navigator.pop(context);
    widget.onClickOfDelete(widget.data, widget.listData);
  }
}
