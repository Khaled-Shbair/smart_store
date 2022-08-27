import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constants/colors.dart';

mixin Helpers {
  void showSnackBar({required String message, bool error = false}) {
    Fluttertoast.showToast(
      msg: message,
      fontSize: 16,
      timeInSecForIosWeb: 5,
      textColor: Colors.white,
      gravity: ToastGravity.SNACKBAR,
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: error ? MyColors.red : MyColors.green,
    );
  }
}
