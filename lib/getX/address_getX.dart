import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../api/api_paths.dart';
import '../api/api_response.dart';
import '../models/address_model.dart';
import '../shared_preferences/pref_controller.dart';

class AddressGetX extends GetxController {
  static AddressGetX get to => Get.find();
  RxBool loading = false.obs;

  final _addressModel = Rxn<AddressModel>();

  AddressModel? get addressModel => _addressModel.value;

  set addressModel(AddressModel? value) => _addressModel.value = value;

  @override
  void onInit() {
    super.onInit();
    getAddressData();
  }

  Future<ApiResponse> createAddress({
    required String nameAddress,
    required String infoAddress,
    required String contactNumber,
    required dynamic cityId,
  }) async {
    var uri = Uri.parse(ApiPath.addresses);
    var response = await http.post(
      uri,
      headers: {
        'Authorization': PrefController().token,
        'X-Requested-With': 'XMLHttpRequest',
        'Content-Type': 'application/x-www-form-urlencoded'
      },
      body: {
        'name': nameAddress,
        'info': infoAddress,
        'contact_number': contactNumber,
        'city_id': cityId,
      },
    );
    if (response.statusCode == 201 || response.statusCode == 400) {
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 201) {
        getAddressData();
      }
      return ApiResponse(
        message: jsonResponse['message'],
        status: jsonResponse['status'],
      );
    }
    return ApiResponse(
      message: 'Something went wrong, try again',
      status: false,
    );
  }

  Future<void> getAddressData() async {
    loading.value = true;
    var uri = Uri.parse(ApiPath.addresses);
    var response = await http.get(
      uri,
      headers: {
        'Authorization': PrefController().token,
        'X-Requested-With': 'XMLHttpRequest',
      },
    );
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      addressModel = AddressModel.fromJson(jsonResponse);
      loading.value = false;
    }
  }

  Future<ApiResponse> deleteAddress({required dynamic id}) async {
    var uri = Uri.parse('${ApiPath.addresses}/$id');
    var response = await http.delete(
      uri,
      headers: {
        'Authorization': PrefController().token,
        'X-Requested-With': 'XMLHttpRequest',
      },
    );
    if (response.statusCode == 200 || response.statusCode == 401) {
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        getAddressData();
      }
      return ApiResponse(message: jsonResponse['message'], status: true);
    }
    return ApiResponse(
      message: 'Something went wrong, try again',
      status: false,
    );
  }
}
