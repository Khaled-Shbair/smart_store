import '../../getX/payment_card_getX.dart';
import '../../widgets/password_filed.dart';
import '../../widgets/choose_gender.dart';
import '../../models/payment_model.dart';
import '../../widgets/input_filed.dart';
import '../../widgets/button_auth.dart';
import 'package:flutter/material.dart';
import '../../api/api_response.dart';
import '../../constants/colors.dart';
import '../../constants/fonts.dart';
import '../../utils/helpers.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class UpdatePaymentCardScreen extends StatefulWidget {
  const UpdatePaymentCardScreen({
    Key? key,
    required this.payment,
  }) : super(key: key);
  final Payment payment;

  @override
  State<UpdatePaymentCardScreen> createState() =>
      _UpdatePaymentCardScreenState();
}

class _UpdatePaymentCardScreenState extends State<UpdatePaymentCardScreen>
    with Helpers {
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
            hintText: widget.payment.holderName,
            prefixText: '',
            hintStyle: TextStyle(
              fontFamily: FontsApp.fontRegular,
              color: ColorsApp.gery,
              fontSize: MediaQuery.of(context).textScaleFactor * 16,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 40),
          InputFiled(
            keyboard: TextInputType.number,
            controller: cardNumberController,
            prefixIcon: Icons.numbers,
            maxLength: 16,
            hintText: widget.payment.cardNumber,
            hintStyle: TextStyle(
              fontFamily: FontsApp.fontRegular,
              color: ColorsApp.gery,
              fontSize: MediaQuery.of(context).textScaleFactor * 16,
            ),
            prefixText: '',
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 40),
          InputFiled(
            keyboard: TextInputType.number,
            controller: dateController,
            prefixIcon: Icons.calendar_month,
            maxLength: 50,
            hintText: widget.payment.expDate,
            hintStyle: TextStyle(
              fontFamily: FontsApp.fontRegular,
              color: ColorsApp.gery,
              fontSize: MediaQuery.of(context).textScaleFactor * 16,
            ),
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
          SizedBox(height: MediaQuery.of(context).size.height / 40),
          PasswordFiled(
            controller: cvvController,
            prefixIcon: Icons.security,
            maxLength: 3,
            hintText: widget.payment.cvv,
            obscureText: _obscureText,
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 40),
          paymentType(),
          SizedBox(height: MediaQuery.of(context).size.height / 40),
          ButtonAuth(text: 'update'.tr, onPressed: () => createPayment()),
        ],
      ),
    );
  }

  Future<void> createPayment() async {
    ApiResponse apiResponse = await PaymentCardGetX.to.updateData(
      holderName: nameController.text.isNotEmpty
          ? nameController.text
          : widget.payment.holderName,
      cardNumber: cardNumberController.text.isNotEmpty
          ? cardNumberController.text
          : widget.payment.cardNumber,
      cvv: cvvController.text.isNotEmpty
          ? cvvController.text
          : widget.payment.cvv,
      expDate: dateController.text.isNotEmpty
          ? dateController.text
          : widget.payment.expDate,
      type: _type.isNotEmpty ? _type : widget.payment.type,
      id: widget.payment.id,
    );
    showSnackBar(message: apiResponse.message, error: !apiResponse.status);
    if (apiResponse.status) {
      navigator();
    }
  }

  void navigator() => Navigator.pop(context);
}
