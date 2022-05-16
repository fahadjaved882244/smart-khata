import 'package:flutter/material.dart';

Future<DateTime?> showCustomDatePicker(
    BuildContext context, DateTime initialDate) async {
  return showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: DateTime(2000),
    lastDate: DateTime.now(),
  );
}
