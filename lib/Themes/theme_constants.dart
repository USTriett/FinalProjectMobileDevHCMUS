

import 'package:flutter/material.dart';

class ThemeConstants {
  //Color
  static const Color primaryColor = Color(0xFFFE3C72);
  static const Color secondaryColor = Color(0xFF2B2B2B);
  static const Color textColor = Color(0xFF404040);
  static const Color backgroundColor = Color(0xFFFE3C72);
  static const Color cardColor = Color(0xFFFFFFFF);
  static const Color backgroundWidgetColor = Color(0xffffffff);
  static const TextStyle titleStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: textColor,
  );
//Text
  static const TextStyle subtitleStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: textColor,
  );

  static const TextStyle buttonStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: textColor,
  );

  static const TextStyle cardTitleStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: secondaryColor,
  );

  static const TextStyle cardSubtitleStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: secondaryColor,
  );
//default margin
  static const double defaultPadding = 16.0;
  static const double defaultMargin = 16.0;
  static const double borderRadius = 8.0;
}