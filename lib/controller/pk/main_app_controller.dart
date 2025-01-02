import 'package:dio/dio.dart' as Dio;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pk_education/constant/constants.dart';
import 'package:pk_education/model/batch_description_model.dart';
import 'package:pk_education/model/class_subject_model.dart';
import 'package:pk_education/model/class_test_model.dart';
import 'package:pk_education/model/sub_dpp_pdf_model.dart';
import 'package:pk_education/model/sub_lecture_model.dart';
import 'package:pk_education/model/sub_notes_model.dart';
import 'package:pk_education/model/test_question_model.dart';
import 'package:pk_education/model/test_subject_model.dart';
import 'package:pk_education/screens/home_batch/home_page.dart';
import 'package:pk_education/screens/material/material.dart';
import 'package:pk_education/screens/my_course/my_course.dart';
import 'package:pk_education/screens/test/test.dart';
import 'package:pk_education/screens/tuition/tuition.dart';
import 'package:pk_education/services/global.dart';

class MainApplicationController extends GetxController {
  var pageIdx = 0.obs;
  var className = ''.obs;
  var classId = ''.obs;

  List<Widget> homeWidgets = [
    const HomePage(),
    const MyCourse(),
    const TestScreen(),
    const TuitionScreen(),
    const MaterialScreen(),
  ];

  var batchList = [].obs;
  //List<BatchData> batchList = [];
  Future getAllBatch() async {
    Dio.Response response = await Global.apiClient
        .getData("${Constants.getAllBatch}/${classId.value}", null);

    if (response.statusCode == 200) {
      batchList.clear();
      final orderDetailList = response.data["data"];
      // for (var item in orderDetailList) {
      //   batchList.add(BatchData.fromJson(item));
      // }
      batchList.addAll(orderDetailList);
      // return BatchModel.fromJson(jsonDecode(response.data));
      return true;
    } else {
      print(response.statusMessage);
      return false;
    }
  }

  var myCourseList = [].obs;
  Future getMyCourse() async {
    Dio.Response response =
        await Global.apiClient.getData(Constants.getMyCourse, null);

    if (response.statusCode == 200) {
      myCourseList.clear();
      final orderDetailList = response.data["data"];
      // for (var item in orderDetailList) {
      //   batchList.add(BatchData.fromJson(item));
      // }
      myCourseList.addAll(orderDetailList);
      // return BatchModel.fromJson(jsonDecode(response.data));
      return true;
    } else {
      print(response.statusMessage);
      return false;
    }
  }

  var classList = [].obs;
  Future getAllClass() async {
    Dio.Response response =
        await Global.apiClient.getData(Constants.getAllClass, null);

    if (response.statusCode == 200) {
      classList.clear();
      final orderDetailList = response.data["data"];
      classList.addAll(orderDetailList);
      if (Global.storageServices.getString("selectedClassName") == "" ||
          Global.storageServices.getString("selectedClassName") ==
              "Select Your Class" ||
          Global.storageServices.getString("selectedClassName") == null) {
        className.value = orderDetailList[0]["clsName"];
        classId.value = orderDetailList[0]["_id"];
        await Global.storageServices
            .setString("selectedClassId", orderDetailList[0]["_id"] ?? "");
        await Global.storageServices.setString("selectedClassName",
            orderDetailList[0]["clsName"] ?? "Select Your Class");
      } else {
        int? matchingIndex =
            classList.indexWhere((clas) => clas["_id"] == classId.value);
        if (matchingIndex != null && matchingIndex >= 0) {
        } else {
          className.value = orderDetailList[0]["clsName"];
          classId.value = orderDetailList[0]["_id"];
          await Global.storageServices
              .setString("selectedClassId", orderDetailList[0]["_id"] ?? "");
          await Global.storageServices.setString("selectedClassName",
              orderDetailList[0]["clsName"] ?? "Select Your Class");
        }
      }
      return true;
    } else {
      print(response.statusMessage);
      return false;
    }
  }

  Future<DescriptionData> getBatchDescriptionDetail(batchId) async {
    Dio.Response response = await Global.apiClient
        .getData("${Constants.getBatchDescription}/$batchId", null);

    if (response.statusCode == 200) {
      final batchDescriptionList = response.data["data"];

      return DescriptionData.fromJson(batchDescriptionList);
    } else {
      print(response.statusMessage);

      throw Exception(response.statusMessage);
    }
  }

  Future<ClassSubjectModel> getBatchAllSubject(batchId) async {
    Dio.Response response = await Global.apiClient
        .getData("${Constants.getBatchAllSubject}/$batchId", null);

    if (response.statusCode == 200) {
      final allSubjectList = response.data;
      // List subList = [];
      // subList = allSubjectList;
      return ClassSubjectModel.fromJson(allSubjectList);
    } else {
      print(response.statusMessage);

      throw Exception(response.statusMessage);
    }
  }

  Future<ClassTestModel> getBatchTestSubject(batchId) async {
    Dio.Response response = await Global.apiClient
        .getData("${Constants.getBatchTestSubject}/$batchId", null);

    if (response.statusCode == 200) {
      final allTestList = response.data;
      return ClassTestModel.fromJson(allTestList);
    } else {
      print(response.statusMessage);

      throw Exception(response.statusMessage);
    }
  }

  Future<TestSubjectModel> getAllTest(subId) async {
    Dio.Response response = await Global.apiClient
        .getData("${Constants.getBatchAllTest}/$subId", null);

    if (response.statusCode == 200) {
      final allTestList = response.data;
      return TestSubjectModel.fromJson(allTestList);
    } else {
      print(response.statusMessage);

      throw Exception(response.statusMessage);
    }
  }

  Future<TestQuestionModel> getTestQuestion(testId) async {
    Dio.Response response = await Global.apiClient
        .getData("${Constants.getAllQuestion}/$testId", null);

    if (response.statusCode == 200) {
      final allTestList = response.data;
      return TestQuestionModel.fromJson(allTestList);
    } else {
      print(response.statusMessage);

      throw Exception(response.statusMessage);
    }
  }

  Future<SubjectLectureModel> getSubLecture(subId) async {
    Dio.Response response = await Global.apiClient
        .getData("${Constants.getSubjectLecture}/$subId", null);

    if (response.statusCode == 200) {
      final batchDescriptionList = response.data;

      return SubjectLectureModel.fromJson(batchDescriptionList);
    } else {
      print(response.statusMessage);

      throw Exception(response.statusMessage);
    }
  }

  Future<SubjectNotesModel> getSubNotes(subId) async {
    Dio.Response response = await Global.apiClient.getData(
        "${Constants.getSubjectLecture}/$subId?contentType=Notes", null);

    if (response.statusCode == 200) {
      final batchNotesList = response.data;

      return SubjectNotesModel.fromJson(batchNotesList);
    } else {
      print(response.statusMessage);

      throw Exception(response.statusMessage);
    }
  }

  Future<SubjectDPPPDFModel> getSubDPPPDF(subId) async {
    Dio.Response response = await Global.apiClient.getData(
        "${Constants.getSubjectLecture}/$subId?contentType=DPP PDF", null);

    if (response.statusCode == 200) {
      final batchNotesList = response.data;

      return SubjectDPPPDFModel.fromJson(batchNotesList);
    } else {
      print(response.statusMessage);

      throw Exception(response.statusMessage);
    }
  }

  Future buyBatch(batchId) async {
    Dio.Response response = await Global.apiClient
        .postData("${Constants.buyBatch}/$batchId", {}, null);

    if (response.statusCode == 200 || response.statusCode == 201) {
      //  final batchNotesList = response.data;
      await getAllBatch();
      await getMyCourse();
      Get.snackbar("wow", "You Have Successfully Buy This Batch");
      return true;
    } else {
      print(response.statusMessage);

      return false;
    }
  }
}
