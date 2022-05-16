import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:khata/data/models/contact.dart';

class ContactListController extends GetxController {
  final RxList<ContactModel> _contacts = <ContactModel>[].obs;
  List<ContactModel> get contacts => _contacts;

  final RxBool _permissionDenied = false.obs;
  bool get permissionDenied => _permissionDenied.value;

  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) => _isLoading(value);

  @override
  onInit() {
    _fetchContacts();
    super.onInit();
  }

  Future _fetchContacts() async {
    isLoading = true;
    if (!await FlutterContacts.requestPermission(readonly: true)) {
      _permissionDenied.value = true;
    } else {
      final conList = await FlutterContacts.getContacts(withProperties: true);
      _contacts.value = conList.map((c) {
        return ContactModel(
          name: c.displayName,
          phone: c.phones.isNotEmpty ? c.phones[0].number : null,
        );
      }).toList();
    }
    isLoading = false;
  }
}
