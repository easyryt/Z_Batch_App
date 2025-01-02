import 'dart:ui';

class Constants {
  //----------------------------------------------------------------
  static const String generateOtpEndPoint = "student/auth/register";
  static const String verifyOtpEndPoint = "student/auth/verify";
  static const String getProfileEndPoint = "student/auth/getProfile";
  static const String updateProfileEndPoint = "student/auth/updateProfile";
  static const String getAllClass = "student/classes/getAll";
  static const String getAllBatch = "student/course/batches/getAll";
  static const String getMyCourse = "student/batch/payment/history";

  static const String getBatchDescription = "student/batches/discription/get";
  static const String getBatchAllSubject =
      "student/batches/allClass/subject/getAll";
  static const String getBatchTestSubject =
      "student/batches/test/subject/getAll";
  static const String getBatchAllTest = "student/batch/subjects/test/getAll";
  static const String getAllQuestion = "student/batch/subjects/test/get";
  static const String getSubjectLecture =
      "student/allClass/subjects/contents/getAll";
  static const String buyBatch = "student/batch/payment/create";
  static const String userAllAddressesEndPoint = "consumer/address/getAll";
  static const String addProductToCartEndPoint = "consumer/kart/addProduct";
  static const String removeProductToCartEndPoint =
      "consumer/kart/removeQuntityProduct";
  static const String floorUpdateProductToCartEndPoint =
      "consumer/kart/updateFloor";
  static const String checkOutProductToCartEndPoint = "consumer/kart/checkOut";
  static const String createOrderEndPoint = "consumer/order/create";
  static const String getAllOrdersEndPoint = "consumer/order/history";
  static const String getOrderDetailsEndPoint = "consumer/order/summary";
  static const String getCouponCodeEndPoint =
      "consumer/couponCode/listCouponCode";
  static const String seceretKey = "consumer/order/seceretKey";
  static const String verifyPayment = "consumer/order/verifyPayment";

  //----------------------------------------------------------------
  static Color primaryColor = const Color(0xFFFD0000);
  static Color lightTextColor = const Color(0xFF585858);
  static Color blackTextColor = const Color(0xFF000000);
}
