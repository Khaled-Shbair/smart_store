import 'package:flutter/material.dart';

import '../../api/api_response.dart';
import '../../api/auth_api_controller.dart';
import '../../constants/colors.dart';
import '../../constants/fonts.dart';
import '../../utils/helpers.dart';
import '../../widgets/button_auth.dart';
import '../../widgets/password_filed.dart';
import '../../widgets/view_details.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen>
    with Helpers {
  late TextEditingController _newPasswordController;
  late TextEditingController _newPasswordConfirmationController;
  late TextEditingController _passwordController;
  bool _obscureText = true;
  bool obscureText1 = true;
  bool obscureText2 = true;

  @override
  void initState() {
    super.initState();
    _newPasswordController = TextEditingController();
    _newPasswordConfirmationController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _newPasswordConfirmationController.dispose();
    _newPasswordController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget password(
      TextEditingController controller, bool obscureText, String labelText) {
    return PasswordFiled(
      controller: controller,
      obscureText: obscureText,
      labelText: 'Password',
      onPressed: () {
        setState(() {
          obscureText = !obscureText;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.scaffoldColor,
      appBar: AppBar(
        title: const ViewDetails(
          data: 'Change password',
          fontFamily: FontsApp.fontBold,
          color: ColorsApp.green,
          fontSize: 24,
        ),
        iconTheme: const IconThemeData(color: ColorsApp.green),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        padding: const EdgeInsetsDirectional.only(top: 60, start: 20, end: 20),
        physics: const NeverScrollableScrollPhysics(),
        children: [
          PasswordFiled(
            controller: _passwordController,
            obscureText: _obscureText,
            labelText: 'Password',
            onPressed: () => setState(() => _obscureText = !_obscureText),
          ),
          const SizedBox(height: 20),
          PasswordFiled(
            controller: _newPasswordController,
            obscureText: obscureText1,
            labelText: 'New password',
            onPressed: () => setState(() => obscureText1 = !obscureText1),
          ),
          const SizedBox(height: 20),
          PasswordFiled(
            controller: _newPasswordConfirmationController,
            obscureText: obscureText2,
            labelText: 'New password confirmation',
            onPressed: () => setState(() => obscureText2 = !obscureText2),
          ),
          const SizedBox(height: 50),
          ButtonAuth(
            text: 'Change',
            onPressed: () async => await _preformChangePassword(),
          ),
        ],
      ),
    );
  }

  Future<void> _preformChangePassword() async {
    if (_checkData()) {
      await _changePassword();
    }
  }

  bool _checkData() {
    if (_passwordController.text.isNotEmpty &&
        _newPasswordController.text.isNotEmpty &&
        _newPasswordConfirmationController.text.isNotEmpty) {
      if (_newPasswordController.text ==
          _newPasswordConfirmationController.text) {
        return true;
      } else {
        showSnackBar(message: 'Password confirmation error!', error: true);
        return false;
      }
    }

    showSnackBar(message: 'Enter required data!', error: true);
    return false;
  }

  Future<void> _changePassword() async {
    ApiResponse apiResponse = await AuthApiController().changePassword(
      password: _passwordController.text,
      newPassword: _newPasswordController.text,
    );
    showSnackBar(message: apiResponse.message, error: !apiResponse.status);
    if (apiResponse.status) {
      navigator();
    }
  }

  void navigator() {
    Navigator.pop(context);
  }
}