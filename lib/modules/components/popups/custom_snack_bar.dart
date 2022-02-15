import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:khata/themes/app_sizes.dart';
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
      borderRadius: AppSizes.buttonRadius,
      margin: const EdgeInsets.all(AppSizes.exSmallPadding),
      borderColor: isError
          ? AppColors.red
          : isSuccess
              ? AppColors.green
              : AppColors.transparent,
      icon: isError
          ? const Icon(Icons.error_outline, color: AppColors.red)
          : isSuccess
              ? const Icon(Icons.check, color: AppColors.green)
              : null,
    ),
  );
}
