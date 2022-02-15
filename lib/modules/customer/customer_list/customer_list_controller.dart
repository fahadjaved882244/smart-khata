import 'package:get/get.dart';
import 'package:khata/data/models/customer.dart';
import 'package:khata/data/providers/customer_provider.dart';

class CustomerListController extends GetxController {
  final CustomerProvider _provider;
  CustomerListController(this._provider);

  final RxList<CustomerModel> _customers = <CustomerModel>[].obs;
  List<CustomerModel> get customers => _customers;

  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) => _isLoading(value);

  @override
  onInit() {
    _fetchCustomers();
    super.onInit();
  }

  Future<void> _fetchCustomers() async {
    isLoading = true;
    _customers.value = await _provider.fetchCustomers() ?? [];
    isLoading = false;
  }
}
