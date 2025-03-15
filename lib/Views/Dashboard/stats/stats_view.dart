import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:paysa/Utils/sizes.dart';
import 'package:paysa/Utils/theme/colors.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:smooth_corner/smooth_corner.dart';

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

  List<String> getChips = ['Day', 'Week', 'Month', 'Year'];
  int tag = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: PColors.backgroundDark,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: Text('Statistics',
                        style: TextStyle(
                          fontSize: PSize.arw(context, 20),
                        ))),
                SizedBox(height: PSize.arh(context, 10)),
                // SmoothContainer(),

                Container(
                    height: PSize.arh(context, 50),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 57, 237, 117)
                          .withOpacity(0.2),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                tag = 0;
                              });
                            },
                            child: ChipWidget(
                                label: 'Day', tag: tag, assignIndex: 0)),
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                tag = 1;
                              });
                            },
                            child: ChipWidget(
                                label: 'Week', tag: tag, assignIndex: 1)),
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                tag = 2;
                              });
                            },
                            child: ChipWidget(
                                label: 'Month', tag: tag, assignIndex: 2)),
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                tag = 3;
                              });
                            },
                            child: ChipWidget(
                                label: 'Year', tag: tag, assignIndex: 3)),
                      ],
                    )),
                SizedBox(height: PSize.arh(context, 20)),
                if (tag == 0) buildMonthlyChart(),
                if (tag == 1) buildMonthlyChart(),
                if (tag == 2) buildMonthlyChart(),
                if (tag == 3) buildMonthlyChart(),
                SizedBox(height: PSize.arh(context, 20)),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        // height: PSize.arh(context, 70),
                        width: PSize.arw(context, 180),
                        decoration: BoxDecoration(
                          color: PColors.primaryLight.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('₹10,000',
                                  style: TextStyle(
                                    fontSize: PSize.arw(context, 25),
                                    fontWeight: FontWeight.bold,
                                  )),
                              SizedBox(height: PSize.arh(context, 5)),
                              Text('Balance',
                                  style: TextStyle(
                                    fontSize: PSize.arw(context, 18),
                                  )),
                            ]),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        // height: PSize.arh(context, 70),
                        width: PSize.arw(context, 180),
                        decoration: BoxDecoration(
                          color: PColors.primaryLight.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('₹10,000',
                                  style: TextStyle(
                                    fontSize: PSize.arw(context, 25),
                                    fontWeight: FontWeight.bold,
                                  )),
                              SizedBox(height: PSize.arh(context, 5)),
                              Text('Debits',
                                  style: TextStyle(
                                    fontSize: PSize.arw(context, 18),
                                  )),
                            ]),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        // height: PSize.arh(context, 70),
                        width: PSize.arw(context, 180),
                        decoration: BoxDecoration(
                          color: PColors.primaryLight.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('₹10,000',
                                  style: TextStyle(
                                    fontSize: PSize.arw(context, 25),
                                    fontWeight: FontWeight.bold,
                                  )),
                              SizedBox(height: PSize.arh(context, 5)),
                              Text('Credit',
                                  style: TextStyle(
                                    fontSize: PSize.arw(context, 18),
                                  )),
                            ]),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: PSize.arh(context, 20)),
                Text('Transactions',
                    style: TextStyle(
                      fontSize: PSize.arw(context, 20),
                    )),
                Divider(),
                SizedBox(height: PSize.arh(context, 10)),
                ...List.generate(
                  3,
                  (index) => ListTile(
                    leading: SmoothClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      side: BorderSide(
                        color: PColors.primary(context).withOpacity(0.7),
                        width: 2,
                      ),
                      child: RandomAvatar(
                        "User ${index + 1}",
                        width: PSize.arw(context, 50),
                      ),
                    ),
                    title: Text("User ${index + 1}"),
                    subtitle: Text("Today, 12:30 pm"),
                    trailing: Text(
                      "₹100",
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
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
                interval: 2,
                showTitles: true,
                getTitlesWidget: (value, _) {
                  switch (value.toInt()) {
                    case 1:
                      return Text('₹1k',
                          style: TextStyle(
                              color: PColors.secondaryTextDark,
                              fontSize: value == 1 ? 12 : 10));
                    case 2:
                      return Text('₹2k',
                          style: TextStyle(
                              color: PColors.secondaryTextDark, fontSize: 12));
                    case 3:
                      return Text('₹3k',
                          style: TextStyle(
                              color: PColors.secondaryTextDark, fontSize: 12));
                    case 4:
                      return Text('₹4k',
                          style: TextStyle(
                              color: PColors.secondaryTextDark, fontSize: 12));
                    case 5:
                      return Text('₹5k',
                          style: TextStyle(
                              color: PColors.secondaryTextDark, fontSize: 12));
                    case 6:
                      return Text('₹6k',
                          style: TextStyle(
                              color: PColors.secondaryTextDark, fontSize: 12));
                    case 7:
                      return Text('₹7k',
                          style: TextStyle(
                              color: PColors.secondaryTextDark, fontSize: 12));
                    case 8:
                      return Text('₹8k',
                          style: TextStyle(
                              color: PColors.secondaryTextDark, fontSize: 12));
                    case 9:
                      return Text('₹9k',
                          style: TextStyle(
                              color: PColors.secondaryTextDark, fontSize: 12));
                    case 10:
                      return Text('₹10k',
                          style: TextStyle(
                              color: PColors.secondaryTextDark, fontSize: 12));

                    default:
                      return Container();
                  }
                },
                reservedSize: 30,
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
                              color: PColors.secondaryTextDark,
                              fontSize: value == 1 ? 12 : 10));
                    case 2:
                      return Text('Feb',
                          style: TextStyle(
                              color: PColors.secondaryTextDark, fontSize: 12));
                    case 3:
                      return Text('Mar',
                          style: TextStyle(
                              color: PColors.secondaryTextDark, fontSize: 12));
                    case 4:
                      return Text('Apr',
                          style: TextStyle(
                              color: PColors.secondaryTextDark, fontSize: 12));
                    case 5:
                      return Text('May',
                          style: TextStyle(
                              color: PColors.secondaryTextDark, fontSize: 12));
                    case 6:
                      return Text('Jun',
                          style: TextStyle(
                              color: PColors.secondaryTextDark, fontSize: 12));
                    case 7:
                      return Text('Jul',
                          style: TextStyle(
                              color: PColors.secondaryTextDark, fontSize: 12));
                    case 8:
                      return Text('Aug',
                          style: TextStyle(
                              color: PColors.secondaryTextDark, fontSize: 12));
                    case 9:
                      return Text('Sep',
                          style: TextStyle(
                              color: PColors.secondaryTextDark, fontSize: 12));
                    case 10:
                      return Text('Oct',
                          style: TextStyle(
                              color: PColors.secondaryTextDark, fontSize: 12));
                    case 11:
                      return Text('Nov',
                          style: TextStyle(
                              color: PColors.secondaryTextDark, fontSize: 12));
                    case 12:
                      return Text('Dec',
                          style: TextStyle(
                              color: PColors.secondaryTextDark, fontSize: 12));
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
              color: PColors.primaryDark,
              barWidth: 4,
              belowBarData: BarAreaData(
                show: true,
                color: PColors.primaryLight.withOpacity(0.3),
              ),
              dotData: FlDotData(show: false),
            ),
          ],
          gridData: FlGridData(
            show: true,
            // drawHorizontalLine: false,
            horizontalInterval: 1,
            drawVerticalLine: false,
          ),
        ),
      ),
    );
  }
}

class ChipWidget extends StatelessWidget {
  const ChipWidget({
    super.key,
    required this.tag,
    required this.assignIndex,
    required this.label,
  });

  final int assignIndex;
  final int tag;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        label,
        style: TextStyle(
          fontSize: 13,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      backgroundColor: tag == assignIndex
          ? const Color.fromARGB(255, 34, 127, 65)
          : Colors.transparent,
      side: BorderSide(
        width: 1,
        color: Colors.transparent,
      ),
    );
  }
}
