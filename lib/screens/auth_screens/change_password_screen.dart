import '../../api/auth_api_controller.dart';
import '../../widgets/password_filed.dart';
import '../../widgets/button_auth.dart';
import 'package:flutter/material.dart';
import '../../api/api_response.dart';
import '../../utils/helpers.dart';
import 'package:get/get.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('change_password'.tr)),
      body: ListView(
        padding: const EdgeInsetsDirectional.only(top: 60, start: 20, end: 20),
        physics: const NeverScrollableScrollPhysics(),
        children: [
          PasswordFiled(
            controller: _passwordController,
            obscureText: _obscureText,
            labelText: 'password'.tr,
            onPressed: () => setState(() => _obscureText = !_obscureText),
          ),
          sizeBoxHeight(40),
          PasswordFiled(
            controller: _newPasswordController,
            obscureText: obscureText1,
            labelText: 'new_password'.tr,
            onPressed: () => setState(() => obscureText1 = !obscureText1),
          ),
          sizeBoxHeight(40),
          PasswordFiled(
            controller: _newPasswordConfirmationController,
            obscureText: obscureText2,
            labelText: 'new_password_confirmation'.tr,
            onPressed: () => setState(() => obscureText2 = !obscureText2),
          ),
          sizeBoxHeight(15),
          ButtonAuth(
            text: 'change'.tr,
            onPressed: () async => await _changePassword(),
          ),
        ],
      ),
    );
  }

  Widget sizeBoxHeight(double height) =>
      SizedBox(height: MediaQuery.of(context).size.height / height);

  Future<void> _changePassword() async {
    ApiResponse apiResponse = await AuthApiController().changePassword(
      password: _passwordController.text,
      newPassword: _newPasswordController.text,
      newPasswordConfirmation: _newPasswordConfirmationController.text,
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
