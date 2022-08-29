import 'package:flutter/material.dart';
import '../constants/routes.dart';
import '../api/auth_api_controller.dart';
import '../api/api_response.dart';
import '../constants/fonts.dart';
import '../constants/colors.dart';
import '../utils/helpers.dart';
import '../widgets/button_auth.dart';
import '../widgets/list_settings.dart';
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
          ListSettings(
            icon: Icons.person,
            backgroundColor: ColorsApp.iconBlue,
            title: 'Edit profile',
            onTap: () => Navigator.pushNamed(context, updateProfileScreen),
          ),
          divider(),
          ListSettings(
            icon: Icons.notifications_active,
            backgroundColor: ColorsApp.iconGreen,
            title: 'Notifications',
            onTap: () => Navigator.pushNamed(context, notificationsScreen),
          ),
          divider(),
          ListSettings(
            icon: Icons.lock,
            backgroundColor: ColorsApp.iconRed,
            title: 'Change password',
            onTap: () => Navigator.pushNamed(context, changePasswordScreen),
          ),
          divider(),
          const SizedBox(height: 20),
          ButtonAuth(
            text: 'LOGOUT',
            onPressed: () async => _logout(),
          ),
        ],
      ),
    );
  }

  Widget divider() => const Divider(color: ColorsApp.gery, thickness: 1);

  void logout() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const ViewDetails(
            data: 'Logout',
            fontSize: 26,
            color: ColorsApp.black,
            fontFamily: FontsApp.fontMedium,
          ),
          content: const ViewDetails(
            data: 'Are you sure you want to logout?',
            fontSize: 16,
            color: ColorsApp.gery,
            fontFamily: FontsApp.fontRegular,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const ViewDetails(
                data: 'Cancel',
                fontSize: 16,
                color: ColorsApp.green,
                fontFamily: FontsApp.fontMedium,
              ),
            ),
            TextButton(
              onPressed: () async => await _logout(),
              child: const ViewDetails(
                data: 'Ok',
                fontSize: 16,
                color: ColorsApp.green,
                fontFamily: FontsApp.fontMedium,
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _logout() async {
    showDialog(
      barrierColor: Colors.black.withAlpha(230),
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          title: const ViewDetails(
            data: 'Logout',
            fontSize: 26,
            color: ColorsApp.black,
            fontFamily: FontsApp.fontMedium,
          ),
          content: const ViewDetails(
            data: 'Are you sure you want to logout?',
            fontSize: 17,
            color: ColorsApp.gery,
            fontFamily: FontsApp.fontRegular,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const ViewDetails(
                data: 'Cancel',
                fontSize: 16,
                color: ColorsApp.green,
                fontFamily: FontsApp.fontMedium,
              ),
            ),
            TextButton(
              onPressed: () async {
                ApiResponse apiResponse = await AuthApiController().logout();
                showSnackBar(
                    message: apiResponse.message, error: !apiResponse.status);
                if (apiResponse.status) {
                  navigator();
                }
              },
              child: const ViewDetails(
                data: 'Ok',
                fontSize: 16,
                color: ColorsApp.green,
                fontFamily: FontsApp.fontMedium,
              ),
            ),
          ],
        );
      },
    );
  }

  void navigator() => Navigator.pushReplacementNamed(context, loginScreen);
}
