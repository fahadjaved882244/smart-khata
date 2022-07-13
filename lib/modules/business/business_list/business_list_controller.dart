import 'dart:async';

import 'package:khata/data/models/business.dart';
import 'package:khata/data/providers/business_provider.dart';
import 'package:khata/modules/components/controllers/i_list_controller.dart';

class BusinessListController extends IListController<BusinessModel> {
  final String businessId;
  BusinessListController(this.businessId);

  @override
  void subsribeToStream() {
    isLoading = true;
    dataStream = BusinessProvider.watchAll().listen((event) {
      dataList = event;
      isLoading = false;
    });
  }

  Future<void> deleteSelected() async {
    isLoading = true;
    final List<Future> list = [];
    for (final business in selectedItems) {
      list.add(BusinessProvider.delete(business.id));
    }
    isSelectable = false;
    await Future.wait(list);
    selectedItems.clear();
    isLoading = false;
  }
}
