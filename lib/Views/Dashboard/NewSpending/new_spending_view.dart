import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:paysa/Controllers/new_spending_controller.dart';
import 'package:paysa/Utils/sizes.dart';
import 'package:paysa/Utils/theme/colors.dart';
import 'package:paysa/Views/auth/widgets/paysa_primary_button.dart';
import 'package:smooth_corner/smooth_corner.dart';

class NewSpendingView extends StatefulWidget {
  const NewSpendingView({super.key});

  @override
  State<NewSpendingView> createState() => _NewSpendingViewState();
}

class _NewSpendingViewState extends State<NewSpendingView> {
  List<String> buttons = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '000',
    '0',
    '⇦'
  ];

  void onButtonPressed(String buttonText) {}

  final NewSpendingController newSpendingController = NewSpendingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: PSize.arw(context, 16),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Obx(
          () => Text(
            newSpendingController.spendingMode.value,
            style: TextStyle(
              fontSize: PSize.arw(context, 18),
              color: PColors.primaryText(context),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Obx(
            () => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Spacer(),
                  TransactionModeWidget(
                    label: 'Shopping',
                    icon: HugeIcons.strokeRoundedShoppingBasket03,
                    isActive:
                        newSpendingController.spendingMode.value == 'Shopping',
                    onTap: () {
                      newSpendingController.spendingMode.value = 'Shopping';
                    },
                  ),
                  Spacer(),
                  TransactionModeWidget(
                    label: 'Fund Transfer',
                    icon: HugeIcons.strokeRoundedTransaction,
                    isActive: newSpendingController.spendingMode.value ==
                        'Fund Transfer',
                    onTap: () {
                      newSpendingController.spendingMode.value =
                          'Fund Transfer';
                    },
                  ),
                  Spacer(),
                  TransactionModeWidget(
                    label: 'Bill Split',
                    icon: HugeIcons.strokeRoundedUserGroup,
                    isActive: newSpendingController.spendingMode.value ==
                        'Bill Split',
                    onTap: () {
                      newSpendingController.spendingMode.value = 'Bill Split';
                    },
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
          const Spacer(),
          // money input
          Text(
            '₹ 0.00',
            style: TextStyle(
              fontSize: PSize.arw(context, 63),
              color: PColors.primaryText(context),
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          SmoothContainer(
            width: PSize.displayWidth(context),
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            color: PColors.containerSecondary(context),
            borderRadius: BorderRadius.circular(16),
            smoothness: 0.8,
            child: Row(
              children: [
                Icon(
                  HugeIcons.strokeRoundedCreditCard,
                  size: PSize.arw(context, 45),
                ),
                SizedBox(
                  width: PSize.arw(context, 8),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'HDFC Bank',
                      style: TextStyle(
                        fontSize: PSize.arw(context, 14),
                        color: PColors.primaryText(context),
                      ),
                    ),
                    Text(
                      'Balance: ₹ 98,468.90',
                      style: TextStyle(
                        fontSize: PSize.arw(context, 12),
                        color: PColors.secondaryText(context),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PColors.primary(context),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    minimumSize: Size(
                      PSize.arw(context, 54),
                      PSize.arh(context, 42),
                    ),
                  ),
                  child: Text(
                    'Change',
                    style: TextStyle(
                      fontSize: PSize.arw(context, 14),
                      color: PColors.primaryText(context),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SmoothContainer(
              width: PSize.displayWidth(context),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 2.2,
                  mainAxisSpacing: 6,
                  crossAxisSpacing: 4,
                ),
                shrinkWrap: true,
                itemCount: buttons.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    borderRadius: BorderRadius.circular(100),
                    splashColor: PColors.primary(context).withOpacity(0.2),
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        color: buttons[index] == '⇦'
                            ? PColors.error
                            : buttons[index] == '000'
                                ? PColors.primaryTextDark
                                : PColors.containerSecondary(context),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      height: PSize.arh(context, 100),
                      width: PSize.arw(context, 100),
                      child: Center(
                        child: buttons[index] == '⇦'
                            ? Icon(
                                Icons.backspace_rounded,
                                size: PSize.arw(context, 20),
                                color: PColors.primaryText(context),
                              )
                            : Text(
                                buttons[index],
                                style: TextStyle(
                                  fontSize: PSize.arw(context, 20),
                                  color: buttons[index] == '000'
                                      ? PColors.primaryTextLight
                                      : PColors.primaryText(context),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: PaysaPrimaryButton(
              text: 'Add Transaction',
              onTap: () {},
              textColor: PColors.primaryText(context),
            ),
          ),
          SizedBox(
            height: PSize.arh(
              context,
              8,
            ),
          ),
        ],
      ),
    );
  }
}

class TransactionModeWidget extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isActive;
  final void Function()? onTap;

  const TransactionModeWidget({
    super.key,
    this.label = 'Shopping',
    this.icon = HugeIcons.strokeRoundedShoppingBasket03,
    this.isActive = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 8,
        ),
        decoration: BoxDecoration(
          color: isActive
              ? PColors.containerSecondary(context)
              : PColors.transparent,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: PColors.primary(context),
              radius: PSize.arw(context, 24),
              child: Icon(
                icon,
                color: PColors.primaryText(context),
              ),
            ),
            Visibility(
              visible: isActive,
              child: SizedBox(
                width: PSize.arw(context, 8),
              ),
            ),
            Visibility(
              visible: isActive,
              child: Text(
                label,
                style: TextStyle(
                  fontSize: PSize.arw(context, 14),
                  color: PColors.primaryText(context),
                ),
              ),
            ),
            Visibility(
              visible: isActive,
              child: SizedBox(
                width: PSize.arw(context, 8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
