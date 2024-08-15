import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:paysa/Config/FirestoreRefrence.dart';
import 'package:paysa/Models/DailySpendingModel.dart';
import 'package:paysa/Models/SplitModel.dart';
import 'package:paysa/Models/UserModel.dart';
import 'package:paysa/Views/AddSpending/AddSpending.dart';
import 'package:paysa/utils/constants/colors.dart';
import 'package:paysa/utils/constants/sizes.dart';
import 'package:paysa/utils/helpers/helper_functions.dart';

class DailySpendingScreen extends StatefulWidget {
  const DailySpendingScreen({super.key});

  @override
  State<DailySpendingScreen> createState() => _DailySpendingScreenState();
}

class _DailySpendingScreenState extends State<DailySpendingScreen> {
  RxList<DailySpendingModel> dailySpendings = <DailySpendingModel>[].obs;
  RxList<String> days = <String>[].obs;
  final ScrollController _scrollController = ScrollController();
  GlobalKey? _refreshScreenKey = GlobalKey();
  RxBool canRefresh = false.obs;
  @override
  void initState() {
    super.initState();
    _fetchData();
    Future.delayed(const Duration(seconds: 3), () {
      canRefresh.value = true;
    });
    // refresh screen on fling down of _scrollController
    // _scrollController.addListener(() {
    //   if (_scrollController.position.atEdge) {
    //     if (_scrollController.position.pixels == 0) {
    //       // You're at the top.
    //       log('You\'re at the top.');
    //       _refreshScreen();
    //     } else {
    //       // You're at the bottom.
    //       log('You\'re at the bottom.');
    //     }
    //   }
    // });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant DailySpendingScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  void navigateAndRefresh() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const AddDailySpendingScreen(fromEdit: false)),
    );

    // Refresh data when user comes back from the new screen
    _fetchData();
  }

  Future<List<DailySpendingModel>> _fetchData() async {
    List<DailySpendingModel> dataList = [];
    List<String> sessionIds = await FireStoreRef.getSessionIdsList();
    log(sessionIds.toString());
    List<Map<String, dynamic>> lst = await FireStoreRef.getMyDailySpendings();
    log(lst.toString());
    for (Map<String, dynamic> item in lst) {
      if (item['isSplit']) {
        Map<String, dynamic> splitData =
            await FireStoreRef.getSplitDataById(item['id']) ?? {};
        log(splitData.toString());
        dataList.add(DailySpendingModel.fromJson(splitData));
        continue;
      }
      log(item.toString());
      dataList.add(DailySpendingModel.fromJson(item));
    }
    dataList.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    dailySpendings.value = dataList;
    return dataList;
  }

  double _getTotalAmmountByDateTime(String time) {
    double total = 0;
    for (DailySpendingModel spending in dailySpendings) {
      if (THelperFunctions.getDayDifference(spending.timestamp) == time) {
        if (spending.isSplit) {
          double mySplit = 0;
          for (Split split in spending.splits!) {
            if (split.uid == FirebaseAuth.instance.currentUser!.uid) {
              mySplit = split.amount;
            }
          }
          total += mySplit;
        } else {
          total += spending.amount;
        }
      }
    }
    return total;
  }

  _refreshScreen() {
    // rebuild widget of _refreshScreenKey
    setState(() {
      _refreshScreenKey = GlobalKey();
    });
    canRefresh.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.small(
        onPressed: () => Get.to(() => const AddDailySpendingScreen(fromEdit: false),
            transition: Transition.rightToLeftWithFade),
        child: const Icon(Icons.add),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            key: _refreshScreenKey,
            controller: _scrollController,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Refresh button

                // Chart of last 7 days spending using FlChart
                Obx(() => Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 12),
                      child: Ink(
                          decoration: BoxDecoration(
                            color: TColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: BarChartSample1(
                              dailySpendings: dailySpendings.value)),
                    )),
                FutureBuilder(
                  future: _fetchData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Text('Something went wrong ${snapshot.error}');
                    }
                    if (snapshot.data!.isEmpty) {
                      return const Text('No Daily Spendings');
                    }

                    return GroupedListView(
                      shrinkWrap: true,
                      elements: snapshot.requireData,
                      groupBy: (element) =>
                          THelperFunctions.getDayDifference(element.timestamp),
                      itemBuilder: (context, element) {
                        return spendingInfoTile(element);
                      },
                      sort: false,
                      groupSeparatorBuilder: (element) {
                        return Container(
                          padding: const EdgeInsets.only(
                            top: 10,
                            bottom: 10,
                            left: 12,
                            right: 12,
                          ),
                          margin: const EdgeInsets.only(
                            top: 0,
                            bottom: 0,
                            left: 12,
                            right: 12,
                          ),
                          decoration: BoxDecoration(
                            color: TColors.grey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                element,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              Text(
                                "₹ ${_getTotalAmmountByDateTime(element)}",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ],
                          ),
                        );
                      },
                    );

                    // ListView.builder(
                    //   itemCount: snapshot.requireData.length,
                    //   itemBuilder: (context, index) {
                    //     return DailySpendingWidget(snapshot.requireData[index]);
                    //   },
                    // );
                  },
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: _refreshScreen,
            child: Align(
              alignment: Alignment.topCenter,
              child: Obx(
                () => AnimatedContainer(
                  margin: EdgeInsets.only(top: canRefresh.value ? 10 : 0),
                  padding: EdgeInsets.all(canRefresh.value ? 10 : 0),
                  duration: const Duration(milliseconds: 500),
                  height: canRefresh.value ? 36 : 0,
                  width: canRefresh.value ? 90 : 0,
                  decoration: BoxDecoration(
                    color: TColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: FittedBox(
                    child: Row(
                      children: [
                        Text(
                          'Refresh ',
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const Icon(Icons.refresh),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  spendingInfoTile(DailySpendingModel dailySpending) {
    return Container(
      width: TSizes.displayWidth(context),
      margin: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 12,
      ),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: TColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: TSizes.displayWidth(context) * 0.063,
                backgroundImage: AssetImage(
                  'assets/expanses_category_icons/ic_${dailySpending.category}.png',
                ),
              ),
              SizedBox(width: TSizes.displayWidth(context) * 0.05),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dailySpending.title.capitalizeFirst ?? "No Title",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    dailySpending.description.capitalizeFirst ??
                        "No Description",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "₹ ${dailySpending.amount}",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    THelperFunctions.formateDateTime(
                        dailySpending.timestamp, 'h:mm a'),
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                  ),
                ],
              ),
            ],
          ),

          // if (dailySpending.isSplit)

          if (dailySpending.isSplit)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                ...List.generate(dailySpending.splits!.length, (index) {
                  return FutureBuilder(
                    future: FireStoreRef.getuserByUid(
                        dailySpending.splits![index].uid),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 4, horizontal: 12),
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (snapshot.hasError) {
                        return const Center(
                          child: Text('Error fetching data'),
                        );
                      }

                      UserModel user = UserModel.fromJson(snapshot.requireData);

                      return usertagTile(user, dailySpending, index);
                    },
                  );
                }),
              ],
            ),
        ],
      ),
    );
  }

  Padding usertagTile(
      UserModel user, DailySpendingModel dailySpending, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      child: Ink(
        // height: TSizes.displayWidth(context) * 0.1,
        padding: const EdgeInsets.all(4),
        width: TSizes.displayWidth(context) * 0.4,
        decoration: BoxDecoration(
          color: TColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (user.profile.isNotEmpty)
              CircleAvatar(
                radius: TSizes.displayWidth(context) * 0.036,
                backgroundImage: NetworkImage(user.profile),
              ),
            SizedBox(width: TSizes.displayWidth(context) * 0.02),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: TSizes.displayWidth(context) * 0.27,
                  child: Text(
                    user.name ?? "No Name",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                FittedBox(
                  child: Text(
                    dailySpending.splits![index].amount.toString(),
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                  ),
                ),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget DailySpendingWidget(DailySpendingModel dailySpending) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(dailySpending.id),
          Text(dailySpending.amount.toString()),
          Text(dailySpending.category),
          Text(dailySpending.description.toString()),
        ],
      ),
    );
  }
}

class BarChartSample1 extends StatefulWidget {
  const BarChartSample1({
    super.key,
    required this.dailySpendings,
  });
  final List<DailySpendingModel> dailySpendings;

  @override
  State<StatefulWidget> createState() => BarChartSample1State();
}

class BarChartSample1State extends State<BarChartSample1> {
  final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex = -1;

  bool isPlaying = false;
  RxList<String> days = <String>[].obs;
  int maxHight = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _buildGraph();
    getMaxOfLast7Day();
  }

  double getMaxOfLast7Day() {
    double max = 0;
    for (int i = 0; i < 7; i++) {
      double temp = getAmountSpendByDateTime(days[i]);
      if (temp > max) {
        max = temp;
      }
    }
    return max;
  }

  double getMinOfLast7Day() {
    double max = 0;
    for (int i = 0; i < 7; i++) {
      double temp = getAmountSpendByDateTime(days[i]);
      if (temp < max) {
        max = temp;
      }
    }
    return max;
  }

  _buildGraph() {
    // make list of last 7 days name
    DateTime now = DateTime.now();
    for (int i = 0; i < 7; i++) {
      days.add(
          THelperFunctions.getDayDifference(now.subtract(Duration(days: i))));
    }
    log(days.toString());
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Text(
                  // title with some text emojis
                  //
                  '💰 Spendings of last 7 days',
                  // 'Daily Spendings',

                  style: TextStyle(
                    color: TColors.primary,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  'Max: ₹ ${getMaxOfLast7Day()}\nMin: ₹ ${getMinOfLast7Day()}',
                  style: const TextStyle(
                    color: TColors.accent,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 38,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: BarChart(
                      mainBarData(),
                      swapAnimationDuration: animDuration,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
              ],
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8),
          //   child: Align(
          //     alignment: Alignment.topRight,
          //     child: IconButton(
          //       icon: Icon(
          //         isPlaying ? Icons.pause : Icons.play_arrow,
          //         color: TColors.accent,
          //       ),
          //       onPressed: () {
          //         setState(() {
          //           isPlaying = !isPlaying;
          //           if (isPlaying) {
          //             // refreshState();
          //           }
          //         });
          //       },
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }

  double getAmountSpendByDateTime(String date) {
    double total = 0;
    for (DailySpendingModel spending in widget.dailySpendings) {
      if (THelperFunctions.getDayDifference(spending.timestamp) == date) {
        if (spending.isSplit) {
          double mySplit = 0;
          for (Split split in spending.splits!) {
            if (split.uid == FirebaseAuth.instance.currentUser!.uid) {
              mySplit = split.amount;
            }
          }
          total += mySplit;
        } else {
          total += spending.amount;
        }
      }
    }
    return total;
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color? barColor,
    double width = 20,
    List<int> showTooltips = const [],
  }) {
    barColor ?? Theme.of(context).colorScheme.primary;
    return BarChartGroupData(
      x: x,
      barsSpace: 4,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 1 : y,
          color: isTouched ? Theme.of(context).colorScheme.primary : barColor,
          width: width,
          borderSide: isTouched
              ? BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                  width: 1,
                )
              : const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            // toY: maxHight.toDouble(),
            color: TColors.grey.withOpacity(0.1),
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
      groupVertically: true,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(7, (i) {
        switch (i) {
          case 0:
            {
              return makeGroupData(
                0,
                getAmountSpendByDateTime(days[0]),
                isTouched: i == touchedIndex,
              );
            }
          case 1:
            return makeGroupData(1, getAmountSpendByDateTime(days[1]),
                isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, getAmountSpendByDateTime(days[2]),
                isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, getAmountSpendByDateTime(days[3]),
                isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(4, getAmountSpendByDateTime(days[4]),
                isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(5, getAmountSpendByDateTime(days[5]),
                isTouched: i == touchedIndex);
          case 6:
            return makeGroupData(6, getAmountSpendByDateTime(days[6]),
                isTouched: i == touchedIndex);
          default:
            return throw Error();
        }
      });

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (_) => Colors.blueGrey,
          tooltipHorizontalAlignment: FLHorizontalAlignment.right,
          tooltipMargin: -10,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            String weekDay;
            switch (group.x) {
              case 0:
                weekDay = days[0];
                break;
              case 1:
                weekDay = days[1];
                break;
              case 2:
                weekDay = days[2];
                break;
              case 3:
                weekDay = days[3];
                break;
              case 4:
                weekDay = days[4];
                break;
              case 5:
                weekDay = days[5];
                break;
              case 6:
                weekDay = days[6];
                break;
              default:
                throw Error();
            }
            return BarTooltipItem(
              '$weekDay\n',
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: (rod.toY - 1).toString(),
                  style: const TextStyle(
                    color: Colors.white, //widget.touchedBarColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          },
        ),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 38,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
      gridData: const FlGridData(show: false),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    TextStyle style = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: TSizes.displayWidth(context) < 500
          ? TSizes.displayWidth(context) * 0.024
          : 12,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = Text(
          days[0].split(' ').first,
          style: style,
        );
        break;
      case 1:
        text = Text(
          days[1].split(' ').first,
          style: style,
        );
        break;
      case 2:
        text = Text(
          "${days[2].split(' ').first} ${days[2].split(' ')[1]}",
          style: style,
        );
        break;
      case 3:
        text = Text(
          "${days[3].split(' ').first} ${days[3].split(' ')[1]}",
          style: style,
        );
        break;
      case 4:
        text = Text(
          "${days[4].split(' ').first} ${days[4].split(' ')[1]}",
          style: style,
        );
        break;
      case 5:
        text = Text(
          "${days[5].split(' ').first} ${days[5].split(' ')[1]}",
          style: style,
        );
        break;
      case 6:
        text = Text(
          "${days[6].split(' ').first} ${days[6].split(' ')[1]}",
          style: style,
        );
        break;
      default:
        text = const SizedBox();
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 12,
      child: text,
    );
  }

  // Future<dynamic> refreshState() async {
  //   setState(() {});
  //   await Future<dynamic>.delayed(
  //     animDuration + const Duration(milliseconds: 50),
  //   );
  //   if (isPlaying) {
  //     await refreshState();
  //   }
  // }
}
