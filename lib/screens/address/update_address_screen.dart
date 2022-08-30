import 'package:flutter/material.dart';

import '../../api/api_response.dart';
import '../../constants/colors.dart';
import '../../constants/fonts.dart';
import '../../getX/address_getX.dart';
import '../../utils/helpers.dart';
import '../../widgets/button_auth.dart';
import '../../widgets/input_filed.dart';
import '../../widgets/view_details.dart';

class UpdateAddressScreen extends StatefulWidget {
  const UpdateAddressScreen({Key? key}) : super(key: key);

  @override
  State<UpdateAddressScreen> createState() => _UpdateAddressScreenState();
}

class _UpdateAddressScreenState extends State<UpdateAddressScreen>
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
        title: const ViewDetails(
          data: 'Update address',
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
        padding: const EdgeInsetsDirectional.only(
          start: 20,
          end: 20,
          top: 50,
        ),
        children: [
          InputFiled(
            controller: _nameController,
            labelText: 'Name address',
            prefixIcon: Icons.add,
            prefixText: '',
            maxLength: 35,
          ),
          const SizedBox(height: 20),
          InputFiled(
            controller: _infoController,
            labelText: 'Info address',
            prefixIcon: Icons.info_outline,
            prefixText: '',
            maxLength: 80,
          ),
          const SizedBox(height: 20),
          InputFiled(
            controller: _phoneController,
            labelText: 'Contact Number',
            prefixIcon: Icons.phone,
            maxLength: 9,
          ),
          const SizedBox(height: 50),
          //TODO: Choose City
          ButtonAuth(
            text: 'Create',
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
      // navigator();
    }
  }

  void navigator() => Navigator.pop(context);
}
