import 'package:flutter/material.dart';
import 'package:smart_store/constants/String.dart';
import '../../api/api_response.dart';
import '../../getX/auth_controller_getX.dart';
import '../../models/city_model.dart';
import '../../utils/helpers.dart';
import '../../widgets/input filed.dart';
import '../../widgets/password filed.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with Helpers {
  List<City> city = <City>[];
  late TextEditingController _nameController;
  late TextEditingController _mobileController;
  late TextEditingController _passwordController;
  bool _obscureText = true;
  String _gender = 'M';
  String? selectedCityId = '1';

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _mobileController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget titleText() {
    return const Text(
      'Create new account...',
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 25,
      ),
    );
  }

  Widget subTitleText() {
    return const Text(
      'Create account to start app',
      style: TextStyle(
        color: Colors.black45,
        fontWeight: FontWeight.w300,
        height: 1,
        fontSize: 17,
      ),
    );
  }

  Widget nameField() {
    return InputFiled(
      controller: _nameController,
      keyboard: TextInputType.name,
      prefixIcon: Icons.person,
      hintText: 'Name',
    );
  }

  Widget mobileField() {
    return InputFiled(
      controller: _mobileController,
      keyboard: TextInputType.phone,
      prefixIcon: Icons.phone_android,
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

  Widget gender() {
    return Row(
      children: [
        Expanded(
          child: RadioListTile<String>(
            title: const Text('Male'),
            value: 'M',
            groupValue: _gender,
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _gender = value;
                });
              }
            },
          ),
        ),
        Expanded(
          child: RadioListTile<String>(
            title: const Text('Female'),
            value: 'F',
            groupValue: _gender,
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _gender = value;
                });
              }
            },
          ),
        ),
      ],
    );
  }

  Widget createButton() {
    return ElevatedButton(
      onPressed: () async => await _preformLogin(),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
      ),
      child: const Text('Create'),
    );
  }

  Widget loginButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Do you have an account? ',
          style: TextStyle(
            color: Colors.black45,
            fontWeight: FontWeight.w300,
          ),
        ),
        TextButton(
            onPressed: () {
              Navigator.pushNamed(context, loginScreen);
            },
            child: const Text(
              'Login!',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            )),
      ],
    );
  }

  Widget selectCity() {
    return DropdownButton<String>(
      value: selectedCityId,
      hint: const Text('City'),
      items: city
          .map(
            (dynamic list) => DropdownMenuItem<String>(
              value: list.id.toString(),
              child: Text(city[list.id].nameAr),
            ),
          )
          .toList(),
      onChanged: (String? value) {
        setState(() {
          selectedCityId = value;
        });
      },
    );
  }

  Widget sizedBox() => const SizedBox(height: 20);

  PreferredSizeWidget appBar() {
    return AppBar(
      title: const Text(
        'REGISTER',
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
          nameField(),
          sizedBox(),
          mobileField(),
          sizedBox(),
          passwordField(),
          sizedBox(),
          selectCity(),
          sizedBox(),
          gender(),
          createButton(),
          sizedBox(),
          loginButton(),
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
        _passwordController.text.isNotEmpty &&
        _nameController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context, message: 'Enter required data!', error: true);
    return false;
  }

  void _showSnackBar(String message, bool error) {
    showSnackBar(context, message: message, error: error);
  }

  Future<void> _login() async {
    ApiResponse apiResponse = await AuthApiController().register(
      phone: _mobileController.text,
      password: _passwordController.text,
      name: _nameController.text,
      cityId: selectedCityId.toString(),
      gender: _gender,
    );
    _showSnackBar(apiResponse.message, !apiResponse.status);
    if (apiResponse.status) {
      navigator();
    }
  }

  void navigator() {
    Navigator.pop(context);
  }
}
