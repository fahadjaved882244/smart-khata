import 'package:flutter/material.dart';

class AppLogoText extends StatelessWidget {
  const AppLogoText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context)
            .textTheme
            .headline6!
            .copyWith(fontWeight: FontWeight.bold),
        children: [
          TextSpan(
            text: "Smart-",
            style: TextStyle(color: Theme.of(context).colorScheme.outline),
          ),
          TextSpan(
            text: "Khata",
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
        ],
      ),
    );
  }
}
