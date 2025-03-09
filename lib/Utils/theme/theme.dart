import 'package:flutter/material.dart';
import 'package:paysa/Utils/theme/colors.dart';

class PAppTheme {
  PAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Inter',
    disabledColor: PColors.secondaryTextLight,
    brightness: Brightness.light,
    primaryColor: PColors.primaryLight,
    scaffoldBackgroundColor: PColors.backgroundLight,
    appBarTheme: const AppBarTheme(
      backgroundColor: PColors.backgroundLight,
      elevation: 0,
      iconTheme: IconThemeData(color: PColors.primaryTextLight),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Inter',
    disabledColor: PColors.secondaryTextDark,
    brightness: Brightness.dark,
    primaryColor: PColors
        .primaryLight, // this should be primaryDark but for we keeping the same light color for primary
    scaffoldBackgroundColor: PColors.backgroundDark,
    appBarTheme: const AppBarTheme(
      backgroundColor: PColors.backgroundDark,
      elevation: 0,
      iconTheme: IconThemeData(color: PColors.primaryTextDark),
    ),
  );
}
