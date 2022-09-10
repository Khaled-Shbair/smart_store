import '../../shared_preferences/pref_controller.dart';
import '../../api/auth_api_controller.dart';
import '../../widgets/choose_gender.dart';
import '../../widgets/field_profile.dart';
import '../../widgets/view_details.dart';
import '../../widgets/button_auth.dart';
import '../../widgets/select_city.dart';
import '../../widgets/input_filed.dart';
import 'package:flutter/material.dart';
import '../../api/api_response.dart';
import '../../constants/colors.dart';
import '../../getX/cities_getX.dart';
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
  String _gender = PrefController().gender;
  String selectedAr = PrefController().cityAr;
  String selectedEn = PrefController().cityEn;
  String name = PrefController().name;
  String? selectedCityId = PrefController().cityId;

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
              onPressed: () => navigator(),
              child: ViewDetails(
                data: 'cancel'.tr,
                fontSize: 16,
                color: ColorsApp.green,
                fontFamily: FontsApp.fontMedium,
              ),
            ),
            TextButton(
              onPressed: () {
                if (_nameController.text.isNotEmpty) {
                  navigator();
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
    return SelectCity(
      selected: PrefController().language == 'en' ? selectedEn : selectedAr,
      onChanged: (String? value) => setState(() => selectedCityId = value!),
      items: CitiesGetX.to.cityModel!.list.map((list) {
        return DropdownMenuItem(
            value: list.id.toString(),
            child: Text(language() ? list.nameEn : list.nameAr),
            onTap: () {
              setState(() {
                selectedAr = list.nameAr;
                selectedEn = list.nameEn;
              });
            });
      }).toList(),
    );
  }

  bool language() => PrefController().language == 'en' ? true : false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('update_profile'.tr)),
      body: ListView(
        padding: const EdgeInsetsDirectional.only(top: 50, start: 20, end: 20),
        physics: const NeverScrollableScrollPhysics(),
        children: [
          FieldProfile(
            title: _nameController.text.isEmpty ? name : _nameController.text,
            icon: Icons.person,
            trailing: IconButton(
              icon: const Icon(Icons.edit, color: ColorsApp.green),
              onPressed: updateName,
            ),
          ),
          sizeBoxHeight(50),
          FieldProfile(
            icon: Icons.phone_android,
            title: '0${PrefController().phone}',
          ),
          sizeBoxHeight(50),
          updateCity(),
          sizeBoxHeight(50),
          updateGender(),
          sizeBoxHeight(20),
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
      name: _nameController.text.isNotEmpty ? _nameController.text : name,
      cityId: selectedCityId.toString(),
      gender: _gender,
    );
    showSnackBar(message: apiResponse.message, error: !apiResponse.status);
    if (apiResponse.status) {
      PrefController().name =
          _nameController.text.isNotEmpty ? _nameController.text : name;
      PrefController().cityEn = selectedEn;
      PrefController().cityAr = selectedAr;
      PrefController().gender = _gender;
      PrefController().cityId = selectedCityId!;

      navigator();
    }
  }

  Widget sizeBoxHeight(double height) =>
      SizedBox(height: MediaQuery.of(context).size.height / height);

  void navigator() => Navigator.pop(context);
}
