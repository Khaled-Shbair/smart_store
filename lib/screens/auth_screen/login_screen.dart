import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/view_details.dart';
import '../../api/api_response.dart';
import '../../constants/String.dart';
import '../../constants/fonts.dart';
import '../../getX/auth_controller_getX.dart';
import '../../utils/helpers.dart';
import '../../widgets/appBar_app.dart';
import '../../widgets/button_auth.dart';
import '../../widgets/input_filed.dart';
import '../../widgets/password_filed.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with Helpers {
  final AuthApiController _controller = Get.put(AuthApiController());
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
      appBar: appBarApp(title: 'LOGIN'),
      body: ListView(
        padding: const EdgeInsetsDirectional.all(20),
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const ViewDetails(
            data: 'Welcome back',
            fontFamily: FontsApp.fontMedium,
            color: Colors.black,
            fontSize: 25,
          ),
          const ViewDetails(
            data: 'Login to start using app',
            fontFamily: FontsApp.fontRegular,
            color: Color(0XFF677294),
            fontSize: 17,
          ),
          sizedBox(20),
          InputFiled(
            controller: _mobileController,
            keyboard: TextInputType.phone,
            prefixIcon: Icons.phone_android,
            labelText: 'Mobile',
          ),
          sizedBox(20),
          PasswordFiled(
            controller: _passwordController,
            keyboard: TextInputType.visiblePassword,
            obscureText: _obscureText,
            labelText: 'Password',
            prefixIcon: _obscureText ? Icons.lock_outline : Icons.lock_open,
            suffixIcon: _obscureText ? Icons.visibility : Icons.visibility_off,
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),
          sizedBox(20),
          ButtonAuth(
            text: 'Login',
            onPressed: () async => await _preformLogin(),
          ),
          sizedBox(20),
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, forgetPassword);
              },
              child: const Text(
                'Forget password?',
                style: TextStyle(
                  fontFamily: FontsApp.fontRegular,
                  color: Color(0XFF0EBE7F),
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
          sizedBox(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Don\'t have an account?',
                style: TextStyle(
                  fontFamily: FontsApp.fontRegular,
                  color: Color(0XFF0EBE7F),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, registerScreen);
                },
                child: const Text(
                  'Create now!',
                  style: TextStyle(
                    fontFamily: FontsApp.fontBold,
                    color: Color(0XFF0EBE7F),
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
    showSnackBar(message: 'Enter required data!', error: true);
    return false;
  }

  Future<void> _login() async {
    ApiResponse apiResponse = await _controller.login(
        phone: _mobileController.text, password: _passwordController.text);
    showSnackBar(message: apiResponse.message, error: !apiResponse.status);
    if (apiResponse.status) {
      navigator();
    }
  }

  void navigator() {
    Navigator.pushReplacementNamed(context, mainScreen);
  }
}
