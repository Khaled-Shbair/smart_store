import 'package:flutter/material.dart';

import '../../api/api_response.dart';
import '../../constants/String.dart';
import '../../constants/fonts.dart';
import '../../utils/helpers.dart';
import '../../widgets/appBar_app.dart';
import '../../widgets/button_auth.dart';
import '../../widgets/input_filed.dart';
import '../../widgets/view_details.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> with Helpers {
  late TextEditingController _mobileController;

  @override
  void initState() {
    super.initState();
    _mobileController = TextEditingController();
  }

  @override
  void dispose() {
    _mobileController.dispose();
    super.dispose();
  }

  void show() {
    showModalBottomSheet(
      barrierColor: Colors.black.withAlpha(200),
      backgroundColor: Colors.transparent,
      elevation: 4,
      context: context,
      builder: (context) {
        return BottomSheet(
          onClosing: () {},
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          builder: (context) {
            return Padding(
              padding: const EdgeInsetsDirectional.only(
                top: 20,
                start: 20,
                end: 20,
                bottom: 50,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: AlignmentDirectional.center,
                    child: Container(
                      height: 5,
                      width: 130,
                      decoration: BoxDecoration(
                        color: const Color(0XFFC4C4C4),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                  const SizedBox(height: 54),
                  const ViewDetails(
                    data: 'Enter 4 Digits Code',
                    fontSize: 24,
                    color: Colors.black,
                    fontFamily: FontsApp.fontMedium,
                  ),
                  const SizedBox(height: 12),
                  const ViewDetails(
                    data:
                        'Enter the 4 digits code that you received on your email.',
                    fontSize: 16,
                    color: Color(0XFF677294),
                    fontFamily: FontsApp.fontRegular,
                  ),
                  const SizedBox(height: 20),
                  InputFiled(
                    controller: _mobileController,
                    keyboard: TextInputType.phone,
                    prefixIcon: Icons.phone_android,
                    labelText: 'Mobile',
                  ),
                  const SizedBox(height: 30),
                  ButtonAuth(
                    text: 'Continue',
                    // onPressed: () async => await _preformForget(),
                    onPressed: () {},
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarApp(title: 'FORGET PASSWORD'),
      body: ListView(
        padding: const EdgeInsetsDirectional.all(20),
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const ViewDetails(
            data: 'Enter your mobile number',
            fontSize: 24,
            color: Colors.black,
            fontFamily: FontsApp.fontMedium,
          ),
          const SizedBox(height: 12),
          const ViewDetails(
            data: 'Enter your phone number for the verification process, '
                'we will send 4 digits code to your phone.',
            fontSize: 15,
            color: Color(0XFF677294),
            fontFamily: FontsApp.fontRegular,
          ),
          const SizedBox(height: 30),
          InputFiled(
            controller: _mobileController,
            keyboard: TextInputType.phone,
            prefixIcon: Icons.phone_android,
            labelText: 'Phone',
          ),
          const SizedBox(height: 30),
          ButtonAuth(
            text: 'Send',
            // onPressed: () async => await _preformForget(),
            onPressed: () => show(),
          ),
        ],
      ),
    );
  }

  Future<void> _preformForget() async {
    if (_checkData()) {
      await _forget();
    }
  }

  bool _checkData() {
    if (_mobileController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(message: 'Enter required data!', error: true);
    return false;
  }

  Future<void> _forget() async {
    //ApiResponse apiResponse = await _controller.login(
    //    phone: _mobileController.text, password: _passwordController.text);
    //showSnackBar(message: apiResponse.message, error: !apiResponse.status);
    //if (apiResponse.status) {
    //  navigator();
    //}
  }

  void navigator() {
    //Navigator.pushReplacementNamed(context, );
  }
}
