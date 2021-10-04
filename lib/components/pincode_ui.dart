import 'package:filemanagerdx/themes/colors_style.dart';
import 'package:filemanagerdx/themes/texts_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinCodeUI extends StatelessWidget{

  TextEditingController txt_sms_code;
  Function completeCallback;
  Function changeCallback;

  PinCodeUI({
    this.completeCallback,
    this.changeCallback
  });

  @override
  Widget build(BuildContext context) {
    txt_sms_code = TextEditingController();

    return PinCodeTextField(
      appContext: context,
      controller: txt_sms_code,
      length: 6,
      obscureText: false,
      cursorColor: kMainTextColor,
      textStyle: abelStyleBold().copyWith(fontSize: 20, color: kMainTextColor),
      keyboardType: TextInputType.number,
      animationType: AnimationType.fade,
      backgroundColor: Colors.transparent,
      animationDuration: Duration(milliseconds: 300),
      autoFocus: true,
      onCompleted: (pin) {
        completeCallback(pin);
      },
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(8),
        fieldHeight: 44,
        fieldWidth: 40,
        activeColor: kWhiteColor,
        selectedColor: kWhiteColor,
        inactiveColor: kWhiteColor,
        disabledColor: Colors.grey,
        activeFillColor: kWhiteColor,
        selectedFillColor: kWhiteColor,
        inactiveFillColor: kWhiteColor,
      ),
      boxShadows: [BoxShadow(
        offset: Offset(0, 0),
        color: kWhiteColor,
        blurRadius: 1,
      )
      ],
      onChanged: (String value) {
        changeCallback(value);
      },
    );
  }
}