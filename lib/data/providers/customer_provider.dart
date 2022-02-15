import 'package:khata/data/models/customer.dart';

class CustomerProvider {
  Future<List<CustomerModel>?> fetchCustomers() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      CustomerModel(
        name: "Hashim Naqvi",
        phoneNumber: "030044005234",
        credit: -400,
        lastActivity: DateTime.now(),
      ),
      CustomerModel(
        name: "Fahad Javed",
        phoneNumber: "030044005234",
        credit: 200,
        lastActivity: DateTime.now(),
      ),
      CustomerModel(
        name: "Ali Ahmad",
        phoneNumber: "030044005234",
        credit: 0,
        lastActivity: DateTime.now(),
      ),
      CustomerModel(
          name: "Hashim Naqvi", phoneNumber: "030044005234", credit: -400),
      CustomerModel(
          name: "Fahad Javed", phoneNumber: "030044005234", credit: 200),
      CustomerModel(name: "Ali Ahmad", phoneNumber: "030044005234", credit: 0),
      CustomerModel(
          name: "Hashim Naqvi", phoneNumber: "030044005234", credit: -400),
      CustomerModel(
          name: "Fahad Javed", phoneNumber: "030044005234", credit: 200),
      CustomerModel(name: "Ali Ahmad", phoneNumber: "030044005234", credit: 0),
    ];
  }
}
