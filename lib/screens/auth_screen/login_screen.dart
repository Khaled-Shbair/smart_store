import 'package:flutter/material.dart';
import '../../utils/helpers.dart';
import '../../constants/fonts.dart';
import '../../constants/colors.dart';
import '../../api/api_response.dart';
import '../../constants/routes.dart';
import '../../widgets/button_auth.dart';
import '../../widgets/input_filed.dart';
import '../../widgets/view_details.dart';
import '../../widgets/password_filed.dart';
import '../../api/auth_api_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with Helpers {
  late TextEditingController _mobileController;
  late TextEditingController _passwordController;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _mobileController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _mobileController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget sizedBox(double height) => SizedBox(height: height);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.scaffoldColor,
      appBar: AppBar(
        title: ViewDetails(
          data: AppLocalizations.of(context)!.login,
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
        physics: const NeverScrollableScrollPhysics(),
        children: [
          ViewDetails(
            data: AppLocalizations.of(context)!.welcome_back,
            fontFamily: FontsApp.fontMedium,
            color: Colors.black,
            fontSize: 25,
          ),
          ViewDetails(
            data: AppLocalizations.of(context)!.login_to_start_using_app,
            fontFamily: FontsApp.fontRegular,
            color: ColorsApp.gery,
            fontSize: 17,
          ),
          sizedBox(20),
          InputFiled(
            controller: _mobileController,
            keyboard: TextInputType.phone,
            prefixIcon: Icons.phone_android,
            labelText: AppLocalizations.of(context)!.phone,
            maxLength: 9,
          ),
          sizedBox(20),
          PasswordFiled(
            controller: _passwordController,
            obscureText: _obscureText,
            labelText: AppLocalizations.of(context)!.password,
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),
          sizedBox(40),
          ButtonAuth(
            text: AppLocalizations.of(context)!.login,
            onPressed: () async => await _preformLogin(),
          ),
          sizedBox(20),
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, forgetPassword);
              },
              child: Text(
                AppLocalizations.of(context)!.forget_password_button,
                style: const TextStyle(
                  fontFamily: FontsApp.fontRegular,
                  color: ColorsApp.green,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
          sizedBox(15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.no_have_an_account,
                style: const TextStyle(
                  fontFamily: FontsApp.fontRegular,
                  color: ColorsApp.green,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, registerScreen);
                },
                child: Text(
                  AppLocalizations.of(context)!.create_now,
                  style: const TextStyle(
                    fontFamily: FontsApp.fontBold,
                    color: ColorsApp.green,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _preformLogin() async {
    if (_checkData()) {
      await _login();
    }
  }

  bool _checkData() {
    if (_mobileController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(
        message: AppLocalizations.of(context)!.enter_required_data,
        error: true);
    return false;
  }

  Future<void> _login() async {
    ApiResponse apiResponse = await AuthApiController().login(
        phone: _mobileController.text, password: _passwordController.text);
    showSnackBar(message: apiResponse.message, error: !apiResponse.status);
    if (apiResponse.status) {
      navigator();
    }
  }

  void navigator() {
    Navigator.pushReplacementNamed(context, appLayout);
  }
}
