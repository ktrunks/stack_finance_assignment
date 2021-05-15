import 'package:flutter/material.dart';
import 'package:stack_finance_assignment/util/color/colors.dart';

class CustomErrorWidget extends StatelessWidget {
  final Function onClickOfClose;
  final String errorMessage;

  CustomErrorWidget(this.errorMessage, this.onClickOfClose);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: errorWidgetColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                errorMessage ?? '',
                style: TextStyle(color: white),
                maxLines: 5,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              child: Icon(
                Icons.close, //CloseIcon
                color: white,
              ),
              onTap: () => onClickOfClose(),
            ),
          )
        ],
      ),
    );
  }
}
