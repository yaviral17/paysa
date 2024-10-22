import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class TChipTheme {
  TChipTheme._();

  static ChipThemeData lightChipTheme = ChipThemeData(
    disabledColor: PColors.grey.withOpacity(0.4),
    labelStyle: const TextStyle(color: PColors.black),
    selectedColor: PColors.primary,
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    checkmarkColor: PColors.white,
  );

  static ChipThemeData darkChipTheme = const ChipThemeData(
    disabledColor: PColors.darkerGrey,
    labelStyle: TextStyle(color: PColors.white),
    selectedColor: PColors.primary,
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    checkmarkColor: PColors.white,
  );
}
