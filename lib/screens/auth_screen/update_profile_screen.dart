import '../../shared_preferences/pref_controller.dart';
import '../../api/auth_api_controller.dart';
import '../../widgets/choose_gender.dart';
import '../../widgets/field_profile.dart';
import '../../widgets/view_details.dart';
import '../../widgets/button_auth.dart';
import '../../widgets/input_filed.dart';
import 'package:flutter/material.dart';
import '../../api/api_response.dart';
import '../../constants/colors.dart';
import '../../constants/fonts.dart';
import '../../utils/helpers.dart';
import 'package:get/get.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen>
    with Helpers {
  late TextEditingController _nameController;
  String _gender = 'M';

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Widget updateGender() {
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

  void updateName() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: ViewDetails(
            data: 'enter_new_name'.tr,
            fontSize: 20,
            color: ColorsApp.black,
            fontFamily: FontsApp.fontRegular,
          ),
          content: InputFiled(
            prefixText: '',
            controller: _nameController,
            labelText: 'new_name'.tr,
            prefixIcon: Icons.person,
            colorLabel: ColorsApp.black,
            maxLength: 30,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: ViewDetails(
                data: 'cancel'.tr,
                fontSize: MediaQuery.of(context).textScaleFactor * 16,
                color: ColorsApp.green,
                fontFamily: FontsApp.fontMedium,
              ),
            ),
            TextButton(
              onPressed: () {
                if (_nameController.text.isNotEmpty) {
                  Navigator.pop(context);
                } else {
                  showSnackBar(message: 'enter_new_name'.tr, error: true);
                }
              },
              child: ViewDetails(
                data: 'ok'.tr,
                fontSize: 16,
                color: ColorsApp.green,
                fontFamily: FontsApp.fontMedium,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget updateCity() {
    return Text(''); //TODO : Update city
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('update_profile'.tr)),
      body: ListView(
        padding: const EdgeInsetsDirectional.only(top: 50, start: 20, end: 20),
        physics: const NeverScrollableScrollPhysics(),
        children: [
          FieldProfile(
            title: _nameController.text.isEmpty
                ? PrefController().name
                : _nameController.text,
            icon: Icons.person,
            trailing: IconButton(
              icon: const Icon(Icons.edit, color: ColorsApp.green),
              onPressed: updateName,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 50),
          FieldProfile(
            icon: Icons.phone_android,
            title: '0${PrefController().phone}',
          ),
          //           SizedBox(height:MediaQuery.of(context).size.height/ 50),
          //TODO: Choose City
          SizedBox(height: MediaQuery.of(context).size.height / 50),
          updateGender(),
          const SizedBox(height: 50),
          ButtonAuth(
            text: 'update'.tr,
            onPressed: () async => await updateProfile(),
          ),
        ],
      ),
    );
  }

  Future<void> updateProfile() async {
    ApiResponse apiResponse = await AuthApiController().updateProfile(
      name: _nameController.text,
      cityOd: 1.toString(), //TODO
      gender: _gender,
    );
    showSnackBar(message: apiResponse.message, error: !apiResponse.status);
    if (apiResponse.status) {
      PrefController().name = _nameController.text;
      //PrefController().city = _nameController.text;
      navigator();
    }
  }

  void navigator() {
    Navigator.pop(context);
  }
}
