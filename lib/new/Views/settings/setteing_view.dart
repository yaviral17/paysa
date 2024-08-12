import 'package:flutter/material.dart';
import 'package:paysa/new/Views/settings/widget/option_card.dart';
import 'package:paysa/utils/constants/colors.dart';
import 'package:paysa/utils/helpers/helper_functions.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SafeArea(
                child: Text('Settings',
                    style: TextStyle(
                      color: TColors.textWhite,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: const AssetImage('assets/images/google.png'),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text('Account Settings'),
              SizedBox(
                height: 10,
              ),
              SettingsOptionCard(
                onTap: () {},
                text: 'Name',
                fontSize: 15,
                height: MediaQuery.of(context).size.height * 0.08,
                color: TColors.darkTextField,
                suffixWidget: Text(
                  'John Doe',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
              ),
              SettingsOptionCard(
                text: 'Email',
                fontSize: 15,
                height: MediaQuery.of(context).size.height * 0.08,
                color: TColors.darkTextField,
                suffixWidget: Text(
                  'johnmaster69@sexy.com',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
              ),
              SettingsOptionCard(
                text: 'Change Password',
                fontSize: 15,
                height: MediaQuery.of(context).size.height * 0.08,
                color: TColors.darkTextField,
                suffixWidget: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text('App Settings'),
              SizedBox(
                height: 10,
              ),
              SettingsOptionCard(
                text: 'Currency',
                fontSize: 15,
                height: MediaQuery.of(context).size.height * 0.08,
                color: TColors.darkTextField,
                suffixWidget: Text(
                  'INR',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
              ),
              SettingsOptionCard(
                text: 'Reminder notification',
                fontSize: 15,
                height: MediaQuery.of(context).size.height * 0.08,
                color: TColors.darkTextField,
                suffixWidget: Text(
                  'Off',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
