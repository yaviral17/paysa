import 'package:flutter/material.dart';

class CurrencyText extends StatelessWidget {
  final String currency;
  final double amount;
  final String convertTo;
  final bool showCurrency;
  final bool ignoreConvertTo;
  final bool showDecimal;
  final bool showComma;
  final TextStyle? style;

  const CurrencyText({
    super.key,
    this.currency = '₹',
    this.amount = 0,
    this.convertTo = 'USD',
    this.showCurrency = true,
    this.ignoreConvertTo = false,
    this.showDecimal = true,
    this.showComma = true,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      '${showCurrency ? currency : ''}${showComma ? amount.toStringAsFixed(2) : amount.toString()}${showDecimal ? '.00' : ''}',
      style: style,
    );
  }
}
