import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paysa/Utils/helpers/helper.dart';
import 'package:paysa/Utils/helpers/navigations.dart';
import 'package:smooth_corner/smooth_corner.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../../Utils/sizes.dart';
import '../../../../utils/theme/colors.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});
  List<String> items = [
    'Profile Details',
    'Settings',
    'Help',
    'About Us',
    'Logout',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.only(
                top: 20,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildProfileDetailsCard(context),
                        SizedBox(
                          height: PSize.arh(context, 40),
                        ),
                        ...buildProfileItems(context),
                        SizedBox(
                          height: PSize.arh(context, 160),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: PColors.primary(context),
                    thickness: 5,
                    height: PSize.arh(context, 15),
                  ),
                  Divider(
                    color: PColors.primary(context),
                    thickness: 2,
                    height: PSize.arh(context, 3),
                  ),
                  buildBottomProfileCard(context),
                ],
              )),
        ),
      ),
    );
  }

  Expanded buildBottomProfileCard(BuildContext context) {
    return Expanded(
      child: Container(
        color: PHelper.isDarkMode(context)
            ? const Color.fromARGB(255, 59, 59, 59)
            : const Color.fromARGB(255, 115, 115, 115),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ListTile(
              title: Text('Invite friends to unlock extra features',
                  style: TextStyle(
                    fontSize: PSize.arw(context, 25),
                    // color: Colors.white,
                  )),
              subtitle: Text(
                  'Invite friends yo Paysa and get extra limited features which will help you and your friends to track expenses in a very optimal way.',
                  style: TextStyle(
                    fontSize: PSize.arw(context, 15),
                    color: PHelper.isDarkMode(context)
                        ? Colors.grey
                        : const Color.fromARGB(255, 43, 43, 43),
                  )),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: PSize.arw(context, 20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Text('Invite Code: ',
                              style: TextStyle(
                                fontSize: PSize.arw(context, 15),
                              )),
                          Text('123456',
                              style: TextStyle(
                                fontSize: PSize.arw(context, 15),
                                fontWeight: FontWeight.bold,
                              )),
                          GestureDetector(
                            onTap: () {},
                            child: Icon(
                              Icons.copy,
                              size: PSize.arw(context, 15),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: PSize.arh(context, 10),
                      ),
                      ZoomTapAnimation(
                        onTap: () {},
                        child: SmoothContainer(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          color: Colors.transparent,
                          smoothness: 0.6,
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                          side: BorderSide(
                            color: PHelper.isDarkMode(context)
                                ? Colors.white
                                : Colors.black,
                            width: 1,
                          ),
                          child: Text(
                            'Invite',
                            style: TextStyle(
                              fontSize: PSize.arw(context, 15),
                            ),
                          ),
                        ),
                      ),
                      Image.asset(
                          PHelper.isDarkMode(context)
                              ? 'assets/images/dark_branding.png'
                              : 'assets/images/light_branding.png',
                          width: PSize.arw(context, 80),
                          height: PSize.arh(context, 50)),
                    ],
                  ),
                ),
                Image.asset(
                  'assets/images/invite_us_doodle.png',
                  width: PSize.arw(context, 240),
                  height: PSize.arh(context, 100),
                  // fit: BoxFit.contain,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Row buildProfileDetailsCard(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ZoomTapAnimation(
              onTap: () {
                PNavigate.back(context);
              },
              child: Icon(
                Icons.arrow_back_ios_new_outlined,
                size: PSize.arw(context, 20),
              ),
            ),
            SizedBox(
              height: PSize.arh(context, 10),
            ),
            Text('Aviral Yadav',
                style: TextStyle(
                  fontSize: PSize.arw(context, 40),
                  fontWeight: FontWeight.bold,
                )),
            Text('+91 1234567890',
                style: TextStyle(
                  fontSize: PSize.arw(context, 20),
                )),
          ],
        ),
        Stack(children: [
          SmoothClipRRect(
            borderRadius: BorderRadius.circular(100),
            side: BorderSide(
              color: PColors.primary(context).withOpacity(0.7),
              width: 2,
            ),
            child: Image.network(
              "https://avatars.githubusercontent.com/u/58760825?s=400&u=735ec2d81037c15adfbeea61a5a3112aef3afb85&v=4",
              width: PSize.arw(context, 120),
              height: PSize.arw(context, 120),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: SmoothClipRRect(
              smoothness: 0.6,
              borderRadius: BorderRadius.circular(50),
              side: BorderSide(
                color: PColors.primaryDark.withOpacity(0.7),
                width: 2,
              ),
              child: ZoomTapAnimation(
                onTap: () {
                  Get.bottomSheet(
                    QRBottomSheet(),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(5),
                  color: PColors.primary(context),
                  child: Icon(
                    Icons.qr_code,
                    color: Colors.white,
                    size: PSize.arw(context, 25),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ],
    );
  }

  List<Widget> buildProfileItems(BuildContext context) {
    return List.generate(items.length, (index) {
      return Column(
        children: [
          ZoomTapAnimation(
            child: Text(
              items[index],
              style: TextStyle(
                fontSize: PSize.arw(context, 25),
              ),
            ),
          ),
          SizedBox(
            height: PSize.arh(context, 20),
          ),
        ],
      );
    });
  }
}

class QRBottomSheet extends StatelessWidget {
  const QRBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: SmoothContainer(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        smoothness: 0.6,
        color: PHelper.isDarkMode(context)
            ? PColors.backgroundLight
            : PColors.backgroundDark,
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: PSize.arh(context, 20),
            ),
            Text(
              'Your QR Code',
              style: TextStyle(
                  fontSize: PSize.arw(context, 30),
                  color: PColors.background(context)),
            ),
            SizedBox(
              height: PSize.arh(context, 20),
            ),
            Image.network(
              "https://avatars.githubusercontent.com/u/58760825?s=400&u=735ec2d81037c15adfbeea61a5a3112aef3afb85&v=4",
              width: PSize.arw(context, 200),
              height: PSize.arw(context, 200),
            ),
            SizedBox(
              height: PSize.arh(context, 20),
            ),
            Text(
              'Scan this QR code to view your profile',
              style: TextStyle(
                  fontSize: PSize.arw(context, 20),
                  color: PColors.background(context)),
            ),
            SizedBox(
              height: PSize.arh(context, 20),
            ),
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: SmoothContainer(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                  color: PColors.background(context),
                  width: 1,
                ),
                color: PColors.primary(context),
                child: Text(
                  'Close',
                  style: TextStyle(
                    fontSize: PSize.arw(context, 25),
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: PSize.arh(context, 20),
            ),
          ],
        ),
      ),
    );
  }
}
