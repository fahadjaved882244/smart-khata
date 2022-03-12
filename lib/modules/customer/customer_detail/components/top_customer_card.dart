import 'package:flutter/material.dart';
import 'package:khata/data/models/customer.dart';
import 'package:khata/modules/components/buttons/custom_filled_button.dart';
import 'package:khata/themes/app_sizes.dart';
import 'package:khata/themes/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class TopCustomerCard extends StatelessWidget {
  final double credit;
  final CustomerModel customer;
  const TopCustomerCard(
      {Key? key, required this.customer, required this.credit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hasPhNum = customer.phoneNumber != null;

    return Card(
      elevation: 5,
      shape: const RoundedRectangleBorder(),
      child: SizedBox(
        height: credit == 0 ? 80 : 120,
        child: Padding(
          padding: const EdgeInsets.only(
            left: AppSizes.exSmallPadding,
            right: AppSizes.exSmallPadding,
            bottom: AppSizes.smallPadding,
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (credit != 0) _totalCard(context, credit),
                const SizedBox(height: AppSizes.exSmallPadding),
                _buttonBar(hasPhNum),
              ]),
        ),
      ),
    );
  }

  Flexible _buttonBar(bool hasPhNum) {
    return Flexible(
      flex: 4,
      child: Row(
        children: [
          Flexible(
            child: CustomFilledButton(
              elevation: 2,
              heightScale: 0,
              borderRadius: AppSizes.cardRadius,
              icon: const Icon(
                Icons.picture_as_pdf_rounded,
                color: AppColors.red,
              ),
              onPressed: () async {},
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            flex: 2,
            child: CustomFilledButton(
              elevation: 2,
              borderRadius: AppSizes.cardRadius,
              heightScale: 0,
              text: "WhatsApp",
              icon: Icon(
                Icons.whatsapp,
                color: hasPhNum ? AppColors.green : AppColors.darkGray,
              ),
              onPressed: () async {
                if (hasPhNum &&
                    await canLaunch(
                        'whatsapp://send?phone=${customer.phoneNumber}')) {
                  await launch('whatsapp://send?phone=${customer.phoneNumber}');
                }
              },
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            flex: 2,
            child: CustomFilledButton(
              elevation: 2,
              heightScale: 0,
              borderRadius: AppSizes.cardRadius,
              text: "SMS",
              icon: Icon(
                Icons.sms_rounded,
                color: hasPhNum ? AppColors.blue : AppColors.darkGray,
              ),
              onPressed: () async {
                if (hasPhNum &&
                    await canLaunch('sms:${customer.phoneNumber}')) {
                  await launch('sms:${customer.phoneNumber}');
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Flexible _totalCard(BuildContext context, double amount) {
    return Flexible(
      flex: 3,
      fit: FlexFit.tight,
      child: Card(
        color: Theme.of(context).colorScheme.surface,
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: AppSizes.smallPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(amount.isNegative ? "You Will Get" : "You Will Give"),
              Text(
                "Rs. ${amount.toInt()}",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: amount.isNegative ? AppColors.red : AppColors.green),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
