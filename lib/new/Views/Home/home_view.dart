import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paysa/main.dart';
import 'package:paysa/new/Controllers/spending_controller.dart';
import 'package:paysa/new/api/firestore_apis.dart';
import 'package:paysa/utils/constants/colors.dart';
import 'package:paysa/utils/constants/sizes.dart';
import 'package:paysa/utils/helpers/helper_functions.dart';
import 'package:paysa/utils/widgets/cachedNetworkImageWidget.dart';
import 'package:smooth_corner/smooth_corner.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.put(SpendingController());
    FirestoreAPIs.getCategories();
  }

  final ValueNotifier<double> _valueNotifierToday = ValueNotifier(40);
  final ValueNotifier<double> _valueNotifierMonth = ValueNotifier(20);

  List<Widget> transactions = const [
    TransactionWidget(
      emoji: '🍔',
      title: 'Food',
      subtitle: 'McDonalds',
      amount: '10.00',
    ),
    TransactionWidget(
      emoji: '🚗',
      title: 'Transport',
      subtitle: 'Uber',
      amount: '20.00',
      isReceived: true,
    ),
    TransactionWidget(
      emoji: '🛒',
      title: 'Groceries',
      subtitle: 'Walmart',
      amount: '30.00',
    ),
    TransactionWidget(
      emoji: '🎁',
      title: 'Gift',
      subtitle: 'Amazon',
      amount: '40.00',
      isReceived: true,
    ),
    TransactionWidget(
      emoji: '🎮',
      title: 'Games',
      subtitle: 'Steam',
      amount: '50.00',
    ),
    TransactionWidget(
      emoji: '🎟',
      title: 'Movies',
      subtitle: 'Cineplex',
      amount: '60.00',
      isReceived: true,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: TColors.background(context),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // hello header
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                SmoothClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  smoothness: 0.8,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: TColors.primary,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FirebaseAuth.instance.currentUser!.photoURL == null
                              ? CircleAvatar(
                                  radius: 20,
                                  backgroundColor: TColors.primaryDark,
                                  child: Text(
                                    FirebaseAuth
                                            .instance.currentUser!.displayName
                                            ?.split(' ')
                                            .first[0] ??
                                        '',
                                    style: const TextStyle(
                                      color: TColors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'OpenSans',
                                    ),
                                  ),
                                )
                              : PaysaNetworkImage(
                                  url: FirebaseAuth
                                          .instance.currentUser!.photoURL ??
                                      'https://i.pinimg.com/564x/98/1d/6b/981d6b2e0ccb5e968a0618c8d47671da.jpg',
                                  height: 36,
                                  width: 36,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Hello,',
                                style: TextStyle(
                                  color: TColors.white,
                                  fontSize: 14,
                                  fontFamily: 'OpenSans',
                                ),
                              ),
                              Text(
                                FirebaseAuth.instance.currentUser!.displayName
                                        ?.split(' ')
                                        .first ??
                                    '',
                                style: const TextStyle(
                                  color: TColors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'OpenSans',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                IconButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      TColors.white.withOpacity(0.12),
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  onPressed: () {
                    navigatorKey.currentState!.pushNamed('/settings');
                  },
                  icon: const Text(
                    '🔧 change targets',
                    style: TextStyle(
                      color: TColors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'OpenSans',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            // Today and Month Spending
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SpendingCounter(
                  title: 'Today',
                  amount: 181.39,
                  currency: '\$',
                  targetAmount: 200,
                ),
                Container(
                  height: 50,
                  width: 2,
                  color: TColors.textSecondary.withOpacity(0.4),
                ),
                const SpendingCounter(
                  title: 'Month',
                  amount: 181.39,
                  currency: '\$',
                  targetAmount: 200,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            // Spending Categories
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Row(
                children: [
                  Text(
                    "Transactions",
                    style: TextStyle(
                      color: TColors.white,
                      fontSize: TSizes.displayWidth(context) * 0.05,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'OpenSans',
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "See all",
                      style: TextStyle(
                        color: TColors.white,
                        fontSize: TSizes.displayWidth(context) * 0.04,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  return transactions[index];
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigatorKey.currentState!.pushNamed('/spending-numpad');
        },
        backgroundColor: TColors.bottomNavItemActive(context),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

class TransactionWidget extends StatelessWidget {
  final String emoji;
  final String title;
  final String subtitle;
  final String amount;
  final bool isReceived;
  const TransactionWidget({
    super.key,
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.amount,
    this.isReceived = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: TColors.white.withOpacity(0.1),
        child: Center(
          child: Text(
            emoji,
            style: const TextStyle(
              color: TColors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
            ),
          ),
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: TColors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: 'OpenSans',
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          color: TColors.textSecondary,
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: 'OpenSans',
        ),
      ),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: TColors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          isReceived ? '+ \$$amount' : '- \$$amount',
          style: TextStyle(
            color: isReceived ? TColors.success : TColors.error,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }
}

class SpendingCounter extends StatelessWidget {
  final String title;
  final double amount;
  final String currency;
  final double targetAmount;

  const SpendingCounter({
    super.key,
    this.title = 'Today',
    this.amount = 181.39,
    this.currency = '\$',
    this.targetAmount = 200,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: TColors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
      ),
      width: TSizes.displayWidth(context) * 0.4,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          PaysaCircleProgressWidget(
            size: TSizes.displayWidth(context) * 0.14,
            value: 40,
            targetValue: 100,
          ),
          SizedBox(
            width: TSizes.displayWidth(context) * 0.02,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: TColors.white,
                  fontSize: TSizes.displayWidth(context) * 0.05,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '$currency${amount.toInt()}',
                    style: TextStyle(
                      color: TColors.white,
                      fontSize: TSizes.displayWidth(context) * 0.042,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'OpenSans',
                    ),
                  ),
                  Text(
                    ".${amount.toString().split('.').last.padRight(2, '0')}",
                    style: TextStyle(
                      color: TColors.white,
                      fontSize: TSizes.displayWidth(context) * 0.04,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'OpenSans',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PaysaCircleProgressWidget extends StatelessWidget {
  final double size;
  final double value;
  final double targetValue;

  const PaysaCircleProgressWidget({
    super.key,
    this.size = 100,
    this.targetValue = 100,
    this.value = 0,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return SizedBox(
      width: size,
      height: size,
      child: DashedCircularProgressBar.aspectRatio(
        aspectRatio: 1, // width ÷ height
        valueNotifier: ValueNotifier(value),
        progress: value,
        maxProgress: targetValue,
        corners: StrokeCap.butt,
        foregroundColor: TColors.primary,
        backgroundColor: isDark
            ? TColors.white.withOpacity(0.1)
            : TColors.black.withOpacity(0.1),
        foregroundStrokeWidth: 12,
        backgroundStrokeWidth: 8,
        seekColor: TColors.primary,

        circleCenterAlignment: Alignment.center,
        seekSize: 0,
        backgroundDashSize: 0,
        animation: true,
        // child: Center(
        //   child: ValueListenableBuilder(
        //     valueListenable: valueNotifier,
        //     builder: (_, double value, __) => Text(
        //       '${value.toInt()}%',
        //       style: const TextStyle(
        //           color: Colors.black,
        //           fontWeight: FontWeight.w300,
        //           fontSize: 60),
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
