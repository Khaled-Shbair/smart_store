import '../../shared_preferences/pref_controller.dart';
import '../../api/auth_api_controller.dart';
import '../../widgets/password_filed.dart';
import '../../widgets/choose_gender.dart';
import '../../widgets/view_details.dart';
import '../../widgets/button_auth.dart';
import '../../widgets/input_filed.dart';
import '../../widgets/select_city.dart';
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
  late TextEditingController _nameController;
  late TextEditingController _mobileController;
  late TextEditingController _passwordController;
  bool _obscureText = true;
  String _gender = 'M';
  String? selectedCityId;
  String selected = 'city'.tr;

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
        if (CitiesGetX.to.loading.isTrue) {
          return const Loading();
        }
        return SelectCity(
          selected: selected,
          onChanged: (String? value) => setState(() => selectedCityId = value!),
          items: CitiesGetX.to.cityModel!.list.map((list) {
            return DropdownMenuItem(
                value: list.id.toString(),
                child: Text(language() ? list.nameEn : list.nameAr),
                onTap: () {
                  setState(() {
                    language()
                        ? selected = list.nameEn
                        : selected = list.nameAr;
                  });
                });
          }).toList(),
        );
      },
    );
  }

  bool language() => PrefController().language == 'en' ? true : false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          sizeBoxHeight(40),
          InputFiled(
            controller: _nameController,
            keyboard: TextInputType.name,
            prefixIcon: Icons.person,
            labelText: 'name'.tr,
            fontSizeLabel: 16,
            prefixText: '',
            maxLength: 8,
          ),
          sizeBoxHeight(40),
          InputFiled(
            controller: _mobileController,
            keyboard: TextInputType.phone,
            prefixIcon: Icons.phone_android,
            labelText: 'phone'.tr,
            fontSizeLabel: 16,
            maxLength: 9,
          ),
          sizeBoxHeight(40),
          PasswordFiled(
            controller: _passwordController,
            obscureText: _obscureText,
            labelText: 'password'.tr,
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),
          sizeBoxHeight(40),
          selectCity(),
          sizeBoxHeight(40),
          gender(),
          ButtonAuth(
            onPressed: () async => await _register(),
            text: 'create'.tr,
          ),
          sizeBoxHeight(40),
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

  Widget sizeBoxHeight(double height) =>
      SizedBox(height: MediaQuery.of(context).size.height / height);

  Future<void> _register() async {
    ApiResponse apiResponse = await AuthApiController().register(
      phone: _mobileController.text,
      password: _passwordController.text,
      name: _nameController.text,
      cityId: selectedCityId.toString(),
      gender: _gender,
    );
    showSnackBar(message: apiResponse.message, error: !apiResponse.status);
    if (apiResponse.status) {
      navigator();
    }
  }

  void navigator() => Navigator.pushNamed(
        context,
        activateAccountScreen,
        arguments: _mobileController.text,
      );
}
