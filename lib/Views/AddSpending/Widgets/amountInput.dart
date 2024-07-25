import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Controllers/AddSpendingController.dart';
import '../../../utils/constants/colors.dart';

class AmountInput extends StatefulWidget {
  const AmountInput({super.key});

  @override
  State<AmountInput> createState() => _AmountInputState();
}

class _AmountInputState extends State<AmountInput> {
  PageController pageController = PageController();
  AddSpendingController addSpendingController =
      Get.put(AddSpendingController());
  final TextEditingController splitMemberEmail = TextEditingController();
  final TextEditingController splitAmount = TextEditingController();
  final TextEditingController comments = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Total amount',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.w300),
          ),
          TextField(
            controller: splitAmount,
            keyboardType: TextInputType.number,
            style: const TextStyle(
              color: TColors.textWhite,
              fontSize: 30,
            ),
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintText: '0',
              fillColor: Colors.transparent,
              hintStyle: TextStyle(
                color: TColors.textWhite.withOpacity(0.5),
                fontSize: 30,
              ),
              focusedBorder: InputBorder.none,
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: TextField(
              controller: comments,
              keyboardType: TextInputType.text,
              style: const TextStyle(
                color: TColors.textWhite,
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                filled: true,
                hintText: 'What is this for?',
                fillColor: Colors.grey.withOpacity(0.2),
                hintStyle: TextStyle(
                  color: TColors.textWhite.withOpacity(0.5),
                  fontSize: 15,
                ),
                focusedBorder: InputBorder.none,
                // border: InputBorder.none,
                enabledBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
