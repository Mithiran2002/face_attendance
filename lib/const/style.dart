import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class CustomTextStyles {
  TextStyle primary( 
      {double? fontSize,
      FontWeight? fontWeight,
      Color? color,
      double? letterSpacing,
      double? height,
      TextDecoration? decoration}) {
    return GoogleFonts.nunito(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
      decoration: decoration,
    );
  }

  TextStyle secondary(
      {double? fontSize,
      FontWeight? fontWeight,
      Color? color,
      double? letterSpacing,
      double? height,
      TextDecoration? decoration}) {
    return GoogleFonts.lato(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
      decoration: decoration,
    );
  }
}
