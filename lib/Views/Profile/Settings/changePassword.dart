import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paysa/utils/constants/colors.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Change Password',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        margin: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.blue.withOpacity(0.5),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // SizedBox(height: 20),
            // Privacy Policy
            Text(
              'Reset Password',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            // Privacy Policy Content
            TextField(
              decoration: InputDecoration(
                hintText: 'Old Password',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                hintText: 'New Password',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                hintText: 'Confirm New Password',
              ),
            ),
            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {},
              child: Text(
                'Submit',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
