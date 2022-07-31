import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_lock/flutter_app_lock.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:khata/data/providers/auth_provider.dart';
import 'package:khata/data/providers/user_provider.dart';
import 'package:khata/modules/auth/auth_controller.dart';
import 'package:khata/modules/components/popups/custom_screen_lock.dart';
import 'package:khata/routes/app_routes.dart';
import 'package:khata/routes/route_names.dart';
import 'package:khata/themes/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await GetStorage.init();
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate();
  final auth =
      Get.put(AuthController(AuthProvider(UserProvider())), permanent: true);
  bool userFound = false;
  if (await auth.getUser() != null) {
    userFound = true;
  }

  runApp(AppLock(
    builder: (args) => App(userFound),
    lockScreen: const CustomScreenLock(),
    enabled: userFound,
  ));
}

class App extends StatelessWidget {
  final bool userFound;
  const App(this.userFound, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: GetMaterialApp(
        title: 'Khata App',
        initialRoute:
            userFound ? RouteNames.splashScreenView : RouteNames.phoneAuthView,
        getPages: AppRoutes.routes,
        defaultTransition: Transition.fade,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        themeMode: ThemeMode.light,
      ),
    );
  }
}
