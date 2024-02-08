import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_colors.dart';

const font = GoogleFonts.andikaTextTheme;
ThemeData appTheme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.transparent,
    brightness: Brightness.light,
    colorSchemeSeed: primaryColor,
    useMaterial3: true,
    textTheme: font.call(),
    appBarTheme: const AppBarTheme(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0),
    tabBarTheme: TabBarTheme(
      dividerColor: Colors.transparent,
      labelStyle: font.call().displayLarge!.copyWith(color: primaryColor),
      unselectedLabelStyle: font.call().displayMedium,
    ),
  );
}
