import '../../api/auth_api_controller.dart';
import '../../widgets/view_details.dart';
import '../../widgets/button_auth.dart';
import '../../widgets/input_filed.dart';
import 'package:flutter/material.dart';
import '../../api/api_response.dart';
import '../../constants/routes.dart';
import '../../constants/colors.dart';
import '../../constants/fonts.dart';
import '../../utils/helpers.dart';
import 'package:get/get.dart';

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
      appBar: AppBar(
        title: Text('forget_password'.tr),
        iconTheme: const IconThemeData(color: ColorsApp.green),
      ),
      body: ListView(
        padding: const EdgeInsetsDirectional.all(20),
        physics: const NeverScrollableScrollPhysics(),
        children: [
          ViewDetails(
            data: 'title_forget_password'.tr,
            fontSize: 24,
            color: Colors.black,
            fontFamily: FontsApp.fontMedium,
          ),
          const SizedBox(height: 12),
          ViewDetails(
            data: 'sub_title_forget_password'.tr,
            fontSize: 15,
            color: ColorsApp.gery,
            fontFamily: FontsApp.fontRegular,
          ),
          const SizedBox(height: 30),
          InputFiled(
            controller: _mobileController,
            keyboard: TextInputType.phone,
            prefixIcon: Icons.phone_android,
            labelText: 'phone'.tr,
            maxLength: 9,
          ),
          const SizedBox(height: 30),
          ButtonAuth(
            text: 'send'.tr,
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
    showSnackBar(message: 'enter_required_data'.tr, error: true);
    return false;
  }

  Future<void> _forget() async {
    ApiResponse apiResponse =
        await AuthApiController().forgetPassword(phone: _mobileController.text);
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
