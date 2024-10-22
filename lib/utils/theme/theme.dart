import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:paysa/utils/theme/widget_themes/appbar_theme.dart';
import 'package:paysa/utils/theme/widget_themes/bottom_sheet_theme.dart';
import 'package:paysa/utils/theme/widget_themes/checkbox_theme.dart';
import 'package:paysa/utils/theme/widget_themes/chip_theme.dart';
import 'package:paysa/utils/theme/widget_themes/elevated_button_theme.dart';
import 'package:paysa/utils/theme/widget_themes/outlined_button_theme.dart';
import 'package:paysa/utils/theme/widget_themes/text_field_theme.dart';
import 'package:paysa/utils/theme/widget_themes/text_theme.dart';

import '../constants/colors.dart';

class PAppTheme {
  PAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'OpenSans',
    disabledColor: PColors.grey,
    brightness: Brightness.light,
    primaryColor: PColors.primary,
    textTheme: TTextTheme.lightTextTheme,
    chipTheme: TChipTheme.lightChipTheme,
    colorScheme: const ColorScheme.light(primary: PColors.primary),
    scaffoldBackgroundColor: PColors.white,
    appBarTheme: TAppBarTheme.lightAppBarTheme,
    checkboxTheme: TCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: TBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    primaryColor: PColors.primary,
    fontFamily: 'OpenSans',
    disabledColor: PColors.grey,
    brightness: Brightness.dark,
    textTheme: TTextTheme.darkTextTheme,
    chipTheme: TChipTheme.darkChipTheme,
    scaffoldBackgroundColor: PColors.dark,
    colorScheme: const ColorScheme.dark(primary: PColors.primary),
    appBarTheme: TAppBarTheme.darkAppBarTheme,
    checkboxTheme: TCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: TBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.darkInputDecorationTheme,
  );
}
