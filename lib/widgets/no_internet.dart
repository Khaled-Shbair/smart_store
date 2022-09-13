import 'package:flutter/material.dart';
import '../constants/colors.dart';
import 'view_details.dart';

class NoInterNet extends StatelessWidget {
  const NoInterNet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Image.asset('asset/images/no_internet.png'),
            const ViewDetails(
              data: 'Can\'t connect .. check internet',
              fontSize: 18,
              color: ColorsApp.gery,
            ),
          ],
        ),
      ),
    );
  }
}
