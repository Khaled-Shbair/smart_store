import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/fonts.dart';
import '../widgets/loading.dart';
import '../widgets/no_data.dart';
import '../getX/faqs_getX.dart';
import 'package:get/get.dart';

class FaqsScreen extends StatefulWidget {
  const FaqsScreen({Key? key}) : super(key: key);

  @override
  State<FaqsScreen> createState() => _FaqsScreenState();
}

class _FaqsScreenState extends State<FaqsScreen> {
  final FaqsGetX _faqsGetX = Get.put(FaqsGetX());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('faqs'.tr)),
      body: GetX<FaqsGetX>(
        builder: (controller) {
          if (_faqsGetX.loading.isTrue) {
            return const Loading();
          }
          return const NoData();
          // TODO: Processing later

          //return listFaqs();
        },
      ),
    );
  }

  Widget listFaqs() {
    if (_faqsGetX.faqs!.data!.isNotEmpty) {
      return const SizedBox();
    } else {
      return const NoData();
    }
  }
}
