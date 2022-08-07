import 'package:flutter/material.dart';
import 'package:smart_store/models/api%20response.dart';
import 'package:smart_store/utils/helpers.dart';

import '../../api/controller/auth api controller.dart';
import '../../widgets/input filed.dart';
import '../../widgets/password filed.dart';
import 'send code screen.dart';

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

  Widget titleText() {
    return const Text(
      'Welcome back..',
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 25,
      ),
    );
  }

  Widget subTitleText() {
    return const Text(
      'Login to start using app',
      style: TextStyle(
        color: Colors.black45,
        fontWeight: FontWeight.w300,
        height: 1,
        fontSize: 17,
      ),
    );
  }

  Widget mobileField() {
    return InputFiled(
      controller: _mobileController,
      keyboard: TextInputType.phone,
      prefixIcon: Icons.mail,
      hintText: 'Mobile',
    );
  }

  Widget passwordField() {
    return PasswordFiled(
      controller: _passwordController,
      keyboard: TextInputType.visiblePassword,
      obscureText: _obscureText,
      hintText: 'Password',
      prefixIcon: _obscureText ? Icons.lock_outline : Icons.lock_open,
      suffixIcon: _obscureText ? Icons.visibility : Icons.visibility_off,
      onPressed: () {
        setState(() {
          _obscureText = !_obscureText;
        });
      },
    );
  }

  Widget loginButton() {
    return ElevatedButton(
      onPressed: () async => await _preformLogin(),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
      ),
      child: const Text('Login'),
    );
  }

  Widget forgetPasswordButton() {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: TextButton(
        onPressed: () {
          Navigator.pushNamed(context, '/ForgetPassword');
        },
        child: const Text(
          'Forget password?',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget createButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Don\'t have an account',
          style: TextStyle(
            color: Colors.black45,
            fontWeight: FontWeight.w300,
          ),
        ),
        TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/RegisterScreen');
            },
            child: const Text(
              'Create now!',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            )),
      ],
    );
  }

  Widget sizedBox() => const SizedBox(height: 20);

  PreferredSizeWidget appBar() {
    return AppBar(
      title: const Text(
        'LOGIN',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(),
      body: ListView(
        padding: const EdgeInsetsDirectional.all(20),
        physics: const NeverScrollableScrollPhysics(),
        children: [
          titleText(),
          subTitleText(),
          sizedBox(),
          mobileField(),
          sizedBox(),
          passwordField(),
          sizedBox(),
          loginButton(),
          sizedBox(),
          forgetPasswordButton(),
          sizedBox(),
          createButton(),
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
    showSnackBar(context, message: 'Enter required data!', error: true);
    return false;
  }

  void _showSnackBar(String message, bool error) {
    showSnackBar(context, message: message, error: error);
  }

  Future<void> _login() async {
    ApiResponse apiResponse = await AuthApiController().login(
        phone: _mobileController.text, password: _passwordController.text);
    _showSnackBar(apiResponse.message, !apiResponse.status);

    if (apiResponse.status) {
      navigator();
    }
  }

  void navigator() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SendCodeScreen(
          phone: _mobileController.text,
        ),
      ),
    );
  }
}
