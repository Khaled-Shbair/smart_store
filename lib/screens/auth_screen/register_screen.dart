import '../../api/auth_api_controller.dart';
import '../../widgets/choose_gender.dart';
import '../../widgets/password_filed.dart';
import '../../widgets/view_details.dart';
import '../../widgets/button_auth.dart';
import '../../widgets/input_filed.dart';
import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/routes.dart';
import '../../getX/cities_getX.dart';
import '../../api/api_response.dart';
import '../../constants/fonts.dart';
import '../../widgets/loading.dart';
import '../../utils/helpers.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with Helpers {
  final CitiesGetX _citiesGetX = Get.put(CitiesGetX());

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

  Widget gender() {
    return Row(
      children: [
        ChooseGender(
          title: 'male'.tr,
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
        ChooseGender(
          title: 'female'.tr,
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
      ],
    );
  }

  Widget selectCity() {
    return GetX<CitiesGetX>(
      builder: (controller) {
        if (_citiesGetX.loading.isTrue) {
          return const Loading();
        }
        return DropdownButton<String>(
          borderRadius: BorderRadius.circular(20),
          dropdownColor: Colors.red,
          items: _citiesGetX.cityModel!.list
              .map(
                (list) => DropdownMenuItem(
                  value: list.id.toString(),
                  child: Text(_citiesGetX.cityModel!.list[0].nameAr),
                ),
              )
              .toList(),
          hint: Text(_citiesGetX.cityModel!.list[0].nameAr),
          //const Text('City'),
          onChanged: (String? value) {
            setState(() => selectedCityId = value!);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('register'.tr)),
      body: ListView(
        padding: const EdgeInsetsDirectional.all(20),
        physics: const NeverScrollableScrollPhysics(),
        children: [
          ViewDetails(
            data: 'create_new_account'.tr,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
          ViewDetails(
            data: 'create_account_to_start_app'.tr,
            color: Colors.black45,
            fontWeight: FontWeight.w300,
            fontSize: 17,
          ),
          const SizedBox(height: 20),
          InputFiled(
            controller: _nameController,
            keyboard: TextInputType.name,
            prefixIcon: Icons.person,
            labelText: 'Name',
            maxLength: 8,
          ),
          const SizedBox(height: 20),
          InputFiled(
            controller: _mobileController,
            keyboard: TextInputType.phone,
            prefixIcon: Icons.phone_android,
            labelText: 'Mobile',
            maxLength: 9,
          ),
          const SizedBox(height: 20),
          PasswordFiled(
            controller: _passwordController,
            obscureText: _obscureText,
            labelText: 'Password',
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),
          const SizedBox(height: 20),
          selectCity(),
          const SizedBox(height: 20),
          gender(),
          ButtonAuth(
            onPressed: () async => await _preformLogin(),
            text: 'create'.tr,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ViewDetails(
                data: 'do_you_have_an_account'.tr,
                fontFamily: FontsApp.fontRegular,
                color: ColorsApp.green,
                fontSize: 17,
              ),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, loginScreen),
                child: ViewDetails(
                  data: 'login'.tr,
                  fontFamily: FontsApp.fontBold,
                  decoration: TextDecoration.underline,
                  color: ColorsApp.green,
                  fontSize: 15,
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
      await _register();
    }
  }

  bool _checkData() {
    if (_mobileController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _nameController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(message: 'Enter required data!', error: true);
    return false;
  }

  Future<void> _register() async {
    ApiResponse apiResponse = await AuthApiController().register(
      phone: _mobileController.text,
      password: _passwordController.text,
      name: _nameController.text,
      cityId: selectedCityId.toString(),
      gender: _gender,
    );
    showSnackBar(message: apiResponse.message, error: !apiResponse.status);
    // if (apiResponse.status) {
    //   navigator();
    // }
  }

  void navigator() => Navigator.pop(context);
}
/*
Widget selectCity() {
    return GetX<CitiesGetX>(
      builder: (controller) {
        if (_citiesGetX.loading.isTrue) {
          return const Loading();
        }
        return DropdownButton<String>(
          borderRadius: BorderRadius.circular(20),
          dropdownColor: Colors.red,
          items: _city
              .map(
                (list) => DropdownMenuItem(
                  value: list.id.toString(),
                  child: Text(_city[1].nameAr),
                ),
              )
              .toList(),
          hint: const Text('City'),
          onChanged: (String? value) {
            setState(() => selectedCityId = value!);
          },
        );
      },
    );
  }
 */
