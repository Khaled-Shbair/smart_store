import '../../shared_preferences/pref_controller.dart';
import '../../widgets/select_city.dart';
import '../../widgets/button_auth.dart';
import '../../widgets/input_filed.dart';
import 'package:flutter/material.dart';
import '../../getX/address_getX.dart';
import '../../getX/cities_getX.dart';
import '../../api/api_response.dart';
import '../../utils/helpers.dart';
import 'package:get/get.dart';

class CreateAddressScreen extends StatefulWidget {
  const CreateAddressScreen({Key? key}) : super(key: key);

  @override
  State<CreateAddressScreen> createState() => _CreateAddressScreenState();
}

class _CreateAddressScreenState extends State<CreateAddressScreen>
    with Helpers {
  late TextEditingController _nameController;
  late TextEditingController _infoController;
  late TextEditingController _phoneController;
  String? selectedCityId;
  String selected = 'city'.tr;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _infoController = TextEditingController();
    _phoneController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _infoController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Widget selectCity() {
    return SelectCity(
      selected: selected,
      onChanged: (String? value) => setState(() => selectedCityId = value!),
      items: CitiesGetX.to.cityModel!.list.map((list) {
        return DropdownMenuItem(
            value: list.id.toString(),
            child: Text(language() ? list.nameEn : list.nameAr),
            onTap: () {
              setState(() {
                language() ? selected = list.nameEn : selected = list.nameAr;
              });
            });
      }).toList(),
    );
  }

  bool language() => PrefController().language == 'en' ? true : false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('create_address'.tr)),
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsetsDirectional.only(
          start: 20,
          end: 20,
          top: 50,
        ),
        children: [
          InputFiled(
            controller: _nameController,
            labelText: 'name_address'.tr,
            prefixIcon: Icons.note_alt_outlined,
            prefixText: '',
            maxLength: 35,
            fontSizeLabel: 16,
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 50),
          InputFiled(
            controller: _infoController,
            labelText: 'info_address'.tr,
            prefixIcon: Icons.info_outline,
            prefixText: '',
            fontSizeLabel: 16,
            maxLength: 80,
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 50),
          InputFiled(
            controller: _phoneController,
            labelText: 'contact_number'.tr,
            prefixIcon: Icons.phone,
            maxLength: 9,
            fontSizeLabel: 16,
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 50),
          selectCity(),
          SizedBox(height: MediaQuery.of(context).size.height / 15),
          ButtonAuth(
            text: 'create'.tr,
            onPressed: () async => await create(),
          ),
        ],
      ),
    );
  }

  Future<void> create() async {
    ApiResponse apiResponse = await AddressGetX().createAddress(
      nameAddress: _nameController.text,
      infoAddress: _infoController.text,
      contactNumber: _phoneController.text,
      cityId: selectedCityId.toString(),
    );
    showSnackBar(message: apiResponse.message, error: !apiResponse.status);
    if (apiResponse.status) {
      navigator();
      AddressGetX.to.getAddressData();
    }
  }

  void navigator() => Navigator.pop(context);
}
