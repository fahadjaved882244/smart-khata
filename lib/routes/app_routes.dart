import 'package:get/get.dart';
import 'package:khata/modules/auth/components/phone_auth/components/otp_verification_view.dart';
import 'package:khata/modules/auth/components/phone_auth/phone_auth_binding.dart';
import 'package:khata/modules/auth/components/phone_auth/phone_auth_view.dart';
import 'package:khata/modules/business/add_business/add_business_binding.dart';
import 'package:khata/modules/business/add_business/add_business_view.dart';
import 'package:khata/modules/business/business_list/business_list_view.dart';
import 'package:khata/modules/business/update_business/update_business_view.dart';
import 'package:khata/modules/contact/contact_list/contact_list_binding.dart';
import 'package:khata/modules/contact/contact_list/contact_list_view.dart';
import 'package:khata/modules/customer/add_customer/add_customer_view.dart';
import 'package:khata/modules/customer/customer_detail/customer_detail_view.dart';
import 'package:khata/modules/customer/customer_list/customer_list_view.dart';
import 'package:khata/modules/customer/update_customer/update_customer_view.dart';
import 'package:khata/modules/splash_screen/splash_screen_binding.dart';
import 'package:khata/modules/splash_screen/splash_screen_view.dart';
import 'package:khata/modules/transaction/add_transaction/add_transaction_binding.dart';
import 'package:khata/modules/transaction/add_transaction/add_transaction_view.dart';
import 'package:khata/modules/transaction/update_transaction/update_transaction_view.dart';
import 'package:khata/routes/route_names.dart';

class AppRoutes {
  static final routes = [
    GetPage(
      name: RouteNames.splashScreenView,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),

    //////
    GetPage(
      name: RouteNames.phoneAuthView,
      page: () => const PhoneAuthView(),
      binding: PhoneAuthBinding(),
    ),
    GetPage(
      name: RouteNames.otpVerificationView,
      page: () => const OtpVerificationView(),
    ),

    //////
    GetPage(
      name: RouteNames.addBusinessView,
      page: () => const AddBusinessView(),
      binding: AddBusinessBinding(),
    ),
    GetPage(
      name: RouteNames.businessListView,
      page: () => BusinessListView(),
    ),
    GetPage(
      name: RouteNames.updateBusinessView,
      page: () => UpdateBusinessView(),
    ),

    ////////
    GetPage(
      name: RouteNames.contactListView,
      page: () => ContactListView(),
      binding: ContactListBinding(),
    ),

    /////
    GetPage(
      name: RouteNames.addCustomerView,
      page: () => AddCustomerView(),
    ),
    GetPage(
      name: RouteNames.customerListView,
      page: () => CustomerListView(),
    ),
    GetPage(
      name: RouteNames.customerDetailView,
      page: () => CustomerDetailView(),
    ),
    GetPage(
      name: RouteNames.updateCustomerView,
      page: () => UpdateCustomerView(),
    ),

    ////
    GetPage(
      name: RouteNames.addTransactionView,
      page: () => AddTransactionView(),
      binding: const AddTransactionBinding(),
    ),
    GetPage(
      name: RouteNames.updateTransactionView,
      page: () => UpdateTransactionView(),
    ),
  ];
}
