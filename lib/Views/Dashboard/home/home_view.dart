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
                        color: PColors.secondaryText(context).withOpacity(0.2),
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
                          // Container(
                          //   width: PSize.arw(context, 50),
                          //   height: PSize.arw(context, 50),
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(10),
                          //     color: PColors.primary(context),
                          //   ),
                          //   child: Image.asset(name),
                          // ),
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

              // Caraousel Cards View
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 180),
                child: CarouselView(
                  itemSnapping: true,
                  controller: CarouselController(
                    initialItem: 0,
                  ),
                  itemExtent: 250,
                  shrinkExtent: 200,
                  children: [
                    // First Card
                    firstBgBalanceCard(context),
                    // Second Card
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          tileMode: TileMode.decal,
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            PColors.primary(context),
                            PColors.primary(context).withOpacity(0.5),
                          ],
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            HugeIcons
                                .strokeRoundedCircleArrowDataTransferHorizontal,
                            color: PColors.primaryText(context),
                          ),
                          const Spacer(),
                          Text(
                            '5678',
                            style: TextStyle(
                              fontSize: PSize.arw(context, 16),
                              fontWeight: FontWeight.w600,
                              letterSpacing: -1,
                              color:
                                  PColors.primaryText(context).withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          tileMode: TileMode.decal,
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            PColors.primary(context),
                            PColors.primary(context).withOpacity(0.5),
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

              SingleChildScrollView(
                child: Column(
                  children: [
                    // Balance Bar
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: PColors.secondaryText(context).withOpacity(0.2),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                HugeIcons.strokeRoundedMoneyExchange01,
                                color: PColors.primaryText(context),
                              ),
                              Icon(
                                HugeIcons.strokeRoundedArrowRight01,
                                color: PColors.primaryText(context),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Balance',
                                style: TextStyle(
                                  fontSize: PSize.arw(context, 16),
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: -1,
                                  color: PColors.primaryText(context),
                                ),
                              ),
                              const Spacer(),
                              Text(
                                '\$12,000.00',
                                style: TextStyle(
                                  fontSize: PSize.arw(context, 16),
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: -1,
                                  color: PColors.primaryText(context),
                                ),
                              ),
                              Text(
                                ' / ',
                                style: TextStyle(
                                  fontSize: PSize.arw(context, 16),
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: -1,
                                  color: PColors.secondaryText(context),
                                ),
                              ),
                              Text(
                                '\$14,000.00',
                                style: TextStyle(
                                  fontSize: PSize.arw(context, 16),
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: -1,
                                  color: PColors.secondaryText(context),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: PSize.arh(context, 8),
                          ),
                          LinearProgressIndicator(
                            value: 0.7,
                            backgroundColor:
                                PColors.primary(context).withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                            valueColor: AlwaysStoppedAnimation<Color>(
                              PColors.primary(context),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Quick add members Row
                    // --------------------------------
                    // fix this container's padding and margin for this ui
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 12),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: PColors.secondaryText(context).withOpacity(0.2),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: Row(
                              children: [
                                Text(
                                  'Quick Add Members',
                                  style: TextStyle(
                                    fontSize: PSize.arw(context, 16),
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: -1,
                                    color: PColors.primaryText(context),
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  'View All',
                                  style: TextStyle(
                                    fontSize: PSize.arw(context, 14),
                                    color: PColors.primary(context),
                                  ),
                                ),
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {},
                                  icon: HugeIcon(
                                    icon: HugeIcons.strokeRoundedArrowRight01,
                                    color: PColors.primary(context),
                                    size: PSize.arw(context, 20),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // row of profile containers
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  // profile container for each member
                                  const ProfileContainerWidget(),
                                  const ProfileContainerWidget(),
                                  const ProfileContainerWidget(),
                                  const ProfileContainerWidget(),

                                  // add member button
                                  Container(
                                    constraints: BoxConstraints(
                                      minWidth: PSize.arw(context, 100),
                                      maxHeight: PSize.arw(context, 100),
                                      maxWidth: PSize.arw(context, 100),
                                    ),
                                    margin: const EdgeInsets.only(right: 8),
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: PColors.primary(context)
                                          .withOpacity(0.2),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.add,
                                          color: PColors.primaryText(context),
                                        ),
                                        Text(
                                          'Add',
                                          style: TextStyle(
                                            fontSize: PSize.arw(context, 12),
                                            fontWeight: FontWeight.w600,
                                            color: PColors.primaryText(context),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Recent Transactions
                    // --------------------------------
                    // fix this container's padding and margin for this ui
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 12),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: PColors.secondaryText(context).withOpacity(0.2),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: Row(
                              children: [
                                Text(
                                  'Recent Transactions',
                                  style: TextStyle(
                                    fontSize: PSize.arw(context, 16),
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: -1,
                                    color: PColors.primaryText(context),
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  'View All',
                                  style: TextStyle(
                                    fontSize: PSize.arw(context, 14),
                                    color: PColors.primary(context),
                                  ),
                                ),
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {},
                                  icon: HugeIcon(
                                    icon: HugeIcons.strokeRoundedArrowRight01,
                                    color: PColors.primary(context),
                                    size: PSize.arw(context, 20),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // List of transactions

                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: Icon(
                                  HugeIcons.strokeRoundedMoneyExchange01,
                                  color: PColors.primaryText(context),
                                ),
                                title: Text(
                                  'Transaction $index',
                                  style: TextStyle(
                                    fontSize: PSize.arw(context, 16),
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: -1,
                                    color: PColors.primaryText(context),
                                  ),
                                ),
                                subtitle: Text(
                                  'Transaction $index',
                                  style: TextStyle(
                                    fontSize: PSize.arw(context, 14),
                                    color: PColors.secondaryText(context),
                                  ),
                                ),
                                trailing: Text(
                                  '\$12,000.00',
                                  style: TextStyle(
                                    fontSize: PSize.arw(context, 16),
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: -1,
                                    color: PColors.primaryText(context),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
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
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        Container(
          constraints: BoxConstraints(
            maxHeight: PSize.arw(context, 100),
            maxWidth: PSize.arw(context, 100),
          ),
          margin: const EdgeInsets.only(left: 2, right: 8),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                PColors.background(context).withOpacity(0.2),
                BlendMode.srcOver,
              ),
              image: const NetworkImage(
                  "https://avatars.githubusercontent.com/u/58760825?s=400&u=735ec2d81037c15adfbeea61a5a3112aef3afb85&v=4"),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(10),
            color: PColors.primary(context).withOpacity(0.2),
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
              Text(
                'Aviral Y.kjkasdhashasdbsavdjhsavfjavfhasvhj',
                softWrap: false,
                maxLines: 1,
                overflow: TextOverflow.fade,
                style: TextStyle(
                  fontSize: PSize.arw(context, 12),
                  fontWeight: FontWeight.w600,
                  color: PColors.primaryText(context),
                  letterSpacing: -0.6,
                ),
              ),
            ],
          ),
        ),
        //red dot indicator on top right
        Container(
          constraints: BoxConstraints(
            maxHeight: PSize.arw(context, 20),
            maxWidth: PSize.arw(context, 20),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: PColors.error,
            // PColors.primary(context).withOpacity(0.2),
          ),
        ),
      ],
    );
  }
}
