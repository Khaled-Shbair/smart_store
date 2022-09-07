import '../../widgets/view_details.dart';
import 'package:flutter/material.dart';
import '../../getX/address_getX.dart';
import '../../constants/routes.dart';
import '../../api/api_response.dart';
import '../../constants/colors.dart';
import '../../constants/fonts.dart';
import '../../widgets/loading.dart';
import '../../widgets/no_data.dart';
import '../../utils/helpers.dart';
import 'package:get/get.dart';

class ListAddressesScreen extends StatefulWidget {
  const ListAddressesScreen({Key? key}) : super(key: key);

  @override
  State<ListAddressesScreen> createState() => _ListAddressesScreenState();
}

class _ListAddressesScreenState extends State<ListAddressesScreen>
    with Helpers {
  final AddressGetX _addressGetX = Get.put(AddressGetX());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('list_addresses'.tr),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, createAddressScreen),
            icon: const Icon(Icons.add_circle_outline),
          )
        ],
      ),
      body: GetX<AddressGetX>(
        builder: (controller) {
          if (_addressGetX.loading.isTrue) {
            return const Loading();
          }
          return listAddress();
        },
      ),
    );
  }

  Widget listAddress() {
    if (_addressGetX.addressModel!.data!.isNotEmpty) {
      return ListView.separated(
          padding: const EdgeInsetsDirectional.only(
            start: 20,
            end: 20,
            top: 50,
          ),
          itemCount: _addressGetX.addressModel!.data!.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () => Navigator.pushNamed(context, updateAddressScreen,
                  arguments: _addressGetX.addressModel!.data![index]),
              shape: const RoundedRectangleBorder(
                side: BorderSide(
                  color: ColorsApp.green,
                ),
              ),
              leading: ViewDetails(
                data: '${index + 1} - ',
                fontSize: 16,
                color: ColorsApp.black,
                fontFamily: FontsApp.fontMedium,
              ),
              minLeadingWidth: 0,
              horizontalTitleGap: 3,
              title: ViewDetails(
                data:
                    '${'city'.tr}: ${_addressGetX.addressModel!.data![index].city.nameEn}'
                    '\n${'address_screen'.tr}: ${_addressGetX.addressModel!.data![index].name}',
                fontSize: 18,
                fontFamily: FontsApp.fontMedium,
              ),
              subtitle: ViewDetails(
                data:
                    '${'phone'.tr}: ${_addressGetX.addressModel!.data![index].contactNumber}'
                    '\n${'info'.tr}: ${_addressGetX.addressModel!.data![index].info}',
                fontSize: 18,
                fontFamily: FontsApp.fontMedium,
              ),
              contentPadding: const EdgeInsetsDirectional.only(
                top: 10,
                bottom: 10,
                start: 10,
                end: 0,
              ),
              trailing: IconButton(
                padding: EdgeInsetsDirectional.zero,
                onPressed: () => deleteAddress(index),
                icon: const Icon(Icons.delete, color: ColorsApp.green),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(height: MediaQuery.of(context).size.height / 50);
          });
    } else {
      return const NoData();
    }
  }

  Future<void> deleteAddress(int index) async {
    ApiResponse apiResponse = await AddressGetX.to.deleteAddress(
      id: AddressGetX.to.addressModel!.data![index].id,
    );
    showSnackBar(message: apiResponse.message, error: !apiResponse.status);
  }
}
