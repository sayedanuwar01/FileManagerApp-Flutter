import 'package:filemanagerdx/themes/colors_style.dart';
import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {

  final TextEditingController controller;
  TextInputType keyboardType;
  final TextStyle txtStyle;
  final TextStyle hintStyle;
  final TextStyle labelStyle;
  final bool readOnly;
  final int maxLength;
  final Widget suffixIcon;
  final FocusNode focusNode;
  final Widget countryWidget;
  final Function onTap;
  final Color underLineColor;
  final String hintText;
  final Function onChanged;

  CustomInput(
      {this.controller,
      this.txtStyle,
      this.hintStyle,
      this.labelStyle,
      this.readOnly = false,
      this.keyboardType,
      this.maxLength,
      this.suffixIcon,
      this.focusNode,
      this.countryWidget,
      this.onTap,
      this.underLineColor,
      this.hintText,
      this.onChanged
    });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: onTap,
      controller: controller,
      readOnly: readOnly,
      keyboardType: keyboardType,
      maxLength: maxLength,
      focusNode: focusNode,
      style: txtStyle,
      minLines: 1,
      cursorColor: kTextInputBackColor,
      onChanged: (val){
        onChanged(val);
      },
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintStyle,
        labelStyle: labelStyle,
        prefixIcon: countryWidget,
        suffixIcon: suffixIcon,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: underLineColor,
            width: 1.0,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: underLineColor,
            width: 1.0,
          ),
        ),
      ),

    );
  }
}
