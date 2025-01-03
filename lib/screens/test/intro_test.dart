import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pk_education/controller/pk/main_app_controller.dart';
import 'package:pk_education/model/test_question_model.dart';
import 'package:pk_education/screens/test/test_question.dart';

class IntroTest extends StatefulWidget {
  final String testId;
  final String testName;
  const IntroTest({
    super.key,
    required this.testId,
    required this.testName,
  });

  @override
  State<IntroTest> createState() => _IntroTestState();
}

class _IntroTestState extends State<IntroTest> {
  MainApplicationController mainApplicationController = Get.find();
  TestQuestionModel? testQuestionModel;

  bool isLoading = false;

  @override
  void initState() {
    _fetchAllTest();
    super.initState();
  }

  Future<void> _fetchAllTest() async {
    try {
      setState(() {
        isLoading = true;
      });
      final data =
          await mainApplicationController.getTestQuestion(widget.testId);
      if (mounted) {
        setState(() {
          testQuestionModel = data;
          isLoading = false;
        });
      }
    } catch (error) {
      print("Error fetching data: $error");
      setState(() {
        isLoading = false;
      });
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
        title: Text("${widget.testName}  MCQ",
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
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : (testQuestionModel?.data?.test != null)
              ? Padding(
                  padding: const EdgeInsets.only(
                      left: 14, right: 14, bottom: 16, top: 2),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey[200]!,
                                blurRadius: 1,
                                spreadRadius: 1,
                                offset: const Offset(0, 0),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Read the following instruction carefully.",
                                  style: GoogleFonts.roboto(
                                    textStyle: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                if (testQuestionModel!
                                        .data!.test!.questions!.isNotEmpty &&
                                    testQuestionModel!.data!.test!.questions !=
                                        null)
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "1. ",
                                          style: GoogleFonts.roboto(
                                            textStyle: TextStyle(
                                              color: black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        TextSpan(
                                          text: "The test contains  ",
                                          style: GoogleFonts.roboto(
                                            textStyle: TextStyle(
                                              color: black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              "${testQuestionModel?.data!.test?.questions?.length} total Questions. ",
                                          style: GoogleFonts.roboto(
                                            textStyle: TextStyle(
                                              color: black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                const SizedBox(height: 8),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "2. ",
                                        style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                            color: black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      TextSpan(
                                        text: "Each question has  ",
                                        style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                            color: black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                      TextSpan(
                                        text: "4 options ",
                                        style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                            color: black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      TextSpan(
                                        text: "out of which  ",
                                        style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                            color: black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                      TextSpan(
                                        text: "only one is correct. ",
                                        style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                            color: black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                if (testQuestionModel?.data!.test?.duration !=
                                    null)
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "3. ",
                                          style: GoogleFonts.roboto(
                                            textStyle: TextStyle(
                                              color: black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        TextSpan(
                                          text: "You have finish the test in  ",
                                          style: GoogleFonts.roboto(
                                            textStyle: TextStyle(
                                              color: black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              "${testQuestionModel?.data!.test?.duration} minutes. ",
                                          style: GoogleFonts.roboto(
                                            textStyle: TextStyle(
                                              color: black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                const SizedBox(height: 8),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "4. ",
                                        style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                            color: black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      TextSpan(
                                        text: "You can view your  ",
                                        style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                            color: black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                      TextSpan(
                                        text: "Score ",
                                        style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                            color: black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      TextSpan(
                                        text: "after submitting the test. ",
                                        style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                            color: black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "5. ",
                                        style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                            color: black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      TextSpan(
                                        text: "Check  ",
                                        style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                            color: black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                      TextSpan(
                                        text: "detailed Solution ",
                                        style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                            color: black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            "with explanation after submitting the test. ",
                                        style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                            color: black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 8),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      InkWell(
                        onTap: () async {
                          if (testQuestionModel?.data?.test != null) {
                            Get.to(() => TestQuestion(
                                  testQuestionModel: testQuestionModel!,
                                ));
                          }
                        },
                        child: Container(
                          width: size.width,
                          margin: const EdgeInsets.only(top: 6, bottom: 4),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 10),
                          decoration: BoxDecoration(
                              color: appColor,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: appColor,
                                width: 1,
                              )),
                          child: Center(
                            child: Text("Start Now",
                                style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                    color: white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : const Center(
                  child: Text(" Question Searching"),
                ),
    );
  }
}
