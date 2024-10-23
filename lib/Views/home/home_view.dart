import 'package:flutter/material.dart';
import 'package:paysa/Utils/theme/colors.dart';
import 'package:paysa/Views/home/widgets/spending_counter_widget.dart';
import 'package:paysa/Views/home/widgets/transaction_widget.dart';
import 'package:paysa/utils/sizes.dart';
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
    // Get.put(SpendingController());
    // FirestoreAPIs.getCategories();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   updateWidgetUi();
    // });
  }

  @override
  void dispose() {
    super.dispose();
  }

  //widget not showing in home screen
  updateWidgetUi() async {
    // await WidgetsController.update(
    //   context,
    //   SpendingChartWidget(
    //     title: 'Today',
    //     amount: 120,
    //     currency: '\$',
    //     targetAmount: 200,
    //   ),
    //   'SpendingChartWidget',
    // );
    setState(() {});
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
    return Scaffold(
      backgroundColor: PColors.background(context),
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
                    decoration: BoxDecoration(
                      color: PColors.primary(context),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 12,
                        right: 16,
                        top: 8,
                        bottom: 8,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // FirebaseAuth.instance.currentUser!.photoURL == null
                          //     ? CircleAvatar(
                          //         radius: 20,
                          //         backgroundColor: PColors.primaryDark,
                          //         child: Text(
                          //           FirebaseAuth
                          //                   .instance.currentUser!.displayName
                          //                   ?.split(' ')
                          //                   .first[0] ??
                          //               '',
                          //           style: const TextStyle(
                          //             color: PColors.primaryLight,
                          //             fontSize: 20,
                          //             fontWeight: FontWeight.bold,
                          //             fontFamily: 'OpenSans',
                          //           ),
                          //         ),
                          //       )
                          //     : PaysaNetworkImage(
                          //         url: FirebaseAuth
                          //                 .instance.currentUser!.photoURL ??
                          //             'https://i.pinimg.com/564x/98/1d/6b/981d6b2e0ccb5e968a0618c8d47671da.jpg',
                          //         height: 36,
                          //         width: 36,
                          //         borderRadius: BorderRadius.circular(20),
                          //       ),

                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hello,',
                                style: TextStyle(
                                  fontSize: PSize.rw(context, 10) * 0.04, // 16
                                  fontFamily: 'OpenSans',
                                ),
                              ),
                              Text(
                                // FirebaseAuth.instance.currentUser!.displayName
                                //         ?.split(' ')
                                //         .first ??
                                'Hello World',
                                style: TextStyle(
                                  fontSize: PSize.rw(context, 10) * 0.06, // 24
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
                      PColors.primary(context).withOpacity(0.12),
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  onPressed: () {
                    // navigatorKey.currentState!.pushNamed('/settings');
                  },
                  icon: const Text(
                    '🔧 change targets',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
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
                  color: PColors.primaryText(context).withOpacity(0.4),
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
                      fontSize: PSize.rw(context, 10) * 0.06,
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
                        fontSize: PSize.rw(context, 10) * 0.04,
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
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     navigatorKey.currentState!.pushNamed('/spending-numpad');
      //   },
      //   backgroundColor: PColors.bottomNavItemActive(context),
      //   child: const Icon(
      //     Icons.add,
      //     color: Colors.white,
      //   ),
      // ),
    );
  }
}
