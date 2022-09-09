import 'package:smart_store/constants/routes.dart';
import '../../api/auth_api_controller.dart';
import '../../widgets/view_details.dart';
import '../../widgets/button_auth.dart';
import '../../widgets/code_field.dart';
import 'package:flutter/material.dart';
import '../../api/api_response.dart';
import '../../constants/colors.dart';
import '../../constants/fonts.dart';
import '../../utils/helpers.dart';
import 'package:get/get.dart';

class ActivateAccountScreen extends StatefulWidget {
  const ActivateAccountScreen({
    Key? key,
    required this.phone,
  }) : super(key: key);
  final String phone;

  @override
  State<ActivateAccountScreen> createState() => _ActivateAccountScreenState();
}

class _ActivateAccountScreenState extends State<ActivateAccountScreen>
    with Helpers {
  late TextEditingController _oneController;
  late TextEditingController _twoController;
  late TextEditingController _threeController;
  late TextEditingController _fourController;
  late FocusNode _oneNode;
  late FocusNode _twoNode;
  late FocusNode _threeNode;
  late FocusNode _fourNode;
  String code = '';

  @override
  void initState() {
    super.initState();
    _oneController = TextEditingController();
    _twoController = TextEditingController();
    _threeController = TextEditingController();
    _fourController = TextEditingController();
    _oneNode = FocusNode();
    _twoNode = FocusNode();
    _threeNode = FocusNode();
    _fourNode = FocusNode();
  }

  @override
  void dispose() {
    _oneController.dispose();
    _twoController.dispose();
    _threeController.dispose();
    _fourController.dispose();
    _oneNode.dispose();
    _twoNode.dispose();
    _threeNode.dispose();
    _fourNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('activate_account'.tr)),
      body: ListView(
        padding: const EdgeInsetsDirectional.only(start: 20, end: 20, top: 50),
        physics: const NeverScrollableScrollPhysics(),
        children: [
          ViewDetails(
            data: 'title_forget_password'.tr,
            fontSize: 24,
            color: Colors.black,
            fontFamily: FontsApp.fontMedium,
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 50),
          ViewDetails(
            data: 'sub_title_forget_password'.tr,
            fontSize: 15,
            color: ColorsApp.gery,
            fontFamily: FontsApp.fontRegular,
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 30),
          Row(
            children: [
              CodeField(
                focusNode: _oneNode,
                controller: _oneController,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    _twoNode.requestFocus();
                  }
                },
              ),
              const SizedBox(width: 10),
              CodeField(
                focusNode: _twoNode,
                controller: _twoController,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    _threeNode.requestFocus();
                  } else {
                    _oneNode.requestFocus();
                  }
                },
              ),
              const SizedBox(width: 10),
              CodeField(
                focusNode: _threeNode,
                controller: _threeController,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    _fourNode.requestFocus();
                  } else {
                    _threeNode.requestFocus();
                  }
                },
              ),
              const SizedBox(width: 10),
              CodeField(
                focusNode: _fourNode,
                controller: _fourController,
                onChanged: (value) {
                  if (value.isEmpty) {
                    _threeNode.requestFocus();
                  } else {
                    _preformSend();
                  }
                },
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 20),
          ButtonAuth(
            text: 'send'.tr,
            onPressed: () async => await _preformSend(),
          ),
        ],
      ),
    );
  }

  Future<void> _preformSend() async {
    if (_checkData()) {
      await _activateAccount();
    }
  }

  bool _checkData() {
    if (_oneController.text.isNotEmpty &&
        _twoController.text.isNotEmpty &&
        _threeController.text.isNotEmpty &&
        _fourController.text.isNotEmpty) {
      _getCode();
      return true;
    }
    showSnackBar(message: 'enter_reset_code'.tr, error: true);
    return false;
  }

  void _getCode() {
    code = _oneController.text +
        _twoController.text +
        _threeController.text +
        _fourController.text;
  }

  Future<void> _activateAccount() async {
    ApiResponse apiResponse = await AuthApiController().activateAccount(
      phone: widget.phone,
      code: code,
    );
    showSnackBar(message: apiResponse.message, error: !apiResponse.status);
    if (apiResponse.status) {
      navigator();
    }
  }

  void navigator() {
    Navigator.pushNamedAndRemoveUntil(context, loginScreen, (route) => false);
  }
}
