import '../../getX/payment_card_getX.dart';
import '../../widgets/view_details.dart';
import 'package:flutter/material.dart';
import '../../constants/routes.dart';
import '../../constants/colors.dart';
import '../../api/api_response.dart';
import '../../constants/fonts.dart';
import '../../widgets/loading.dart';
import '../../widgets/no_data.dart';
import '../../utils/helpers.dart';
import 'package:get/get.dart';

class ListPaymentCardsScreen extends StatefulWidget {
  const ListPaymentCardsScreen({Key? key}) : super(key: key);

  @override
  State<ListPaymentCardsScreen> createState() => _ListPaymentCardsScreenState();
}

class _ListPaymentCardsScreenState extends State<ListPaymentCardsScreen>
    with Helpers {
  final PaymentCardGetX _paymentGetX = Get.put(PaymentCardGetX());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('payment_card'.tr),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.pushNamed(context, createPaymentCardScreen),
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: GetX<PaymentCardGetX>(
        initState: (state) {
          state.controller!.getPaymentData();
        },
        builder: (controller) {
          if (_paymentGetX.loading.isTrue) {
            return const Loading();
          }
          return listPaymentCard();
        },
      ),
    );
  }

  Widget listPaymentCard() {
    if (_paymentGetX.payment!.date!.isNotEmpty) {
      return ListView.separated(
        padding: const EdgeInsetsDirectional.all(20),
        itemCount: _paymentGetX.payment!.date!.length,
        separatorBuilder: (context, index) => const SizedBox(height: 20),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => Navigator.pushNamed(
              context,
              updatePaymentCardScreen,
              arguments: _paymentGetX.payment!.date![index],
            ),
            child: Dismissible(
              key: Key(_paymentGetX.payment!.date![index].id.toString()),
              onDismissed: (direction) =>
                  deletePayment(_paymentGetX.payment!.date![index].id),
              background: Container(
                height: MediaQuery.of(context).size.height / 4,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Center(
                  child: Icon(Icons.delete, color: Colors.white, size: 50),
                ),
              ),
              child: Container(
                padding: const EdgeInsetsDirectional.only(
                  start: 16,
                  end: 16,
                  bottom: 22,
                ),
                height: MediaQuery.of(context).size.height / 4,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: _paymentGetX.payment!.date![index].type == 'Visa'
                      ? ColorsApp.blueVisa
                      : ColorsApp.blackVisa,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'asset/images/contact_less.png',
                          height: 20,
                          width: 18,
                        ),
                        Image.asset(
                          'asset/images/mastercard.png',
                          height: 50,
                          width: 50,
                        ),
                      ],
                    ),
                    ViewDetails(
                      data: _paymentGetX.payment!.date![index].cardNumber,
                      color: Colors.white,
                      fontSize: 21,
                      fontFamily: FontsApp.fontCourierPrime,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            ViewDetails(
                              data: 'CARDHOLDER',
                              color: Colors.grey,
                              fontSize: 9,
                              fontFamily: FontsApp.fontBold,
                            ),
                            ViewDetails(
                              data: 'VALID THRU',
                              color: Colors.grey,
                              fontSize: 9,
                              fontFamily: FontsApp.fontBold,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ViewDetails(
                              data:
                                  _paymentGetX.payment!.date![index].holderName,
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: FontsApp.fontBold,
                            ),
                            ViewDetails(
                              data: _paymentGetX.payment!.date![index].expDate,
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: FontsApp.fontBold,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } else {
      return const NoData();
    }
  }

  Future<void> deletePayment(int id) async {
    ApiResponse apiResponse = await _paymentGetX.deletePayment(id: id);
    showSnackBar(message: apiResponse.message, error: !apiResponse.status);
  }
}
