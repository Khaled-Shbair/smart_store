import 'package:flutter/material.dart';
import 'package:smart_store/shared_preferences/pref_controller.dart';
import 'package:smart_store/widgets/input_filed.dart';

import '../../api/api_response.dart';
import '../../api/auth_api_controller.dart';
import '../../constants/colors.dart';
import '../../constants/fonts.dart';
import '../../utils/helpers.dart';
import '../../widgets/button_auth.dart';
import '../../widgets/choose_gender.dart';
import '../../widgets/field_profile.dart';
import '../../widgets/view_details.dart';

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

  Widget gender() {
    return Row(
      children: [
        ChooseGender(
          title: 'Male',
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
          title: 'Female',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.scaffoldColor,
      appBar: AppBar(
        title: const ViewDetails(
          data: 'Update profile',
          fontFamily: FontsApp.fontBold,
          color: ColorsApp.green,
          fontSize: 24,
        ),
        iconTheme: const IconThemeData(color: ColorsApp.green),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        padding: const EdgeInsetsDirectional.all(20),
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const SizedBox(height: 50),
          FieldProfile(
            title: PrefController().name,
            icon: Icons.person,
            trailing: IconButton(
              icon: const Icon(Icons.edit, color: ColorsApp.green),
              onPressed: updateName,
            ),
          ),
          const SizedBox(height: 20),
          FieldProfile(
            icon: Icons.phone_android,
            title: '0${PrefController().phone}',
          ),
          //const SizedBox(height: 20),
          //TODO: Choose City
          const SizedBox(height: 20),
          gender(),
          const SizedBox(height: 50),
          ButtonAuth(
            text: 'Update',
            onPressed: () async => await updateProfile(),
          ),
        ],
      ),
    );
  }

  void updateName() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const ViewDetails(
            data: 'Enter your new name',
            fontSize: 20,
            color: ColorsApp.black,
            fontFamily: FontsApp.fontRegular,
          ),
          content: InputFiled(
            prefixText: '',
            controller: _nameController,
            keyboard: TextInputType.text,
            labelText: 'new name',
            prefixIcon: Icons.person,
            colorLabel: ColorsApp.black,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const ViewDetails(
                data: 'Cancel',
                fontSize: 16,
                color: ColorsApp.green,
                fontFamily: FontsApp.fontMedium,
              ),
            ),
            TextButton(
              onPressed: () {
                PrefController().name = _nameController.text;
                if (_nameController.text.isNotEmpty) {
                  Navigator.pop(context);
                }
              },
              child: const ViewDetails(
                data: 'Ok',
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

  Future<void> updateProfile() async {
    ApiResponse apiResponse = await AuthApiController().updateProfile(
      name: _nameController.text,
      cityOd: 1.toString(), //TODO
      gender: _gender,
    );
    showSnackBar(message: apiResponse.message, error: !apiResponse.status);
    if (apiResponse.status) {
      navigator();
    }
  }

  void navigator() {
    Navigator.pop(context);
  }
}
