import 'package:flutter/material.dart';

class AppTheme {
  static final themeLight = ThemeData.light().copyWith(
    //selected color
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.orange,
      foregroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.white),
    ),

    toggleableActiveColor: Colors.white,
    //canvasColor: backgroundLightColor,
    colorScheme: ColorScheme.fromSwatch()
        .copyWith(secondary: Colors.white, primary: Colors.orange),
    focusColor: Colors.orange,
  );
}
