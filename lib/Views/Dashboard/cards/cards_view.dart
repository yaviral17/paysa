import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:paysa/Utils/sizes.dart';
import 'package:paysa/Views/Dashboard/cards/widgets/cards_widget.dart';
import 'package:paysa/Views/Dashboard/cards/widgets/dot_indicator.dart';
import 'package:paysa/Views/Dashboard/cards/widgets/option_buttons.dart';

class CardsView extends StatefulWidget {
  const CardsView({super.key});

  @override
  State<CardsView> createState() => _CardsViewState();
}

class _CardsViewState extends State<CardsView> {
  PageController _pageController = PageController();
  int _cardIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _pageController = PageController(initialPage: _cardIndex);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 5),
              child: Center(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'My Cards',
                        style: TextStyle(
                          fontSize: PSize.arw(context, 20),
                        ),
                      ),
                      SizedBox(
                        height: PSize.arw(context, 10),
                      ),
                      //
                      CarouselSlider(
                        options: CarouselOptions(
                          height: PSize.arw(context, 200),
                          viewportFraction: 0.97,
                          enlargeCenterPage: true,
                          enlargeFactor: 0.35,
                          enlargeStrategy: CenterPageEnlargeStrategy.height,
                          initialPage: _cardIndex,
                          enableInfiniteScroll: false,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _cardIndex = index;
                            });
                          },
                        ),
                        items: List.generate(
                            3,
                            (index) => CardsWidget(
                                  cardColor: Colors.primaries[index],
                                  key: ValueKey(index),
                                )),
                      ),
                      SizedBox(
                        height: PSize.arw(context, 16),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ...List.generate(
                              3,
                              (index) => DotIndicator(
                                    isActive: index == _cardIndex,
                                  ))
                        ],
                      ),
                      SizedBox(
                        height: PSize.arw(context, 30),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          OptionButtons(
                            icon: HugeIcons.strokeRoundedTransaction,
                            title: 'Transfer',
                          ),
                          SizedBox(
                            width: PSize.arw(context, 20),
                          ),
                          OptionButtons(
                            icon: HugeIcons.strokeRoundedPayment01,
                            title: 'Payment',
                          ),
                          SizedBox(
                            width: PSize.arw(context, 20),
                          ),
                          OptionButtons(
                            icon: HugeIcons.strokeRoundedPayment02,
                            title: 'Payout',
                          ),
                          SizedBox(
                            width: PSize.arw(context, 20),
                          ),
                          OptionButtons(
                            icon: HugeIcons.strokeRoundedAddCircle,
                            title: 'Top Up',
                          ),
                        ],
                      )
                    ]),
              ))),
    );
  }
}
