import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:iconsax/iconsax.dart';
import 'package:paysa/Utils/sizes.dart';
import 'package:paysa/Utils/theme/colors.dart';
import 'package:smooth_corner/smooth_corner.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: PSize.arh(context, 12),
              ),

              // Header AppBar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: PColors.containerSecondary(context),
                      ),
                      child: Row(
                        children: [
                          SmoothClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              color: PColors.primary(context).withOpacity(0.7),
                              width: 2,
                            ),
                            child: Image.network(
                              "https://avatars.githubusercontent.com/u/58760825?s=400&u=735ec2d81037c15adfbeea61a5a3112aef3afb85&v=4",
                              width: PSize.arw(context, 50),
                              height: PSize.arw(context, 50),
                            ),
                          ),
                          SizedBox(
                            width: PSize.arw(context, 10),
                          ),
                          Text(
                            'Aviral Y.',
                            style: TextStyle(
                              fontSize: PSize.arw(context, 14),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            width: PSize.arw(context, 10),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: PColors.primary(context),
                            size: PSize.arw(context, 12),
                          ),
                          SizedBox(
                            width: PSize.arw(context, 10),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: HugeIcon(
                        icon: Iconsax.search_normal_1,
                        color: PColors.primary(context),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: HugeIcon(
                        icon: Iconsax.notification,
                        color: PColors.primary(context),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: HugeIcon(
                        icon: HugeIcons.strokeRoundedQrCode,
                        color: PColors.primary(context),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: PSize.arh(context, 16),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Row(
                  children: [
                    Expanded(
                      child: firstBgBalanceCard(context),
                    ),
                    // Second Card

                    Expanded(
                      child: SmoothContainer(
                        height: PSize.arw(context, 200),
                        width: PSize.arw(context, 200),
                        borderRadius: BorderRadius.circular(24),
                        color: PColors.containerSecondary(context),
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pocket',
                              style: TextStyle(
                                fontSize: PSize.arw(context, 16),
                                fontWeight: FontWeight.w600,
                                letterSpacing: -1,
                                color: PColors.secondaryText(context),
                              ),
                            ),
                            SizedBox(
                              height: PSize.arh(context, 8),
                            ),
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: PColors.containerSecondary(context),
                                // border: Border.all(
                                //   width: 1,
                                // color: PColors.primaryText(context)
                                //     .withOpacity(0.5),
                                // ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: PColors.primary(context)
                                          .withOpacity(0.5),
                                    ),
                                    child: Icon(
                                      HugeIcons.strokeRoundedWallet02,
                                      color: PColors.primaryText(context),
                                      size: PSize.arw(context, 26),
                                    ),
                                  ),
                                  SizedBox(
                                    width: PSize.arw(context, 8),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Wallet",
                                        style: TextStyle(
                                          fontSize: PSize.arw(context, 16),
                                          fontWeight: FontWeight.w600,
                                          color: PColors.primaryText(context),
                                        ),
                                      ),
                                      SizedBox(
                                        height: PSize.arh(context, 8),
                                      ),
                                      Text(
                                        "\$1229.00",
                                        style: TextStyle(
                                          fontSize: PSize.arw(context, 24),
                                          fontWeight: FontWeight.w700,
                                          color: PColors.primaryText(context),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: PSize.arh(context, 8),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: List.generate(
                                    4,
                                    (index) {
                                      return Container(
                                        margin: const EdgeInsets.only(right: 8),
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: PColors.containerSecondary(
                                              context),
                                        ),
                                        child: Icon(
                                          HugeIcons.strokeRoundedWallet02,
                                          color: PColors.primaryText(context),
                                        ),
                                      );
                                    },
                                  ),
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

              SizedBox(
                height: PSize.arh(context, 16),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Row(
                  children: [
                    Expanded(
                      child: SmoothContainer(
                        height: PSize.arw(context, 200),
                        width: PSize.arw(context, 200),
                        borderRadius: BorderRadius.circular(24),
                        color: PColors.containerSecondary(context),
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SmoothContainer(
                                  child: HugeIcon(
                                    icon: HugeIcons.strokeRoundedWallet02,
                                    color: PColors.primaryText(context),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: PSize.arw(context, 12),
                    ),
                    Expanded(
                      child: SmoothContainer(
                        height: PSize.arw(context, 200),
                        width: PSize.arw(context, 200),
                        borderRadius: BorderRadius.circular(24),
                        color: PColors.containerSecondary(context),
                        padding: const EdgeInsets.all(24),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container firstBgBalanceCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: PColors.background(context),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SizedBox(
          //   height: PSize.arh(context, 10),
          // ),
          Text(
            'TOTAL BALANCE',
            style: TextStyle(
              fontSize: PSize.arw(context, 16),
              fontWeight: FontWeight.w600,
              letterSpacing: -1,
              color: PColors.secondaryText(context),
            ),
          ),
          // SizedBox(
          //   height: PSize.arh(context, 2),
          // ),
          Text(
            '\$12,000.00',
            style: TextStyle(
              fontSize: PSize.arw(context, 40),
              color: PColors.primaryText(context),
              letterSpacing: -1,
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'View Details',
                style: TextStyle(
                  fontSize: PSize.arw(context, 14),
                  color: PColors.primary(context),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: HugeIcon(
                  icon: HugeIcons.strokeRoundedArrowRight01,
                  color: PColors.primary(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ProfileContainerWidget extends StatelessWidget {
  const ProfileContainerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: PSize.arw(context, 72),
      width: PSize.arw(context, 80),
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          Container(
            constraints: BoxConstraints(
              maxHeight: PSize.arw(context, 72),
              maxWidth: PSize.arw(context, 80),
            ),
            margin: const EdgeInsets.only(left: 2, right: 8),
            // padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              image: DecorationImage(
                colorFilter: ColorFilter.mode(
                  PColors.containerSecondary(context),
                  BlendMode.srcOver,
                ),
                image: const NetworkImage(
                    "https://avatars.githubusercontent.com/u/58760825?s=400&u=735ec2d81037c15adfbeea61a5a3112aef3afb85&v=4"),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(10),
              // color: PColors.primary(context).withOpacity(0.2),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Icon(
                //   HugeIcons.strokeRoundedUserCircle,
                //   color: PColors.primaryText(context),
                // ),
                // SizedBox(
                //   height: PSize.arh(context, 4),
                // ),
                Container(
                  constraints: BoxConstraints(
                    // maxHeight: PSize.arw(context, 20),
                    minWidth: PSize.arw(context, 80),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    color: PColors.background(context).withOpacity(0.9),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Text(
                    'Aviral Yadav',
                    softWrap: false,
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                      fontSize: PSize.arw(context, 12),
                      fontWeight: FontWeight.w600,
                      color: PColors.secondaryText(context),
                      letterSpacing: -0.6,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: HugeIcon(
              icon: Iconsax.notification_11,
              color: PColors.error,
              size: PSize.arw(context, 45),
            ),
          )
        ],
      ),
    );
  }
}
