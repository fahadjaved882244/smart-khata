import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<bool> showCustomDialog({
  required BuildContext context,
  required String title,
  required String subTitle,
  String? leftButtonTitle = "Cancel",
  void Function()? leftButtonAction,
  String? rightButtonTitle = "Ok",
  void Function()? rightButtonAction,
}) async {
  final result = await showDialog<bool>(
    context: context,
    useRootNavigator: false,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(subTitle),
      actions: [
        if (leftButtonTitle != null)
          TextButton(
            onPressed: leftButtonAction ??
                () {
                  Get.back(result: false, closeOverlays: true);
                },
            child: Text(leftButtonTitle),
          ),
        if (rightButtonTitle != null)
          TextButton(
            onPressed: rightButtonAction ??
                () {
                  Get.back(result: true, closeOverlays: true);
                },
            child: Text(rightButtonTitle),
          ),
      ],
    ),
  );
  return result ?? false;
}
