import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainSnackBar {
  static handleSnackBar(String message, {Color? backgroundColor}) {
    return Get.snackbar(
      '',
      message,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      snackPosition: SnackPosition.TOP,
      backgroundColor: backgroundColor ?? Colors.red,
      borderRadius: 8,
      margin: const EdgeInsets.all(12),
      colorText: Colors.white,
      duration: const Duration(seconds: 4),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }
}
