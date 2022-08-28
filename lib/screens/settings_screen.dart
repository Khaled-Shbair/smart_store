import 'package:flutter/material.dart';
import 'package:smart_store/shared_preferences/pref_controller.dart';
import '../constants/routes.dart';
import '../api/auth_api_controller.dart';
import '../api/api_response.dart';
import '../constants/fonts.dart';
import '../constants/colors.dart';
import '../utils/helpers.dart';
import '../widgets/button_auth.dart';
import '../widgets/view_details.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> with Helpers {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.scaffoldColor,
      appBar: AppBar(
        title: const ViewDetails(
          data: 'Settings',
          fontFamily: FontsApp.fontBold,
          color: ColorsApp.green,
          fontSize: 24,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        padding: const EdgeInsetsDirectional.all(20),
        children: [
          Text(PrefController().name),
          Text(PrefController().phone),
          ListTile(
            leading: Icon(Icons.person),
          ),
          ButtonAuth(
            text: 'LOGOUT',
            onPressed: () async {
              ApiResponse apiResponse = await AuthApiController().logout();
              showSnackBar(
                  message: apiResponse.message, error: !apiResponse.status);
              if (apiResponse.status) {
                navigator();
              }
            },
          ),
        ],
      ),
    );
  }

  void navigator() => Navigator.pushReplacementNamed(context, loginScreen);
}
