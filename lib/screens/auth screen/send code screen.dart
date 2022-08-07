import 'package:flutter/material.dart';
import 'package:smart_store/api/controller/auth%20api%20controller.dart';
import 'package:smart_store/models/api%20response.dart';
import 'package:smart_store/utils/helpers.dart';

import '../../widgets/code field.dart';

class SendCodeScreen extends StatefulWidget {
  const SendCodeScreen({
    Key? key,
    required this.phone,
  }) : super(key: key);
  final String phone;

  @override
  State<SendCodeScreen> createState() => _SendCodeScreenState();
}

class _SendCodeScreenState extends State<SendCodeScreen> with Helpers {
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

  PreferredSizeWidget appBar() {
    return AppBar(
      title: const Text(
        'CODE',
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

  Widget titleText() {
    return const Text(
      'Enter the code sent...',
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 25,
      ),
    );
  }

  Widget subTitleText() {
    return Text(
      widget.phone,
      style: const TextStyle(
        color: Colors.black45,
        fontWeight: FontWeight.w300,
        fontSize: 17,
      ),
    );
  }

  Widget loginButton() {
    return ElevatedButton(
      onPressed: () async => await _preformSend(),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
      ),
      child: const Text('Send'),
    );
  }

  Widget sizedBox() => const SizedBox(width: 5);

  Widget codeField() {
    return Row(
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
        sizedBox(),
        CodeField(
          focusNode: _twoNode,
          controller: _twoController,
          onChanged: (value) {
            if (value.isNotEmpty) {
              _threeNode.requestFocus();
            }
            _oneNode.requestFocus();
          },
        ),
        sizedBox(),
        CodeField(
          focusNode: _threeNode,
          controller: _threeController,
          onChanged: (value) {
            if (value.isNotEmpty) {
              _fourNode.requestFocus();
            }
            _threeNode.requestFocus();
          },
        ),
        sizedBox(),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: ListView(
        padding: const EdgeInsetsDirectional.all(20),
        physics: const NeverScrollableScrollPhysics(),
        children: [
          titleText(),
          subTitleText(),
          codeField(),
          const SizedBox(height: 20),
          loginButton(),
        ],
      ),
    );
  }

  void _showSnackBar(String message, bool error) {
    showSnackBar(context, message: message, error: error);
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
    _showSnackBar('Enter reset code!', true);
    return false;
  }

  void _getCode() {
    code = _oneController.text +
        _twoController.text +
        _threeController.text +
        _fourController.text;
  }

  Future<void> _sendCode() async {
    ApiResponse apiResponse =
        await AuthApiController().sendCode(phone: widget.phone, code: code);
    if (apiResponse.status) {
      navigator('MainScreen');
    }
  }

  void navigator(String route) {
    Navigator.pushReplacementNamed(context, '/$route');
  }
}
