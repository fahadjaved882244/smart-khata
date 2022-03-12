import 'package:get/get.dart';
import 'package:khata/modules/auth/components/otp_verification/otp_verification_binding.dart';
import 'package:khata/modules/auth/components/otp_verification/otp_verification_view.dart';
import 'package:khata/modules/auth/components/phone_auth/phone_auth_binding.dart';
import 'package:khata/modules/auth/components/phone_auth/phone_auth_view.dart';
import 'package:khata/modules/contact/contact_list/contact_list_binding.dart';
import 'package:khata/modules/contact/contact_list/contact_list_view.dart';
import 'package:khata/modules/customer/add_customer/add_customer_view.dart';
import 'package:khata/modules/customer/customer_detail/customer_detail_view.dart';
import 'package:khata/modules/customer/customer_list/customer_list_binding.dart';
import 'package:khata/modules/customer/customer_list/customer_list_view.dart';
import 'package:khata/modules/transaction/add_transaction/add_transaction_binding.dart';
import 'package:khata/modules/transaction/add_transaction/add_transaction_view.dart';
import 'package:khata/routes/route_names.dart';

class AppRoutes {
  static final routes = [
    GetPage(
      name: RouteNames.phoneAuthView,
      page: () => const PhoneAuthView(),
      binding: PhoneAuthBinding(),
    ),
    GetPage(
      name: RouteNames.otpVerificationView,
      page: () => const OtpVerificationView(),
      binding: OtpVerificationBinding(),
    ),

    ////////
    GetPage(
      name: RouteNames.homeView,
      page: () => const CustomerListView(),
      binding: CustomerListBinding(),
    ),
    GetPage(
      name: RouteNames.contactListView,
      page: () => const ContactListView(),
      binding: ContactListBinding(),
    ),
    GetPage(
      name: RouteNames.addCustomerView,
      page: () => AddCustomerView(),
    ),
    GetPage(
      name: RouteNames.customerDetailView,
      page: () => CustomerDetailView(),
    ),
    GetPage(
      name: RouteNames.addTransactionView,
      page: () => AddTransactionView(),
      binding: const AddTransactionBinding(),
    ),
  ];
}
