import 'package:flutter/material.dart';
import 'package:paysa/utils/constants/colors.dart';

class TransactionView extends StatefulWidget {
  const TransactionView({super.key});

  @override
  State<TransactionView> createState() => _TransactionViewState();
}

class _TransactionViewState extends State<TransactionView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PColors.background(context),
      body: const Column(
        children: [],
      ),
    );
  }
}
