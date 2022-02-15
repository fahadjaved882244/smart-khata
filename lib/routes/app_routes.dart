import 'package:get/get.dart';
import 'package:khata/modules/auth/components/otp_verification/otp_verification_binding.dart';
import 'package:khata/modules/auth/components/otp_verification/otp_verification_view.dart';
import 'package:khata/modules/auth/components/phone_auth/phone_auth_binding.dart';
import 'package:khata/modules/auth/components/phone_auth/phone_auth_view.dart';
import 'package:khata/modules/contact/add_contact/add_contact_view.dart';
import 'package:khata/modules/contact/contact_list/contact_list_binding.dart';
import 'package:khata/modules/contact/contact_list/contact_list_view.dart';
import 'package:khata/modules/customer/customer_detail/customer_detail_binding.dart';
import 'package:khata/modules/customer/customer_detail/customer_detail_view.dart';
import 'package:khata/modules/home/home_binding.dart';
import 'package:khata/modules/home/home_view.dart';
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
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: RouteNames.contactListView,
      page: () => const ContactListView(),
      binding: ContactListBinding(),
    ),
    GetPage(
      name: RouteNames.addContactView,
      page: () => AddContactView(),
    ),
    GetPage(
      name: RouteNames.customerDetailView,
      page: () => CustomerDetailView(),
      binding: const CustomerDetailBinding(),
    ),
  ];
}
