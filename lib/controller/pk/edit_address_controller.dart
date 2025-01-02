import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class EditAddressController extends GetxController {
  var saveAsNumber = 0.obs;

  TextEditingController fullNameTextController = TextEditingController();
  TextEditingController deliveryAddressTextController = TextEditingController();
  TextEditingController streetTextController = TextEditingController();
  TextEditingController landmarkTextController = TextEditingController();
  TextEditingController mobileNumberTextController = TextEditingController();
  TextEditingController alternateMobileNumberTextController =
      TextEditingController();
  TextEditingController pinCodeTextController = TextEditingController();
  TextEditingController localityTextController = TextEditingController();
  TextEditingController villageAreaTextController = TextEditingController();
  TextEditingController houseTextController = TextEditingController();
  TextEditingController blockTextController = TextEditingController();
}
