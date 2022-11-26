import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:zoom_clone/resources/auth_methods.dart';

import '../widgets/home_meeting_button.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            // color: Colors.red,
            child: Lottie.asset(
              'assets/animations/bye.json',
              fit: BoxFit.contain,
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            HomeMeetingButton(
              onPressed: () => AuthMethods().logout(),
              icon: Icons.logout,
              text: "Logout",
            ),
          ],
        ),
      ],
    );
  }
}
