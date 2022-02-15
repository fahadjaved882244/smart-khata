import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khata/themes/app_theme.dart';

Future<bool> showCustomDialog({
  required BuildContext context,
  required String title,
  required String subTitle,
  String? leftButtonTitle,
  Color? leftButtonColor = AppColors.errorRed,
  void Function()? leftButtonAction,
  String? rightButtonTitle,
  Color? rightButtonColor = AppColors.blue,
  void Function()? rightButtonAction,
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(subTitle),
      actions: [
        if (leftButtonTitle != null)
          TextButton(
            child: Text(
              leftButtonTitle,
              style: TextStyle(
                  color: leftButtonColor ?? AppColors.blue, fontSize: 17),
            ),
            onPressed: leftButtonAction ??
                () {
                  Get.back(result: true);
                },
          ),
        if (rightButtonTitle != null)
          TextButton(
            child: Text(
              rightButtonTitle,
              style: TextStyle(
                  color: rightButtonColor ?? AppColors.blue, fontSize: 17),
            ),
            onPressed: rightButtonAction ??
                () {
                  Get.back(result: false);
                },
          ),
      ],
    ),
  );
  return result ?? false;
}
