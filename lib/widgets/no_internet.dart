import 'package:flutter/material.dart';

import '../constants/colors.dart';

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
            const Text(
              'Can\'t connect .. check internet',
              style: TextStyle(
                fontSize: 22,
                color: ColorsApp.gery,
              ),
            ),
            Image.asset('asset/images/no_internet.png')
          ],
        ),
      ),
    );
  }
}
