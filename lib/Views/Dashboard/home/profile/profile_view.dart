import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:paysa/Controllers/authentication_controller.dart';
import 'package:paysa/Utils/helpers/helper.dart';
import 'package:random_avatar/random_avatar.dart';
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

  void toggleTheme(BuildContext context) {
    if (!PHelper.isDarkMode(context)) {
      Get.changeThemeMode(ThemeMode.dark);
    } else {
      Get.changeThemeMode(ThemeMode.light);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text('Edit Profile',
                        style: TextStyle(
                            color: PColors.bottomNavIconActive(context),
                            fontSize: 16)),
                  ),
                  TextButton(
                    onPressed: () {
                      authController.logout();
                    },
                    child: Text('Logout',
                        style: TextStyle(color: Colors.red, fontSize: 16)),
                  ),
                ],
              ),
              CircleAvatar(
                radius: PSize.displayWidth(context) * 0.12,
                backgroundColor: Colors.grey.shade300,
                child: RandomAvatar(
                  '${authController.user.value!.firstname!} ${authController.user.value!.lastname!}',
                  // height: 80,
                ),
              ),
              const SizedBox(height: 12),
              buildSettingsSection('Basic information 📑', [
                buildSettingsTile(
                    context, HugeIcons.strokeRoundedUser, 'Full Name',
                    trailing:
                        '${authController.user.value!.firstname!} ${authController.user.value!.lastname!}'),
                buildSettingsTile(
                    context, HugeIcons.strokeRoundedUserAccount, 'Username',
                    trailing: authController.user.value!.username!),
                buildSettingsTile(
                    context, HugeIcons.strokeRoundedMail01, 'Email',
                    trailing: authController.user.value!.email!),
              ]),
              const SizedBox(height: 20),
              buildSettingsSection('Preferences 🔧', [
                buildSettingsTile(
                  context,
                  HugeIcons.strokeRoundedMoon,
                  'Notifications',
                  trailing: authController.user.value?.token != null
                      ? 'Enabled'
                      : 'Disabled',
                  onTap: () {
                    PHelper.toggleTheme(context);
                  },
                ),
                buildSettingsTile(
                  context,
                  HugeIcons.strokeRoundedMoon,
                  'Theme',
                  trailing: PHelper.isDarkMode(context) ? 'Dark' : 'Light',
                  onTap: () {
                    PHelper.toggleTheme(context);
                  },
                ),
                buildSettingsTile(
                    context, HugeIcons.strokeRoundedShield02, 'Privacy Policy',
                    trailing: 'Read'),
                buildSettingsTile(context,
                    HugeIcons.strokeRoundedInformationCircle, 'About Version',
                    trailing: 'v1.0.0'),
                buildSettingsTile(
                    context,
                    HugeIcons.strokeRoundedInformationCircle,
                    'Terms of Service',
                    trailing: 'Read'),

                buildSettingsTile(context, HugeIcons.strokeRoundedSchoolBell01,
                    'Notifications',
                    trailing: 'Enabled'),
                // about developer
                buildSettingsTile(
                    context, HugeIcons.strokeRoundedUser, 'About Developer',
                    trailing: 'Read'),

                // buildToggleTile(context, 'Background Play', true),
                // buildToggleTile(context, 'Download via WiFi only', false),
                // buildToggleTile(context, 'Autoplay', true),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSettingsSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 10),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: PColors.primaryText(context),
            ),
          ),
        ),
        ...children,
      ],
    );
  }

  Widget buildSettingsTile(
    BuildContext context,
    IconData icon,
    String title, {
    String? trailing,
    Function()? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: PColors.primaryText(context)),
      title: Text(
        title,
        style: TextStyle(fontSize: 16, color: PColors.primaryText(context)),
      ),
      trailing: trailing != null
          ? Text(trailing, style: TextStyle(color: Colors.grey))
          : null,
      onTap: onTap,
    );
  }

  Widget buildToggleTile(BuildContext context, String title, bool value) {
    return SwitchListTile(
      title: Text(
        title,
        style: TextStyle(fontSize: 16, color: PColors.primaryTextDark),
      ),
      value: value,
      onChanged: (bool newValue) {},
    );
  }
}
