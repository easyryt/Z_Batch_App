import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pk_education/controller/pk/main_app_controller.dart';
import 'package:pk_education/services/global.dart';

class ClassesScreen extends StatefulWidget {
  const ClassesScreen({super.key});

  @override
  State<ClassesScreen> createState() => _ClassesScreenState();
}

class _ClassesScreenState extends State<ClassesScreen> {
  MainApplicationController mainApplicationController = Get.find();
  int selectedIndex = -1;

  Future<void> _getSelectedClass() async {
    final savedClassId = Global.storageServices.getString("selectedClassId");
    final savedClassName =
        Global.storageServices.getString("selectedClassName");
    if (savedClassId != null && savedClassName != null) {
      selectedIndex = mainApplicationController.classList
          .indexWhere((clas) => clas["_id"] == savedClassId);
    }
    mainApplicationController.getAllClass();
  }

  bool isLoading = false;

  @override
  void initState() {
    _getSelectedClass();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Color white = Colors.white;
    Color black = Colors.black;
    Color green = Colors.green;
    Color appColor = const Color(0xFFFD0000);
    Color lightGrey = Colors.grey.shade600;
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        surfaceTintColor: white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            size: 18,
          ),
        ),
        title: Text('Select Your Class',
            style: GoogleFonts.roboto(
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            )),
        actions: const [
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: Obx(() {
        return Stack(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: mainApplicationController.classList.length,
              itemBuilder: (context, index) {
                var clas = mainApplicationController.classList[index];
                var className = clas["clsName"] ?? "";
                var classId = clas["_id"] ?? "";
                //  var classNumber = clas["clsNum"] ?? 0;
                return GestureDetector(
                  onTap: () async {
                    await Global.storageServices
                        .setString("selectedClassId", classId ?? "");
                    await Global.storageServices.setString(
                        "selectedClassName", className ?? "Select Your Class");
                    mainApplicationController.className.value = className;
                    mainApplicationController.classId.value = classId;
                    setState(() {
                      isLoading = true;
                      selectedIndex = index;
                    });
                    await mainApplicationController
                        .getAllBatch()
                        .then((onValue) {
                      if (onValue == true) {
                        Navigator.pop(context);
                      } else {
                        Get.snackbar(
                            "Alert", "Something went wrong with GetAllBatch");
                      }
                    });
                    setState(() {
                      isLoading = false;
                    });
                  },
                  child: Container(
                    width: size.width,
                    padding: const EdgeInsetsDirectional.symmetric(
                        horizontal: 10, vertical: 12),
                    margin: const EdgeInsetsDirectional.symmetric(
                        horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: selectedIndex == index
                          ? appColor.withOpacity(0.02)
                          : white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade200,
                          blurRadius: 1,
                          spreadRadius: 0.5,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.hotel_class_outlined,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        SizedBox(
                          //   color: Colors.red,
                          width: size.width * 0.69,
                          child: Text(
                            className ?? "No class found",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          height: 22,
                          width: 22,
                          decoration: BoxDecoration(
                              // color: selectedIndex == index ? appColor : white,
                              border: Border.all(
                                color: selectedIndex == index
                                    ? appColor
                                    : Colors.grey.shade400,
                              ),
                              borderRadius: BorderRadius.circular(14)),
                          child: Container(
                            margin: const EdgeInsets.all(3),
                            height: 14,
                            width: 14,
                            decoration: BoxDecoration(
                                color:
                                    selectedIndex == index ? appColor : white,
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
            Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : const SizedBox())
          ],
        );
      }),
    );
  }
}
