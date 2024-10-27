import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paysa/Utils/helpers/helper.dart';
import 'package:smooth_corner/smooth_corner.dart';

import '../../../../Utils/sizes.dart';
import '../../../../utils/theme/colors.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});
  List<String> items = [
    'Profile',
    'Settings',
    'Help',
    'About',
    'Logout',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 50,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileInfoWidget(),
              SizedBox(
                height: PSize.arh(context, 40),
              ),
              ...buildProfileItems(context),
            ],
          )),
    );
  }

  List<Widget> buildProfileItems(BuildContext context) {
    return List.generate(items.length, (index) {
      return Column(
        children: [
          SmoothContainer(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            borderRadius: BorderRadius.circular(10),
            color: PColors.containerSecondary(context),
            side: BorderSide(
              color: PColors.primary(context).withOpacity(0.7),
              width: 1,
            ),
            smoothness: 0.6,
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

/**
 * ProfileInfoWidget
 * This widget is used to display the user's profile information
 * It contains the user's name, phone number, and profile picture
 * It also contains a back button and a QR code button
 * The user can click on the back button to go back to the previous screen
 * The user can click on the QR code button to view their QR code
 */
class ProfileInfoWidget extends StatelessWidget {
  const ProfileInfoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Get.back();
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
            borderRadius: BorderRadius.circular(50),
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
              child: GestureDetector(
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
