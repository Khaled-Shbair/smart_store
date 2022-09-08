import 'package:flutter/material.dart';
import '../../constants/routes.dart';
import 'package:get/get.dart';

class ListPaymentCardsScreen extends StatefulWidget {
  const ListPaymentCardsScreen({Key? key}) : super(key: key);

  @override
  State<ListPaymentCardsScreen> createState() => _ListPaymentCardsScreenState();
}

class _ListPaymentCardsScreenState extends State<ListPaymentCardsScreen> {
  // TODO: ( updatePaymentCardScreen )
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
      body: ListView.separated(
        itemCount: 10,
        separatorBuilder: (context, index) => const SizedBox(height: 20),
        itemBuilder: (context, index) {
          return const Center();
        },
      ),
    );
  }
}
