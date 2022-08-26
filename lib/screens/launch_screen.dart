import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../shared_preferences/pref_controller.dart';
import '../constants/String.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  @override
  void initState() {
    super.initState();
    String route = PrefController().login ? smartStoreLayout : loginScreen;
    Future.delayed(
      const Duration(seconds: 3),
      () => Navigator.pushReplacementNamed(context, route),
    );
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
              height: 100,
              width: 100,
            ),
            const SizedBox(height: 5),
            const Text(
              'Smart Store',
              style: TextStyle(
                color: Colors.green,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
