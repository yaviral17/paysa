import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:paysa/Utils/sizes.dart';
import 'package:paysa/Utils/theme/colors.dart';
import 'package:paysa/Views/Dashboard/cards/widgets/cards_widget.dart';
import 'package:paysa/Views/Dashboard/cards/widgets/dot_indicator.dart';
import 'package:paysa/Views/Dashboard/cards/widgets/option_buttons.dart';
import 'package:smooth_corner/smooth_corner.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 5),
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
                  ),
                ],
              ),
            ),
            SizedBox(
              height: PSize.arw(context, 40),
            ),
            Expanded(
              child: SmoothContainer(
                padding: EdgeInsets.symmetric(
                  vertical: PSize.arw(context, 20),
                ),
                color: const Color.fromARGB(255, 28, 28, 28),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(PSize.arw(context, 40)),
                  topRight: Radius.circular(PSize.arw(context, 40)),
                ),
                smoothness: 0.6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        height: PSize.arh(context, 5),
                        width: PSize.arw(context, 60),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: PSize.arw(context, 20),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Last Transactions',
                            style: TextStyle(
                              fontSize: PSize.arw(context, 22),
                            ),
                          ),
                          ZoomTapAnimation(
                              child: Text(
                            'View all',
                            style: TextStyle(
                              fontSize: PSize.arw(context, 16),
                              color: PColors.primary(context),
                            ),
                          )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: PSize.arw(context, 20),
                    ),
                    ListTile(
                      leading: Brand(Brands.netflix_desktop_app,
                          size: PSize.arw(context, 45)),
                      title: Text(
                        'Transfer',
                        style: TextStyle(
                          fontSize: PSize.arw(context, 18),
                        ),
                      ),
                      subtitle: Text(
                        'Transfer to John Doe',
                        style: TextStyle(
                          fontSize: PSize.arw(context, 14),
                        ),
                      ),
                      trailing: Text(
                        '\$100',
                        style: TextStyle(
                          fontSize: PSize.arw(context, 18),
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Brand(Brands.amazon_prime_video,
                          size: PSize.arw(context, 45)),
                      title: Text(
                        'Transfer',
                        style: TextStyle(
                          fontSize: PSize.arw(context, 18),
                        ),
                      ),
                      subtitle: Text(
                        'Transfer to John Doe',
                        style: TextStyle(
                          fontSize: PSize.arw(context, 14),
                        ),
                      ),
                      trailing: Text(
                        '\$100',
                        style: TextStyle(
                          fontSize: PSize.arw(context, 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
