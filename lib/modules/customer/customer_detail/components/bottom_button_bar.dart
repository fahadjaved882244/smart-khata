import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khata/data/models/customer.dart';
import 'package:khata/routes/route_names.dart';
import 'package:khata/themes/app_sizes.dart';
import 'package:khata/themes/app_theme.dart';

class BottomButtonBar extends StatelessWidget {
  final CustomerModel customer;
  const BottomButtonBar({
    Key? key,
    required this.customer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.smallPadding),
      child: Row(
        children: [
          Flexible(
            child: SizedBox(
              height: AppSizes.tabHeight,
              child: ElevatedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.add),
                    SizedBox(width: 8),
                    Text("You Got"),
                  ],
                ),
                onPressed: () {
                  Get.toNamed(
                    RouteNames.addTransactionView,
                    arguments: [customer, true],
                  );
                },
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(3),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSizes.cardRadius),
                  )),
                  backgroundColor: MaterialStateProperty.all(AppColors.green),
                  foregroundColor: MaterialStateProperty.all(AppColors.white),
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSizes.smallPadding),
          Flexible(
            child: SizedBox(
              height: AppSizes.tabHeight,
              child: ElevatedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.remove),
                    SizedBox(width: 8),
                    Text("You Gave"),
                  ],
                ),
                onPressed: () {
                  Get.toNamed(
                    RouteNames.addTransactionView,
                    arguments: [customer, false],
                  );
                },
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(3),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSizes.cardRadius),
                  )),
                  backgroundColor: MaterialStateProperty.all(AppColors.red),
                  foregroundColor: MaterialStateProperty.all(AppColors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
