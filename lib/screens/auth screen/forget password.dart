import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_store/api/api_paths.dart';
import 'package:smart_store/models/city_model.dart';

import '../../getX/cities_getX.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  //final CitiesGetX _citiesGetX = Get.put(CitiesGetX());
  List<City> _city = <City>[];
  String? selectedCityId = '1';
  late int selectedCityIds;

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

//=============================================================================== Api Calling here

/*
FutureBuilder<List<City>>(
      future: CitiesGetX().readUsers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          _city = snapshot.data!;
          return ListView.builder(
            itemCount: _city.length,
            itemBuilder: (context, index) {
              return ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(_city[index].nameAr),
                subtitle: Text(_city[index].nameEn),
              );
            },
          );
        } else {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.warning, size: 80, color: Colors.black45),
                Text(
                  "NO DATA",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.black45,
                  ),
                ),
              ],
            ),
          );
        }
      },
    ),
 */
/*

      CitiesGetX().cityModel!.status
          ? ListView.separated(
              itemBuilder: (context, index) {
                return Text(CitiesGetX().cityModel!.list!.nameAr);
              },
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemCount: CitiesGetX().cityModel!.list!.id)
          : const Center(
              child: CircularProgressIndicator(),
            ),
 */
