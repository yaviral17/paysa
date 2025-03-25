import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:iconsax/iconsax.dart';
import 'package:paysa/Controllers/dashboard_controller.dart';
import 'package:paysa/Models/spending_model.dart';
import 'package:paysa/Utils/constants/custom_enums.dart';
import 'package:paysa/Utils/sizes.dart';
import 'package:paysa/Utils/theme/colors.dart';
import 'package:paysa/Views/auth/login/login_view.dart';
import 'package:paysa/Views/auth/widgets/paysa_primary_button.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:smooth_corner/smooth_corner.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

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

  final DashboardController controller = Get.find();
  final TextEditingController searchController = TextEditingController();
  List<String> getChips = ['Day', 'Week', 'Month', 'Year'];
  int tag = 1;
  bool isLoaded = false;
  List<Map<String, String>> chat = [
    {
      "role": "assistant",
      "content":
          "Hello! I am Avi, your financial advisor. How can I help you today?"
    }
  ];

  Future<Map<String, dynamic>> getResponseFromLlama(String pormt) async {
    var headers = {'Content-Type': 'application/json'};
    var request =
        http.Request('POST', Uri.parse('http://localhost:11434/api/chat'));

    List<Map<String, dynamic>> messages = [
      {
        "role": "system",
        "content":
            "Act as a financial advisor.\n Now you will get the user's spending data and provide insights from realtime database don't let user know where this data is comping from.",
      },
      ...chat
    ];

    for (SpendingModel summary in controller.spendings.value) {
      if (summary.spendingType == SpendingType.shopping) {
        messages.add({
          "role": "user",
          "content": summary.toJson()['summary-for-llm'],
        });
      }
    }
    messages.add({"role": "user", "content": pormt});

    request.body = json.encode({
      "messages": messages,
      "model": "llama3.2:latest",
      "temperature": 1,
      "stream": false,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Map<String, dynamic> res =
          json.decode(await response.stream.bytesToString());
      res['isSuccess'] = true;
      return res;
    } else {
      return {
        'isSuccess': false,
        'message': 'Failed to get response from Llama',
        'error': response.reasonPhrase
      };
    }
  }

  void sendMessage(String message) async {
    chat.add({"role": "user", "content": message});
    setState(() {});
    isLoaded = true;
    Map<String, dynamic> res = await getResponseFromLlama(message);
    if (res['isSuccess']) {
      // Convert dynamic map to string map
      Map<String, String> llmMessage = {
        "role": "assistant",
        "content": res['message']['content'].toString()
      };
      chat.add(llmMessage);
    }
    isLoaded = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PColors.backgroundDark,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 5),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: isLoaded ? chat.length + 1 : chat.length,
                    itemBuilder: (context, index) {
                      if (isLoaded && index == chat.length) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18.0, vertical: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 10),
                                child: RandomAvatar(
                                  "Avi",
                                  height: PSize.arh(context, 40),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: PColors.primary(context),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          Colors.white,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        "Thinking ...",
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18.0, vertical: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 10),
                              child: RandomAvatar(
                                chat[index]['role'] == 'assistant'
                                    ? "Avi"
                                    : controller.user.value!.firstname!,
                                height: PSize.arh(context, 40),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: PColors.primary(context),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  chat[index]['content'] ?? '--',
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
              PaysaPrimaryTextField(
                controller: searchController,
                hintText: 'Ask a question',
                minLines: 1,
                maxLines: 1,
                prefixIcon: Icon(
                  HugeIcons.strokeRoundedAiUser,
                  color: PColors.primaryText(context),
                ),
                suffixIcon: ZoomTapAnimation(
                  onTap: () {
                    sendMessage(searchController.text);
                    searchController.clear();
                  },
                  child: Container(
                    width: PSize.arh(context, 36),
                    height: PSize.arh(context, 36),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: PColors.primary(context),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      HugeIcons.strokeRoundedArrowRight01,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
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
