import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/address_model.dart';
import '../../api/api_response.dart';
import '../../constants/colors.dart';
import '../../constants/fonts.dart';
import '../../getX/address_getX.dart';
import '../../utils/helpers.dart';
import '../../widgets/button_auth.dart';
import '../../widgets/input_filed.dart';
import '../../widgets/view_details.dart';

class UpdateAddressScreen extends StatefulWidget {
  const UpdateAddressScreen({
    Key? key,
    required this.address,
  }) : super(key: key);
  final Address address;

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
      appBar: AppBar(
        title: Text('update_address'.tr),
        iconTheme: const IconThemeData(color: ColorsApp.green),
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
            hintText: widget.address.name,
            prefixIcon: Icons.note_alt_outlined,
            prefixText: '',
            maxLength: 35,
          ),
          const SizedBox(height: 20),
          InputFiled(
            controller: _phoneController,
            hintText: widget.address.contactNumber,
            prefixIcon: Icons.phone,
            maxLength: 9,
          ),
          const SizedBox(height: 20),
          InputFiled(
            controller: _infoController,
            hintText: widget.address.info,
            prefixIcon: Icons.info_outline,
            prefixText: '',
            maxLength: 80,
          ),
          const SizedBox(height: 50),
          //TODO: Choose City
          ButtonAuth(
            text: 'update'.tr,
            onPressed: () async => await update(),
          ),
        ],
      ),
    );
  }

  Future<void> update() async {
    ApiResponse apiResponse = await AddressGetX().updateAddress(
      newNameAddress: _nameController.text.isEmpty
          ? widget.address.name
          : _nameController.text,
      newInfoAddress: _infoController.text.isEmpty
          ? widget.address.info
          : _infoController.text,
      newContactNumber: _phoneController.text.isEmpty
          ? widget.address.contactNumber
          : _phoneController.text,
      newCityId: widget.address.cityId.toString(),
      id: widget.address.id,
    );
    showSnackBar(message: apiResponse.message, error: !apiResponse.status);
    if (apiResponse.status) {
      AddressGetX.to.getAddressData();
      navigator();
    }
  }

  void navigator() => Navigator.pop(context);
}
