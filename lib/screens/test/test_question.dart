import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pk_education/controller/pk/main_app_controller.dart';
import 'package:pk_education/model/test_question_model.dart';
import 'package:pk_education/screens/test/score_screen.dart';
import 'package:pk_education/widget/button/button.dart';

class TestQuestion extends StatefulWidget {
  final TestQuestionModel testQuestionModel;
  const TestQuestion({super.key, required this.testQuestionModel});

  @override
  State<TestQuestion> createState() => _TestQuestionState();
}

class _TestQuestionState extends State<TestQuestion> {
  MainApplicationController mainApplicationController =
      MainApplicationController();
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;

  Map<String, String> _selectedOptions = {};
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
        title: Text(" MCQ",
            style: GoogleFonts.roboto(
              textStyle: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            )),
        actions: const [
          // Icon(FontAwesomeIcons.whatsapp),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPageIndex = index;
                });
              },
              itemCount: widget.testQuestionModel.data?.test?.questions?.length,
              itemBuilder: (context, index) {
                final question =
                    widget.testQuestionModel.data?.test?.questions![index];
                if (question == null) return const SizedBox();
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${index + 1}. ${question.questionText!}",
                          style: const TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 12.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                              question.options!.length,
                              (optionIndex) => _buildOption(
                                  question.options![optionIndex],
                                  optionIndex,
                                  "${question.questionId}")),
                        ),
                        const SizedBox(height: 12.0),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Visibility(
                  visible: _currentPageIndex > 0,
                  child: button(
                      color: lightGrey,
                      title: "previous",
                      onPressed: () {
                        _pageController.previousPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease);
                      },
                      textColor: Colors.white),
                ),
                button(
                    color: Colors.red,
                    title: (_currentPageIndex <
                            ((widget.testQuestionModel.data?.test?.questions
                                    ?.length)! -
                                1))
                        ? "Next"
                        : "Submit",
                    onPressed: () async {
                      final questionLength = widget
                          .testQuestionModel.data?.test?.questions?.length;
                      if (questionLength != null) {
                        for (var question in widget
                            .testQuestionModel.data!.test!.questions!) {
                          if (!_selectedOptions
                              .containsKey(question.questionId)) {
                            _selectedOptions[question.questionId!] = "";
                          }
                        }
                        if (_currentPageIndex < (questionLength - 1)) {
                          _pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease);
                        } else {
                          await mainApplicationController
                              .submitAnswers(_selectedOptions,
                                  widget.testQuestionModel.data?.test?.testId)
                              .then((onValue) {
                            if (onValue == true) {
                              Get.snackbar(
                                  "wow", "You have complete your test.");
                              _selectedOptions.clear();
                              Get.to(() => const ScoreScreen());
                            }
                          });
                        }
                      }
                    },
                    textColor: Colors.white),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildOption(option, int index, String questionId) {
    bool isSelected =
        _selectedOptions[questionId] == String.fromCharCode(65 + index);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedOptions[questionId] = String.fromCharCode(65 + index);
          });
        },
        child: Row(
          children: [
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  color: isSelected ? Colors.green : Colors.grey.shade600,
                  borderRadius: BorderRadius.circular(20)),
              child: Center(
                  child: Text(
                String.fromCharCode(65 + index),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w500),
              )),
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.79,
                child: Text(
                  "${option.optionText}",
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 15,
                      fontWeight: FontWeight.w400),
                )),
          ],
        ),
      ),
    );
  }
}
