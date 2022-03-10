import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:khata/themes/app_theme.dart';

SnackbarController showCustomSnackBar<T>({
  final String? title,
  required final String message,
  final bool isError = false,
  final bool isSuccess = false,
}) {
  return Get.showSnackbar(
    GetSnackBar(
      title: title,
      message: message,
      duration: Duration(seconds: isSuccess ? 3 : 5),
      animationDuration: const Duration(milliseconds: 500),
      backgroundColor: isError
          ? AppColors.red
          : isSuccess
              ? AppColors.green
              : AppColors.black,
      icon: isError
          ? const Icon(Icons.error_outline, color: AppColors.white)
          : isSuccess
              ? const Icon(Icons.check, color: AppColors.white)
              : null,
    ),
  );
}
