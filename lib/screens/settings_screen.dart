import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
        title: ViewDetails(
          data: AppLocalizations.of(context)!.settings,
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
            title: AppLocalizations.of(context)!.edit_profile,
            onTap: () => Navigator.pushNamed(context, updateProfileScreen),
          ),
          divider(),
          ListSettings(
            icon: Icons.notifications_active,
            backgroundColor: ColorsApp.iconGreen,
            title: AppLocalizations.of(context)!.notifications,
            onTap: () => Navigator.pushNamed(context, notificationsScreen),
          ),
          divider(),
          ListSettings(
            icon: Icons.lock,
            backgroundColor: ColorsApp.iconRed,
            title: AppLocalizations.of(context)!.change_password,
            onTap: () => Navigator.pushNamed(context, changePasswordScreen),
          ),
          divider(),
          ListSettings(
            icon: Icons.add_home,
            backgroundColor: ColorsApp.iconOrange,
            title: AppLocalizations.of(context)!.addresses,
            onTap: () => Navigator.pushNamed(context, listAddressesScreen),
          ),
          divider(),
          const SizedBox(height: 20),
          ButtonAuth(
            text: AppLocalizations.of(context)!.logout,
            onPressed: () async => _logout(),
          ),
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
            data: AppLocalizations.of(context)!.logout,
            fontSize: 26,
            color: ColorsApp.black,
            fontFamily: FontsApp.fontMedium,
          ),
          content: ViewDetails(
            data: AppLocalizations.of(context)!.are_you_sure_you_want_to_logout,
            fontSize: 17,
            color: ColorsApp.gery,
            fontFamily: FontsApp.fontRegular,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: ViewDetails(
                data: AppLocalizations.of(context)!.cancel,
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
                data: AppLocalizations.of(context)!.ok,
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
