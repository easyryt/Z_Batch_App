import 'package:get/get.dart';
import 'package:pk_education/controller/pk/main_app_controller.dart';

class HomeController extends GetxController {
  var currentIndex = 0.obs;
  var currentPlace = "Enable Your Location".obs;
  var currentPinCode = "Tap here".obs;
  var lat = 0.0.obs;
  var lng = 0.0.obs;
  var allWithOutBulkProduct = [].obs;
  var allWithBulkProduct = [].obs;
  var isLoading = false.obs;
  MainApplicationController mainApplicationController = Get.find();

  @override
  void onInit() {
    iniFunction();
    super.onInit();
  }

  iniFunction() async {
    await mainApplicationController.getAllClass();
    await mainApplicationController.getAllBatch();
    await mainApplicationController.getMyCourse();
  }

  void changeSliderIndex(int index) {
    currentIndex.value = index;
  }

  var selectedFilter = 'This Year'.obs;

  void updateFilter(String filter) {
    selectedFilter.value = filter;
  }
}
