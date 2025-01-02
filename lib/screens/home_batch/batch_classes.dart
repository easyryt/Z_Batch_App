import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pk_education/model/class_subject_model.dart';
import 'package:pk_education/screens/home_batch/all_content/all_content_classes.dart';

class BatchClasses extends StatefulWidget {
  final ClassSubjectModel? classSubjectData;
  final String batchId;
  const BatchClasses({super.key, this.classSubjectData, required this.batchId});

  @override
  State<BatchClasses> createState() => _BatchClassesState();
}

class _BatchClassesState extends State<BatchClasses> {
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
      body: widget.classSubjectData != null
          ? Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    if (widget.classSubjectData!.data!.isNotEmpty)
                      Text(
                        "Subjects",
                        style: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                            fontSize: 14.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    if (widget.classSubjectData!.data!.isNotEmpty)
                      Text(
                        "Select Your Subject & Start Learning",
                        style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                            color: lightGrey,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    const SizedBox(height: 20),
                    if (widget.classSubjectData!.data!.isNotEmpty)
                      GridView.builder(
                        padding: EdgeInsets.zero,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisExtent: 120,
                                mainAxisSpacing: 8),
                        itemCount: widget.classSubjectData?.data?.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var item = widget.classSubjectData!.data?[index];
                          return GestureDetector(
                            onTap: () {
                              Get.to(() => AllContentClasses(
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
                                  Container(
                                    alignment: Alignment.center,
                                    width: 90,
                                    child: Center(
                                      child:
                                          Text("${item.totalChapter!} Chapters",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.roboto(
                                                textStyle: TextStyle(
                                                  color: lightGrey,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w400,
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
                    if (widget.classSubjectData!.data!.isEmpty)
                      SizedBox(
                        height: size.height * 0.5,
                        child: const Center(
                          child: Text("No Subject Available"),
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
