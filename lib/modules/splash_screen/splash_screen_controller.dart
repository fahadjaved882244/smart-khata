import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:khata/data/providers/business_provider.dart';
import 'package:khata/routes/route_names.dart';

class SplashScreenController extends GetxController {
  @override
  onReady() async {
    super.onReady();
    await navigateForward();
  }

  Future<void> navigateForward() async {
    final box = GetStorage();
    final String? bid = box.read('businessId');
    if (bid != null) {
      Get.offAllNamed(
        RouteNames.customerListView,
        parameters: {'businessId': bid},
      );
    } else {
      final list = await BusinessProvider.getAll();
      if (list != null && list.isEmpty) {
        Get.offAllNamed(RouteNames.addBusinessView);
      } else if (list != null && list.isNotEmpty) {
        await box.write('businessId', list[0].id);
        Get.offAllNamed(
          RouteNames.customerListView,
          parameters: {'businessId': list[0].id},
        );
      }
    }
  }
}
