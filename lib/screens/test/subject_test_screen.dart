import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pk_education/controller/pk/main_app_controller.dart';
import 'package:pk_education/model/test_subject_model.dart';
import 'package:pk_education/screens/test/intro_test.dart';

class SubjectTestScreen extends StatefulWidget {
  final String subId;
  final String subName;
  const SubjectTestScreen({
    super.key,
    required this.subId,
    required this.subName,
  });

  @override
  State<SubjectTestScreen> createState() => _SubjectTestScreenState();
}

class _SubjectTestScreenState extends State<SubjectTestScreen> {
  MainApplicationController mainApplicationController = Get.find();
  TestSubjectModel? testSubjectModel;

  @override
  void initState() {
    _fetchAllTest();
    super.initState();
  }

  Future<void> _fetchAllTest() async {
    try {
      final data = await mainApplicationController.getAllTest(widget.subId);
      if (mounted) {
        setState(() {
          testSubjectModel = data;
        });
      }
    } catch (error) {
      print("Error fetching data: $error");
    }
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
        leadingWidth: 24,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              size: 18,
            ),
          ),
        ),
        title: Text("${widget.subName} MCQ List",
            style: GoogleFonts.roboto(
              textStyle: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            )),
        actions: const [
          // Icon(FontAwesomeIcons.whatsapp),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: (testSubjectModel?.data?.length != 0 &&
              testSubjectModel?.data?.length != null)
          ? Padding(
              padding: const EdgeInsets.only(
                  left: 14, right: 14, bottom: 16, top: 2),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                      itemCount: testSubjectModel?.data?.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var item = testSubjectModel?.data![index];
                        return GestureDetector(
                          onTap: () {
                            Get.to(() => IntroTest(
                                  testId: item!.sId!,
                                  testName: item.name!,
                                ));
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                                bottom: 16, left: 2, right: 2),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey[300]!,
                                  blurRadius: 1,
                                  spreadRadius: 1,
                                  offset: const Offset(0, 0),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                const SizedBox(height: 10),
                                const Icon(
                                  Icons.calendar_month,
                                  size: 40,
                                  color: Colors.black54,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, right: 8, left: 8, bottom: 10),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        width: size.width * 0.8,
                                        child: Center(
                                          child: Text("${item?.name}",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.roboto(
                                                textStyle: const TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              )),
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            CupertinoIcons.question_circle_fill,
                                            size: 18,
                                            color: lightGrey,
                                          ),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          Text("${item?.totalQues} Questions  ",
                                              style: GoogleFonts.roboto(
                                                textStyle: TextStyle(
                                                  color: lightGrey,
                                                  fontSize: 12.5,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              )),
                                          Icon(
                                            CupertinoIcons.time_solid,
                                            size: 18,
                                            color: lightGrey,
                                          ),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          Text("${item?.duration} Minutes",
                                              style: GoogleFonts.roboto(
                                                textStyle: TextStyle(
                                                  color: lightGrey,
                                                  fontSize: 12.5,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            )
          : const Center(
              child: Text("No Data Available"),
            ),
    );
  }
}
