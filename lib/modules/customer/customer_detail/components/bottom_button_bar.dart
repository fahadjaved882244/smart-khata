import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khata/routes/route_names.dart';
import 'package:khata/themes/app_sizes.dart';
import 'package:khata/themes/app_theme.dart';

class BottomButtonBar extends StatelessWidget {
  final String businessId;
  final String customerId;
  const BottomButtonBar({
    Key? key,
    required this.businessId,
    required this.customerId,
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
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(3),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSizes.cardRadius),
                  )),
                  backgroundColor: MaterialStateProperty.all(AppColors.green),
                  foregroundColor: MaterialStateProperty.all(AppColors.white),
                ),
                onPressed: () {
                  Get.toNamed(
                    RouteNames.addTransactionView,
                    parameters: {
                      'businessId': businessId,
                      'customerId': customerId,
                    },
                    arguments: true,
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.add),
                    SizedBox(width: 8),
                    Text("You Got"),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSizes.smallPadding),
          Flexible(
            child: SizedBox(
              height: AppSizes.tabHeight,
              child: ElevatedButton(
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(3),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSizes.cardRadius),
                  )),
                  backgroundColor: MaterialStateProperty.all(AppColors.red),
                  foregroundColor: MaterialStateProperty.all(AppColors.white),
                ),
                onPressed: () {
                  Get.toNamed(
                    RouteNames.addTransactionView,
                    parameters: {
                      'businessId': businessId,
                      'customerId': customerId,
                    },
                    arguments: false,
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.remove),
                    SizedBox(width: 8),
                    Text("You Gave"),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
