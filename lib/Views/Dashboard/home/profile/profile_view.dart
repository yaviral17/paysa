import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paysa/Controllers/authentication_controller.dart';
import 'package:paysa/Utils/helpers/helper.dart';
import 'package:smooth_corner/smooth_corner.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../../Utils/sizes.dart';
import '../../../../utils/theme/colors.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final authController = Get.find<AuthenticationController>();

  List<String> items = [
    'Profile Details',
    'Settings',
    'Help',
    'About Us',
    'Logout',
  ];

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
    //   PHelper.systemUIOverlayStyle(
    //     context,
    //     systemNavigationBarColor: PColors.referCardBg(context),
    //   );
    // });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PHelper.systemUIOverlayStyle(
      context,
      systemNavigationBarColor: PColors.referCardBg(context),
    );
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.only(
            top: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SafeArea(
                child: Padding(
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
                      // SizedBox(
                      //   height: PSize.arh(context, 160),
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          )),
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
            // Padding(
            //   padding: const EdgeInsets.only(right: 20),
            //   child: ZoomTapAnimation(
            //     onTap: () {
            //       PNavigate.back();
            //     },
            //     child: Icon(
            //       Icons.arrow_back_ios_new_outlined,
            //       size: PSize.arw(context, 20),
            //     ),
            //   ),
            // ),
            SizedBox(
              height: PSize.arh(context, 10),
            ),
            Text(
              'Aviral Yadav',
              style: TextStyle(
                fontSize: PSize.arw(context, 32),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '+91 1234567890',
              style: TextStyle(
                fontSize: PSize.arw(context, 18),
              ),
            ),
          ],
        ),
        Stack(
          children: [
            SmoothClipRRect(
              borderRadius: BorderRadius.circular(100),
              side: BorderSide(
                color: PColors.primary(context).withOpacity(0.7),
                width: 2,
              ),
              child: Image.network(
                "https://avatars.githubusercontent.com/u/58760825?s=400&u=735ec2d81037c15adfbeea61a5a3112aef3afb85&v=4",
                width: PSize.arw(context, 100),
                height: PSize.arw(context, 100),
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
                      buildBottomSheet(context),
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
          ],
        ),
      ],
    );
  }

  Padding buildBottomSheet(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
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
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: PSize.arh(context, 16),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> buildProfileItems(BuildContext context) {
    return List.generate(items.length, (index) {
      return Column(
        children: [
          ZoomTapAnimation(
            onTap: () async {
              switch (items[index]) {
                case 'Profile Details':
                  break;
                case 'Settings':
                  break;
                case 'Help':
                  break;
                case 'About Us':
                  break;
                case 'Logout':
                  {
                    await authController.logout();
                    break;
                  }
                default:
              }
            },
            child: Text(
              items[index],
              style: TextStyle(
                fontSize: PSize.arw(context, 20),
              ),
            ),
          ),
          SizedBox(
            height: PSize.arh(context, 16),
          ),
        ],
      );
    });
  }
}
