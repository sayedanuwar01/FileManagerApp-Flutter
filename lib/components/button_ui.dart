
import 'package:filemanagerdx/themes/colors_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget{

  final double width;
  final String title;
  final Color buttonColor;
  final Color borderColor;
  final TextStyle txtStyle;
  final Function onTap;

  CustomButton({
    this.width,
    this.title,
    this.onTap,
    this.txtStyle,
    this.buttonColor = kMainColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 48,
      child: RaisedButton(
        child: Text(title, style: txtStyle,),
        color: buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(color: borderColor?? kYellowColor)
        ),
        focusColor: kYellowColor,
        autofocus: true,
        onPressed: onTap,
      ),
    );
  }
}