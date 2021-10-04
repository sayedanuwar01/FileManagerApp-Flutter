import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors_style.dart';

// Abel font bold style
TextStyle abelStyleBold(){
  return GoogleFonts.abel().copyWith(fontSize: 24, color: kWhiteColor, fontWeight: FontWeight.bold);
}

// Abel font bold style
TextStyle abelStyleMedium(){
  return GoogleFonts.abel().copyWith(fontSize: 24, color: kWhiteColor, fontWeight: FontWeight.w500);
}

// Abel font bold style
TextStyle abelStyleNormal(){
  return GoogleFonts.abel().copyWith(fontSize: 24, color: kWhiteColor, fontWeight: FontWeight.w400);
}

// Gilroy font bold style
TextStyle gilroyStyleBold(){
  return TextStyle(
    fontSize: 24,
    color: kWhiteColor,
    fontFamily: 'Gilroy_Bold'
  );
}

// Gilroy font bold style
TextStyle gilroyStyleMedium(){
  return TextStyle(
      fontSize: 24,
      color: kWhiteColor,
      fontFamily: 'Gilroy_Medium',
      fontWeight: FontWeight.w500
  );
}

// Gilroy font bold style
TextStyle gilroyStyleRegular(){
  return TextStyle(
      fontSize: 24,
      color: kWhiteColor,
      fontFamily: 'Gilroy_Regular'
  );
}