import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<int> showCustomOptionDialog({
  required BuildContext context,
  required String title,
  required Map<int, String> options,
  String? leftButtonTitle = "Cancel",
  void Function()? leftButtonAction,
  String? rightButtonTitle = "Ok",
  void Function()? rightButtonAction,
  int initialValue = -1,
}) async {
  final result = await showDialog<int>(
    context: context,
    useRootNavigator: false,
    builder: (context) => _RadioGroup(
      title: title,
      optionList: options,
      leftButtonTitle: leftButtonTitle,
      rightButtonTitle: rightButtonTitle,
      leftButtonAction: leftButtonAction,
      rightButtonAction: rightButtonAction,
      initialValue: initialValue,
    ),
  );
  return result ?? -1;
}

class _RadioGroup extends StatefulWidget {
  final String title;
  final Map<int, String> optionList;
  final String? leftButtonTitle;
  final void Function()? leftButtonAction;
  final String? rightButtonTitle;
  final void Function()? rightButtonAction;
  final int initialValue;

  const _RadioGroup({
    Key? key,
    required this.optionList,
    required this.title,
    this.leftButtonAction,
    this.rightButtonAction,
    this.leftButtonTitle,
    this.rightButtonTitle,
    required this.initialValue,
  }) : super(key: key);
  @override
  State<_RadioGroup> createState() => _RadioGroupState();
}

class _RadioGroupState extends State<_RadioGroup> {
  int? groupValue = -1;

  @override
  void initState() {
    super.initState();
    groupValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(),
          ...widget.optionList.entries.map((e) => ListTile(
                title: Text(e.value),
                leading: Radio<int>(
                  value: e.key,
                  groupValue: groupValue,
                  onChanged: (v) => setState(() => groupValue = v),
                ),
                onTap: () => setState(() => groupValue = e.key),
              )),
          const Divider(),
        ],
      ),
      actions: [
        if (widget.leftButtonTitle != null)
          TextButton(
            onPressed: widget.leftButtonAction ?? () => Get.back(result: -1),
            child: Text(widget.leftButtonTitle!),
          ),
        if (widget.rightButtonTitle != null)
          TextButton(
            onPressed: groupValue != -1
                ? widget.rightButtonAction ?? () => Get.back(result: groupValue)
                : null,
            child: Text(widget.rightButtonTitle!),
          ),
      ],
    );
  }
}
