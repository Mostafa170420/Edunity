import 'package:flutter/widgets.dart';

class TextStyles {
  static TextStyle getTitle(
      {double? fontSize, Color? color, FontWeight? fontWeight}) {
    return TextStyle(
        fontSize: fontSize ?? 30, color: color, fontWeight: fontWeight);
  }

  static TextStyle getBody(
      {double? fontSize, Color? color, FontWeight? fontWeight}) {
    return TextStyle(
        fontSize: fontSize ?? 24, color: color, fontWeight: fontWeight);
  }

  static TextStyle getSmall(
      {double? fontSize, Color? color, FontWeight? fontWeight}) {
    return TextStyle(
        fontSize: fontSize ?? 18, color: color, fontWeight: fontWeight);
  }
}
