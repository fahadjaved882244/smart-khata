// import 'package:flutter/material.dart';

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_lock/flutter_app_lock.dart';
import 'package:khata/modules/components/buttons/custom_filled_button.dart';
import 'package:khata/modules/components/popups/custom_snack_bar.dart';
import 'package:khata/modules/components/scaffolds/base_scaffold.dart';
import 'package:khata/themes/app_sizes.dart';
import 'package:khata/themes/app_theme.dart';
import 'package:khata/themes/light_theme.dart';
import 'package:local_auth/local_auth.dart';

class CustomScreenLock extends StatefulWidget {
  const CustomScreenLock({Key? key}) : super(key: key);

  @override
  State<CustomScreenLock> createState() => _CustomScreenLock();
}

class _CustomScreenLock extends State<CustomScreenLock> {
  final LocalAuthentication auth = LocalAuthentication();

  @override
  void initState() {
    super.initState();
    auth.isDeviceSupported().then(
      (bool isSupported) {
        _authenticate();
      },
    );
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
        localizedReason: 'Verify your indentity',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
    } on PlatformException catch (e) {
      showCustomSnackBar(message: e.toString(), isError: true);
    } finally {
      if (authenticated) {
        AppLock.of(context)?.didUnlock();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Theme(
        data: LightAppTheme.themeData,
        child: BaseScaffold(
            centerTitle: true,
            automaticallyImplyLeading: false,
            resizeToAvoidBottomInset: false,
            backgroundColor: AppColors.white,
            title: 'Smart-Khata',
            child: ListView(
              children: [
                const SizedBox(height: AppSizes.largePadding),
                Image.asset('assets/general/pin_otp.gif'),
                const SizedBox(height: AppSizes.mediumPadding),
                CustomFilledButton(
                  onPressed: _authenticate,
                  text: 'Authenticate',
                  icon: const Icon(Icons.lock_open),
                ),
              ],
            )),
      ),
    );
  }
}
