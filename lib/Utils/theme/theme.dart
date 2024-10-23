import 'package:flutter/material.dart';
import 'package:paysa/Utils/theme/colors.dart';

class PAppTheme {
  PAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'OpenSans',
    disabledColor: PColors.secondaryTextLight,
    brightness: Brightness.light,
    primaryColor: PColors.primaryLight,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'OpenSans',
    disabledColor: PColors.secondaryTextDark,
    brightness: Brightness.dark,
    primaryColor: PColors
        .primaryLight, // this should be primaryDark but for we keeping the same light color for primary
  );
}
