import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_flutter_app/src/utils/theme/widget_theme/elevated_button_theme.dart';
import 'package:login_flutter_app/src/utils/theme/widget_theme/outlined_button_theme.dart';
import 'package:login_flutter_app/src/utils/theme/widget_theme/text_formfield_theme.dart';
import 'package:login_flutter_app/src/utils/theme/widget_theme/text_theme.dart';

class MyTheme {
  MyTheme._(); //private bnane k liye

  static ThemeData lighttheme = ThemeData(
    brightness: Brightness.light,
    inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme,
    elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.lightOutlinedButtonTheme,
    textTheme: TTextTheme.lightTextTheme,
    iconTheme: const IconThemeData(color: Colors.white),
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
      TargetPlatform.android: ZoomPageTransitionsBuilder()
    }),
  );

  static ThemeData darktheme = ThemeData(
    // brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme,
    elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.lightOutlinedButtonTheme,
    textTheme: TTextTheme.darkTextTheme,
    iconTheme: const IconThemeData(color: Colors.white),
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
      TargetPlatform.android: ZoomPageTransitionsBuilder()
    }),
  );
}
