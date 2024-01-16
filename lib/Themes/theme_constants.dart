import 'package:flutter/material.dart';

class ThemeConstants {
  //Color
  static const Color textColor = Color(0xFF2B2B2B);
  static const Color subTextColor = Color(0xFF404040);
  static const Color titleColor = Color(0xFFFFB901);
  static const Color backgroundColor = Color(0xFFFFFFFF);
  static const Color buttonTextColor = Color(0xFFF3D87B);
  static const Color backgroundWidgetColor = Color(0xffffffff);
  static const TextStyle titleStyle = TextStyle(
    fontSize: 30,
    fontFamily: 'Blueberry',
    fontWeight: FontWeight.bold,
    color: titleColor,
  );
//Text
  static const TextStyle textStyleLarge = TextStyle(
    fontSize: 24,
    fontFamily: 'Inter',
    fontWeight: FontWeight.bold,
    color: textColor,
  );

  static const TextStyle textStyleMedium = TextStyle(
    fontSize: 20,
    fontFamily: 'Inter',
    fontWeight: FontWeight.bold,
    color: textColor,
  );

  static const TextStyle textStyleSmall = TextStyle(
    fontSize: 15,
    fontFamily: 'Inter',
    fontWeight: FontWeight.bold,
    color: textColor,
  );

  static const TextStyle buttonStyle = TextStyle(
    fontSize: 18,
    fontFamily: 'Inter',
    fontWeight: FontWeight.bold,
    color: buttonTextColor,
  );

  static const TextStyle storeTitleStyle = TextStyle(
    fontSize: 15,
    fontFamily: 'Tauri',
    fontWeight: FontWeight.bold,
    color: textColor,
  );

  static const TextStyle storeSubtitleStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: subTextColor,
  );
  static const TextStyle cardTitleStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: Color(0xFFFDB700),
  );

  static const TextStyle cardSubtitleStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: Color(0xffffd386),

  );
//default margin
  static const double defaultPadding = 16.0;
  static const double defaultMargin = 16.0;
  static const double borderRadius = 8.0;
}