import '../../widgets/password_filed.dart';
import '../../getX/payment_card_getX.dart';
import '../../widgets/choose_gender.dart';
import '../../widgets/button_auth.dart';
import '../../widgets/input_filed.dart';
import 'package:flutter/material.dart';
import '../../api/api_response.dart';
import '../../utils/helpers.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class CreatePaymentCardScreen extends StatefulWidget {
  const CreatePaymentCardScreen({Key? key}) : super(key: key);

  @override
  State<CreatePaymentCardScreen> createState() =>
      _CreatePaymentCardScreenState();
}

class _CreatePaymentCardScreenState extends State<CreatePaymentCardScreen>
    with Helpers {
  final PaymentCardGetX _paymentGetX = Get.put(PaymentCardGetX());
  late TextEditingController nameController;
  late TextEditingController cardNumberController;
  late TextEditingController cvvController;
  late TextEditingController dateController;
  String _type = 'visa'.tr;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    cardNumberController = TextEditingController();
    cvvController = TextEditingController();
    dateController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    cardNumberController.dispose();
    cvvController.dispose();
    dateController.dispose();
    super.dispose();
  }

  Widget paymentType() {
    return Row(
      children: [
        ChooseGender(
          title: 'visa'.tr,
          value: 'Visa',
          groupValue: _type,
          onChanged: (value) {
            if (value != null) {
              setState(() {
                _type = value;
              });
            }
          },
        ),
        ChooseGender(
          title: 'master'.tr,
          value: 'Master',
          groupValue: _type,
          onChanged: (value) {
            if (value != null) {
              setState(() {
                _type = value;
              });
            }
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('create_payment_card'.tr)),
      body: ListView(
        padding: const EdgeInsetsDirectional.all(20),
        physics: const NeverScrollableScrollPhysics(),
        children: [
          InputFiled(
            controller: nameController,
            prefixIcon: Icons.person,
            maxLength: 50,
            labelText: 'holder_name'.tr,
            fontSizeLabel: 16,
            prefixText: '',
          ),
          sizeBoxHeight(40),
          InputFiled(
            keyboard: TextInputType.number,
            controller: cardNumberController,
            prefixIcon: Icons.numbers,
            maxLength: 16,
            labelText: 'card_number'.tr,
            fontSizeLabel: 16,
            prefixText: '',
          ),
          sizeBoxHeight(40),
          InputFiled(
            keyboard: TextInputType.number,
            controller: dateController,
            prefixIcon: Icons.calendar_month,
            maxLength: 50,
            labelText: 'exp_date'.tr,
            fontSizeLabel: 16,
            prefixText: '',
            readOnly: true,
            onTap: () async {
              await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(3000),
              ).then(
                (value) {
                  if (value != null) {
                    setState(
                      () => dateController.text =
                          DateFormat('yyyy-MM-dd').format(value),
                    );
                  }
                },
              );
            },
          ),
          sizeBoxHeight(40),
          PasswordFiled(
            controller: cvvController,
            prefixIcon: Icons.security,
            maxLength: 3,
            labelText: 'cvv'.tr,
            obscureText: _obscureText,
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),
          sizeBoxHeight(40),
          paymentType(),
          sizeBoxHeight(40),
          ButtonAuth(text: 'create'.tr, onPressed: () => createPayment()),
        ],
      ),
    );
  }

  Widget sizeBoxHeight(double height) =>
      SizedBox(height: MediaQuery.of(context).size.height / height);

  Future<void> createPayment() async {
    ApiResponse apiResponse = await _paymentGetX.createPayment(
      holderName: nameController.text,
      cardNumber: cardNumberController.text,
      cvv: cvvController.text,
      expDate: dateController.text,
      type: _type,
    );
    showSnackBar(message: apiResponse.message, error: !apiResponse.status);
    if (apiResponse.status) {
      _paymentGetX.getPaymentData();
      navigator();
    }
  }

  void navigator() => Navigator.pop(context);
}
