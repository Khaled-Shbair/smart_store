import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../api/api_response.dart';
import '../../getX/address_getX.dart';
import '../../widgets/button_auth.dart';
import '../../widgets/input_filed.dart';
import '../../constants/colors.dart';
import '../../constants/fonts.dart';
import '../../utils/helpers.dart';
import '../../widgets/view_details.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.scaffoldColor,
      appBar: AppBar(
        title: ViewDetails(
          data: 'create_address'.tr,
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
          ),
          const SizedBox(height: 20),
          InputFiled(
            controller: _infoController,
            labelText: 'info_address'.tr,
            prefixIcon: Icons.info_outline,
            prefixText: '',
            maxLength: 80,
          ),
          const SizedBox(height: 20),
          InputFiled(
            controller: _phoneController,
            labelText: 'contact_number'.tr,
            prefixIcon: Icons.phone,
            maxLength: 9,
          ),
          const SizedBox(height: 50),
          //TODO: Choose City
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
      cityId: 1.toString(),
    );
    showSnackBar(message: apiResponse.message, error: !apiResponse.status);
    if (apiResponse.status) {
      navigator();
      AddressGetX.to.getAddressData();
    }
  }

  void navigator() => Navigator.pop(context);
}
