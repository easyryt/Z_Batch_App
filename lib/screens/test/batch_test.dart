import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pk_education/model/class_test_model.dart';
import 'package:pk_education/screens/test/subject_test_screen.dart';

class BatchTest extends StatefulWidget {
  final ClassTestModel? testSubject;
  final String batchId;
  const BatchTest({super.key, this.testSubject, required this.batchId});

  @override
  State<BatchTest> createState() => _BatchTestState();
}

class _BatchTestState extends State<BatchTest> {
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
      body: widget.testSubject != null
          ? Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    if (widget.testSubject!.data!.isNotEmpty)
                      // Text(
                      //   "Test",
                      //   style: GoogleFonts.roboto(
                      //     textStyle: const TextStyle(
                      //       fontSize: 14.5,
                      //       fontWeight: FontWeight.w600,
                      //     ),
                      //   ),
                      // ),
                      if (widget.testSubject!.data!.isNotEmpty)
                        Text(
                          "Select Your Subject & Start Test",
                          style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                    const SizedBox(height: 20),
                    if (widget.testSubject!.data!.isNotEmpty)
                      GridView.builder(
                        padding: EdgeInsets.zero,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisExtent: 104,
                                mainAxisSpacing: 8),
                        itemCount: widget.testSubject?.data?.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var item = widget.testSubject!.data?[index];
                          return GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (_) => SubjectTestScreen(
                              //               subId: item.sId!,
                              //               subName: item.subjectName!,
                              //             )));
                              Get.to(() => SubjectTestScreen(
                                    subId: item.sId!,
                                    subName: item.subjectName!,
                                  ));
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 6),
                              margin: const EdgeInsets.only(
                                  right: 8, left: 4, top: 2, bottom: 2),
                              decoration: BoxDecoration(
                                  color: white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.shade300,
                                        spreadRadius: 0.01,
                                        blurRadius: 2,
                                        offset: const Offset(0, 0))
                                  ]),
                              child: Column(
                                children: [
                                  (item?.icon != null)
                                      ? Container(
                                          height: 56,
                                          width: 62,
                                          decoration: BoxDecoration(
                                            // color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(16.0),
                                            image: DecorationImage(
                                              image: NetworkImage(item!.icon!),
                                              fit: BoxFit.fitHeight,
                                            ),
                                          ),
                                        )
                                      : CircleAvatar(
                                          radius: 30,
                                          backgroundColor: Colors.grey.shade300,
                                        ),
                                  const Spacer(),
                                  Container(
                                    alignment: Alignment.center,
                                    width: 90,
                                    child: Center(
                                      child: Text(item!.subjectName!,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.roboto(
                                            textStyle: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    if (widget.testSubject!.data!.isEmpty)
                      SizedBox(
                        height: size.height * 0.5,
                        child: const Center(
                          child: Text("No Test Available"),
                        ),
                      ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
