import 'dart:async';
import 'package:get/get.dart';

abstract class IListController<M> extends GetxController {
  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) => _isLoading(value);

  final RxList<M> _list = <M>[].obs;
  List<M> get dataList => _list;
  set dataList(List<M> list) => _list.value = list;

  final RxBool _isSelectable = false.obs;
  bool get isSelectable => _isSelectable.value;
  set isSelectable(value) => _isSelectable(value);

  final RxList<M> _selectedItems = <M>[].obs;
  List<M> get selectedItems => _selectedItems;

  late final StreamSubscription<List<M>> dataStream;

  @override
  void onInit() {
    super.onInit();
    subsribeToStream();
  }

  @override
  void onClose() {
    dataStream.cancel();
    super.onClose();
  }

  void subsribeToStream();

  void selectItem(M value) {
    if (selectedItems.contains(value)) {
      selectedItems.remove(value);
    } else {
      selectedItems.add(value);
    }
  }
}
