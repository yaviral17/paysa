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
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: PSize.arh(context, 12),
            ),
            // Headder
            Row(
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
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const HugeIcon(
                    icon: Iconsax.notification,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const HugeIcon(
                    icon: HugeIcons.strokeRoundedBubbleChat,
                    color: Colors.white,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
