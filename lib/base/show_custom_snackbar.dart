import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/big_text.dart';

void showCustomSnackBar(String message,
    {bool isError = true, String title = 'Error',}) {
  Get.snackbar(title, message,
      titleText: BigText(
        text: title,
        textColor: Colors.white,
      ),
      messageText: Text(
        message,
        style: TextStyle(
          color: Colors.white
        ),
      ),
    colorText: Colors.white,
    snackPosition: SnackPosition.TOP,
    backgroundColor: isError?Colors.redAccent:Colors.greenAccent
  );
}
