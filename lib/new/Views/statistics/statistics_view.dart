import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:paysa/utils/constants/colors.dart';
import 'package:paysa/utils/constants/sizes.dart';
import 'package:paysa/utils/helpers/helper_functions.dart';

class StatisticsView extends StatefulWidget {
  const StatisticsView({super.key});

  @override
  State<StatisticsView> createState() => _StatisticsViewState();
}

class _StatisticsViewState extends State<StatisticsView> {
  List<FlSpot> getChartData() {
    return [
      FlSpot(1, 3),
      FlSpot(2, 4),
      FlSpot(3, 3.5),
      FlSpot(4, 5),
      FlSpot(5, 4),
      FlSpot(6, 6),
      FlSpot(7, 8),
      FlSpot(8, 10),
      FlSpot(9, 9),
      FlSpot(10, 2),
      FlSpot(11, 1),
      FlSpot(12, 4),
    ];
  }

  List<String> getChips = ['Daily', 'Weekly', 'Monthly'];
  int tag = 1;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return Scaffold(
        backgroundColor: TColors.background(context),
        appBar: _buildAppBar(isDark, context),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: TSizes.displayHeight(context) * 0.01),
                Row(
                  children: [
                    Icon(
                      Iconsax.dollar_circle,
                      size: TSizes.iconMd,
                    ),
                    SizedBox(width: TSizes.displayWidth(context) * 0.02),
                    Text("125,72",
                        style: TextStyle(
                          fontSize: TSizes.lg,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
                SizedBox(height: TSizes.displayHeight(context) * 0.02),
                ChipsChoice.single(
                  value: tag,
                  onChanged: (val) {
                    setState(() {
                      tag = val;
                    });
                  },
                  choiceItems: C2Choice.listFrom(
                      source: getChips, value: (i, v) => i, label: (i, v) => v),
                  choiceActiveStyle: C2ChoiceStyle(
                    color: Colors.white,
                    backgroundColor: TColors.primary,
                    borderColor: TColors.primary,
                  ),
                  choiceStyle: C2ChoiceStyle(
                    color: Colors.white,
                    backgroundColor: TColors.primary.withOpacity(0.5),
                    borderColor: TColors.primary,
                  ),
                ),
                SizedBox(height: TSizes.displayHeight(context) * 0.02),
                if (tag == 0) buildMonthlyChart(),
                if (tag == 1) buildMonthlyChart(),
                if (tag == 2) buildMonthlyChart(),
                SizedBox(height: TSizes.displayHeight(context) * 0.02),
                Text('Stats Friends', style: TextStyle(fontSize: 20)),
                SizedBox(height: TSizes.displayHeight(context) * 0.02),
                Container(
                  height: TSizes.displayHeight(context) * 0.2,
                  child: Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: [
                      ...List.generate(4, (index) => _buildFriend(isDark))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildFriend(bool isDark) {
    return Container(
      height: TSizes.displayHeight(context) * 0.1,
      width: TSizes.displayWidth(context) * 0.42,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: isDark ? TColors.darkContainer : TColors.lightContainer,
      ),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          SizedBox(width: 10),
          Icon(Iconsax.user, size: 20),
          SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('John Doe', style: TextStyle(fontSize: 16)),
              Text('12,000', style: TextStyle(fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  AspectRatio buildMonthlyChart() {
    return AspectRatio(
      aspectRatio: 2.0,
      child: LineChart(
        LineChartData(
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, _) {
                  switch (value.toInt()) {
                    case 1:
                      return Text('Jan',
                          style: TextStyle(
                              color: TColors.textSecondary,
                              fontSize: value == 1 ? 12 : 10));
                    case 2:
                      return Text('Feb',
                          style: TextStyle(
                              color: TColors.textSecondary, fontSize: 12));
                    case 3:
                      return Text('Mar',
                          style: TextStyle(
                              color: TColors.textSecondary, fontSize: 12));
                    case 4:
                      return Text('Apr',
                          style: TextStyle(
                              color: TColors.textSecondary, fontSize: 12));
                    case 5:
                      return Text('May',
                          style: TextStyle(
                              color: TColors.textSecondary, fontSize: 12));
                    case 6:
                      return Text('Jun',
                          style: TextStyle(
                              color: TColors.textSecondary, fontSize: 12));
                    case 7:
                      return Text('Jul',
                          style: TextStyle(
                              color: TColors.textSecondary, fontSize: 12));
                    case 8:
                      return Text('Aug',
                          style: TextStyle(
                              color: TColors.textSecondary, fontSize: 12));
                    case 9:
                      return Text('Sep',
                          style: TextStyle(
                              color: TColors.textSecondary, fontSize: 12));
                    case 10:
                      return Text('Oct',
                          style: TextStyle(
                              color: TColors.textSecondary, fontSize: 12));
                    case 11:
                      return Text('Nov',
                          style: TextStyle(
                              color: TColors.textSecondary, fontSize: 12));
                    case 12:
                      return Text('Dec',
                          style: TextStyle(
                              color: TColors.textSecondary, fontSize: 12));
                    default:
                      return Container();
                  }
                },
                reservedSize: 20,
              ),
            ),
          ),
          minX: 1,
          maxX: 12,
          minY: 0,
          maxY: 10,
          lineBarsData: [
            LineChartBarData(
              spots: getChartData(),
              isCurved: true,
              color: TColors.primary,
              barWidth: 4,
              belowBarData: BarAreaData(
                show: true,
                color: Colors.blue.withOpacity(0.2),
              ),
              dotData: FlDotData(show: false),
            ),
          ],
          gridData: FlGridData(
            show: true,
            drawHorizontalLine: false,
            horizontalInterval: 1,
            drawVerticalLine: false,
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(bool isDark, BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: IconButton(
        style: IconButton.styleFrom(
          shape: CircleBorder(),
          backgroundColor: isDark
              ? TColors.lightBackground.withOpacity(0.2)
              : TColors.darkGrey.withOpacity(0.2),
        ),
        onPressed: () {
          Get.back();
        },
        icon: Icon(
          Iconsax.arrow_left_2,
          size: TSizes.buttonHeight,
        ),
      ),
      actions: [
        IconButton(
          style: IconButton.styleFrom(
            shape: CircleBorder(),
            backgroundColor: isDark
                ? TColors.lightBackground.withOpacity(0.2)
                : TColors.darkGrey.withOpacity(0.2),
          ),
          onPressed: () {
            Get.toNamed('/settings');
          },
          icon: Icon(
            Iconsax.menu,
            size: TSizes.buttonHeight,
          ),
        ),
      ],
      centerTitle: true,
      backgroundColor: TColors.background(context),
      elevation: 0,
      title: Text(
        'Statistics',
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
