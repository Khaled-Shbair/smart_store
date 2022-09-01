import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import '../../utils/helpers.dart';
import '../../constants/fonts.dart';
import '../../constants/colors.dart';
import '../../api/api_response.dart';
import '../../widgets/code_field.dart';
import '../../widgets/button_auth.dart';
import '../../widgets/view_details.dart';
import '../../widgets/password_filed.dart';
import '../../api/auth_api_controller.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key, required this.phone}) : super(key: key);
  final String phone;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen>
    with Helpers {
  late TextEditingController _newPasswordController;
  late TextEditingController _passwordConfirmationController;
  late TextEditingController _oneController;
  late TextEditingController _twoController;
  late TextEditingController _threeController;
  late TextEditingController _fourController;
  late FocusNode _oneNode;
  late FocusNode _twoNode;
  late FocusNode _threeNode;
  late FocusNode _fourNode;
  String code = '';
  bool _obscureText = true;
  bool _obscureConfirmationText = true;

  @override
  void initState() {
    super.initState();
    _newPasswordController = TextEditingController();
    _passwordConfirmationController = TextEditingController();
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
    _newPasswordController.dispose();
    _passwordConfirmationController.dispose();
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
      backgroundColor: ColorsApp.scaffoldColor,
      appBar: AppBar(
        title: ViewDetails(
          data: AppLocalizations.of(context)!.reset_password,
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
            data: AppLocalizations.of(context)!.title_forget_password,
            fontSize: 24,
            color: Colors.black,
            fontFamily: FontsApp.fontMedium,
          ),
          const SizedBox(height: 12),
          ViewDetails(
            data: AppLocalizations.of(context)!.sub_title_forget_password,
            fontSize: 15,
            color: ColorsApp.gery,
            fontFamily: FontsApp.fontRegular,
          ),
          const SizedBox(height: 30),
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
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 30),
          PasswordFiled(
            controller: _newPasswordController,
            obscureText: _obscureText,
            labelText: AppLocalizations.of(context)!.new_password,
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),
          const SizedBox(height: 30),
          PasswordFiled(
            controller: _passwordConfirmationController,
            obscureText: _obscureText,
            labelText: AppLocalizations.of(context)!.new_password_confirmation,
            onPressed: () {
              setState(
                  () => _obscureConfirmationText = !_obscureConfirmationText);
            },
          ),
          const SizedBox(height: 30),
          ButtonAuth(
            text: AppLocalizations.of(context)!.send,
            onPressed: () async => await _preformSend(),
          ),
        ],
      ),
    );
  }

  Future<void> _preformSend() async {
    if (_checkData()) {
      await _sendCode();
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
    showSnackBar(
        message: AppLocalizations.of(context)!.enter_reset_code, error: true);
    return false;
  }

  void _getCode() {
    code = _oneController.text +
        _twoController.text +
        _threeController.text +
        _fourController.text;
  }

  Future<void> _sendCode() async {
    ApiResponse apiResponse = await AuthApiController().resetPassword(
      phone: widget.phone,
      password: _newPasswordController.text,
      code: code,
    );
    showSnackBar(message: apiResponse.message, error: apiResponse.status);
    if (apiResponse.status) {
      navigator();
    }
  }

  void navigator() {
    Navigator.popUntil(context, ModalRoute.withName('/'));
  }
}
