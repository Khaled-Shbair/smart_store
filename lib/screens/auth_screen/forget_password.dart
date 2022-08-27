import 'package:flutter/material.dart';
import '../../api/api_response.dart';
import '../../constants/String.dart';
import '../../constants/colors.dart';
import '../../constants/fonts.dart';
import '../../getX/auth_controller_getX.dart';
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
            color: MyColors.gery,
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
            onPressed: () async => await _preformForget(),
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
    ApiResponse apiResponse = await AuthApiController.to
        .forgetPassword(phone: _mobileController.text);
    showSnackBar(message: apiResponse.message, error: !apiResponse.status);
    if (apiResponse.status) {
      navigator();
    }
  }

  void navigator() {
    Navigator.pushNamed(context, resetPasswordScreen,
        arguments: _mobileController.text);
  }
}
