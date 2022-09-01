import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/routes.dart';
import '../api/auth_api_controller.dart';
import '../api/api_response.dart';
import '../constants/fonts.dart';
import '../constants/colors.dart';
import '../utils/helpers.dart';
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
        title: ViewDetails(
          data: 'settings'.tr,
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
            title: 'edit_profile'.tr,
            onTap: () => Navigator.pushNamed(context, updateProfileScreen),
          ),
          divider(),
          ListSettings(
            icon: Icons.notifications_active,
            backgroundColor: ColorsApp.iconGreen,
            title: 'notifications'.tr,
            onTap: () => Navigator.pushNamed(context, notificationsScreen),
          ),
          divider(),
          ListSettings(
            icon: Icons.lock,
            backgroundColor: ColorsApp.iconRed,
            title: 'change_password'.tr,
            onTap: () => Navigator.pushNamed(context, changePasswordScreen),
          ),
          divider(),
          ListSettings(
            icon: Icons.add_home,
            backgroundColor: ColorsApp.iconOrange,
            title: 'addresses'.tr,
            onTap: () => Navigator.pushNamed(context, listAddressesScreen),
          ),
          divider(),
          ListSettings(
            icon: Icons.language,
            backgroundColor: Colors.tealAccent,
            title: 'languages'.tr,
            onTap: () => Navigator.pushNamed(context, changeLanguageScreen),
          ),
          divider(),
          ListSettings(
            icon: Icons.logout,
            backgroundColor: Colors.purple,
            title: 'logout'.tr,
            onTap: () async => _logout(),
          ),
          divider(),
        ],
      ),
    );
  }

  Widget divider() => const Divider(color: ColorsApp.gery, thickness: 1);

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
          title: ViewDetails(
            data: 'logout'.tr,
            fontSize: 26,
            color: ColorsApp.black,
            fontFamily: FontsApp.fontMedium,
          ),
          content: ViewDetails(
            data: 'are_you_sure_you_want_to_logout'.tr,
            fontSize: 17,
            color: ColorsApp.gery,
            fontFamily: FontsApp.fontRegular,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: ViewDetails(
                data: 'cancel'.tr,
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
              child: ViewDetails(
                data: 'ok'.tr,
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
