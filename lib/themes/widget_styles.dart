import 'package:flutter/material.dart';

import 'colors_style.dart';

BoxDecoration mainGradient(){
  return new BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        transform: GradientRotation(0.78),
        colors: [kMainColor, kMainColor_light],
      )
  );
}

BoxDecoration profileGradient(){
  return new BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.centerRight,
        end: Alignment.centerLeft,
        colors: [kMainColor, kMainColor_light],
      )
  );
}

AppBar NoTitleBarWidget({Color backgroundColor = Colors.transparent, Brightness brightness = Brightness.light}) {
  return AppBar(
    toolbarHeight: 0,
    elevation: 0,
    backgroundColor: backgroundColor,
    brightness: brightness,
  );
}

PreferredSize statusGradient(BuildContext context){
  return PreferredSize(
    child: Container(
      child: AppBar(
        toolbarHeight: 0.0,
        backgroundColor: kWhiteColor,
        elevation: 0.0,
      ),
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            transform: GradientRotation(0.78),
            colors: [kMainColor_light,  kMainColor_light],
          )
      ),
    ),
    preferredSize:  Size(MediaQuery.of(context).size.width, 45),
  );
}

Icon backButtonIcon(){
  return Icon(
    Icons.arrow_back_ios_rounded,
    size: 24,
    color: kWhiteColor,
  );
}