import 'package:filkop_mobile_apps/view/theme/style.dart';
import 'package:flutter/material.dart';
class PrimaryButton extends StatelessWidget {
  final String label;
  final EdgeInsetsGeometry margin;
  final Function onPressed;
  final double width;
  PrimaryButton({this.label, this.margin, this.onPressed, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: margin,
      child: RaisedButton(
        onPressed: (){
          onPressed();
        },
        color: Style.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          style: TextStyle(color: Style.primaryTextColor),
        ),
      ),
    );
  }
}
