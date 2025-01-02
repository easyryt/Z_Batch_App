import 'package:dio/dio.dart' as Dio;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:pk_education/constant/api_end_points.dart';
import 'package:pk_education/constant/constants.dart';
import 'package:pk_education/model/profile_model.dart';
import 'package:pk_education/services/global.dart';

class ProfileController extends GetxController {
  var gender = 0.obs;
  var imgUrl = "".obs;
  var nameS = "".obs;
  var emailS = "".obs;
  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final email = TextEditingController();
  final dob = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();

  Future<ProfileData> getProfile() async {
    Dio.Response response = await Global.apiClient.getData(
      Constants.getProfileEndPoint,
      null,
    );

    if (response.statusCode == 200) {
      final data = response.data["data"];
      // if (data is Map<String, dynamic>) {
      //   return data;
      // } else {
      //   print("Error: Invalid response format");
      //   return null;
      // }
      nameS.value = data["fullName"] ?? "";
      emailS.value = data["email"] ?? "";
      return ProfileData.fromJson(data);
    } else {
      print(response.statusMessage);

      throw Exception(response.statusMessage);
    }
  }

  updateProfile(selectedImage) async {
    try {
      final Uri apiUrl = Uri.parse(
          "${ApiEndPoints.baseUrl}/${Constants.updateProfileEndPoint}");

      var request = http.MultipartRequest('PUT', apiUrl);

      request.headers['x-student-token'] =
          Global.storageServices.getString("x-student-token")!;

      request.fields['fullName'] = name.text;
      request.fields['email'] = email.text;
      request.fields['dob'] = dob.text;
      request.fields['city'] = city.text;
      request.fields['state'] = state.text;
      request.fields['gender'] = gender.value == 0
          ? "Male"
          : gender.value == 1
              ? "Female"
              : "Other";

      if (selectedImage != null) {
        var picStream = http.ByteStream(selectedImage.openRead());
        var picLength = await selectedImage.length();
        request.files.add(http.MultipartFile(
          'profilePic',
          picStream,
          picLength,
          filename: basename(selectedImage.path),
        ));
      }

      var response = await request.send();

      if (response.statusCode == 200) {
        await getProfile();
        if (kDebugMode) {
          Get.snackbar("wow", "Profile updated successfully");
          // print("Profile updated successfully");
        }
      } else {
        if (kDebugMode) {
          print("Failed to upload: ${response.statusCode}");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error uploading info: $e");
      }
    }
  }
}
