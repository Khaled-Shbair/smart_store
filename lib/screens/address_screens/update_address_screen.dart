import '../../shared_preferences/pref_controller.dart';
import '../../widgets/select_city.dart';
import '../../widgets/button_auth.dart';
import '../../widgets/input_filed.dart';
import 'package:flutter/material.dart';
import '../../getX/address_getX.dart';
import '../../api/api_response.dart';
import '../../getX/cities_getX.dart';
import '../../models/address.dart';
import '../../utils/helpers.dart';
import 'package:get/get.dart';

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
  String? selectedCityId;
  String? selected;

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

  Widget updateCity() {
    return SelectCity(
      selected: selected!.isEmpty
          ? language()
              ? widget.address.city.nameEn
              : widget.address.city.nameAr
          : selected!,
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
      appBar: AppBar(title: Text('update_address'.tr)),
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
          SizedBox(height: MediaQuery.of(context).size.height / 50),
          InputFiled(
            controller: _phoneController,
            hintText: widget.address.contactNumber,
            prefixIcon: Icons.phone,
            maxLength: 9,
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 50),
          InputFiled(
            controller: _infoController,
            hintText: widget.address.info,
            prefixIcon: Icons.info_outline,
            prefixText: '',
            maxLength: 80,
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 50),
          updateCity(),
          SizedBox(height: MediaQuery.of(context).size.height / 15),
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
      newCityId: selectedCityId!.isEmpty
          ? widget.address.cityId.toString()
          : selectedCityId,
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
