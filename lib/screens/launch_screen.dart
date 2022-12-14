import '../shared_preferences/pref_controller.dart';
import '../notifications/fb_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import '../constants/routes.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> with FbNotifications {
  @override
  void initState() {
    super.initState();
    String route = PrefController().login ? appLayout : loginScreen;
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, route);
    });
    requestNotificationPermissions();
    initializeForegroundNotificationForAndroid();
    manageNotificationAction();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'asset/images/shopping_logo.svg',
              height: MediaQuery.of(context).size.height / 5,
              width: MediaQuery.of(context).size.width / 5,
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 90),
            Text(
              'Smart Store',
              style: TextStyle(
                color: Colors.green,
                fontSize: const MediaQueryData().textScaleFactor * 45,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
