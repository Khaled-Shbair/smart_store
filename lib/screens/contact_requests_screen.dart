import '../getX/contact_requests_getX.dart';
import 'package:flutter/material.dart';
import '../widgets/button_auth.dart';
import '../widgets/input_filed.dart';
import '../api/api_response.dart';
import '../utils/helpers.dart';
import 'package:get/get.dart';

class ContactRequestsScreen extends StatefulWidget {
  const ContactRequestsScreen({Key? key}) : super(key: key);

  @override
  State<ContactRequestsScreen> createState() => _ContactRequestsScreenState();
}

class _ContactRequestsScreenState extends State<ContactRequestsScreen>
    with Helpers {
  final ContactRequestsGetX _contactRGetX = Get.put(ContactRequestsGetX());
  late TextEditingController _subjectController;
  late TextEditingController _messageController;

  @override
  void initState() {
    super.initState();
    _subjectController = TextEditingController();
    _messageController = TextEditingController();
  }

  @override
  void dispose() {
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('contact_requests'.tr)),
      body: GetX(
        builder: (controller) {
          return listContactRequests();
        },
      ),
    );
  }

  Widget listContactRequests() {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsetsDirectional.all(20),
      children: [
        InputFiled(
          controller: _subjectController,
          prefixIcon: Icons.phone_android,
          labelText: 'subject'.tr,
          fontSizeLabel: 16,
        ),
        sizedBoxHeight(20),
        InputFiled(
          controller: _messageController,
          prefixIcon: Icons.phone_android,
          labelText: 'message'.tr,
          fontSizeLabel: 16,
        ),
        sizedBoxHeight(50),
        ButtonAuth(
          text: 'create'.tr,
          onPressed: () async => await _createRequest(),
        ),
      ],
    );
  }

  Widget sizedBoxHeight(double height) =>
      SizedBox(height: MediaQuery.of(context).size.height / height);

  Future<void> _createRequest() async {
    ApiResponse apiResponse = await _contactRGetX.createContactRequest(
      message: _messageController.text,
      subject: _subjectController.text,
    );
    showSnackBar(message: apiResponse.message, error: !apiResponse.status);
    if (apiResponse.status) {
      navigator();
    }
  }

  void navigator() => Navigator.pop(context);
}
