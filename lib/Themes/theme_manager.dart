
import 'package:flutter/material.dart';
import 'package:next_food/Themes/theme_constants.dart';

class ThemeManager {
  static ThemeData getThemeData() {
    // You can customize and return your desired theme data here
    return ThemeData(
      scaffoldBackgroundColor: ThemeConstants.backgroundColor,
      primaryColor: ThemeConstants.primaryColor,
      backgroundColor: ThemeConstants.backgroundColor,
      cardColor: ThemeConstants.cardColor,
      textTheme: const TextTheme(
        headline1: ThemeConstants.titleStyle,
        headline2: ThemeConstants.subtitleStyle,
        button: ThemeConstants.buttonStyle,
        subtitle1: ThemeConstants.cardTitleStyle,
        subtitle2: ThemeConstants.cardSubtitleStyle,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(ThemeConstants.backgroundWidgetColor),
          foregroundColor: MaterialStateProperty.all<Color>(ThemeConstants.textColor),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(const Color(0xffeec1df)),

        )
      )
    );
  }
}