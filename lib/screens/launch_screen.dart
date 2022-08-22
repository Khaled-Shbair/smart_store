import 'package:flutter/material.dart';
import 'package:smart_store/shared_preferences/pref_controller.dart';

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
     String route = PrefController().login ? mainScreen : loginScreen;
    Future.delayed(const Duration(seconds: 3),
        () => Navigator.pushReplacementNamed(context, route));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: AlignmentDirectional.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.blue.shade900,
              Colors.blue.shade100,
            ],
          ),
        ),
        child: const Center(
          child: Text(
            'SMART STORE',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
