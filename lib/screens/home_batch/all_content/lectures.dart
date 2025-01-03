import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pk_education/controller/pk/main_app_controller.dart';
import 'package:pk_education/model/sub_lecture_model.dart';
import 'package:pk_education/screens/youtube_player.dart';

class LecturesScreen extends StatefulWidget {
  final String subId;
  const LecturesScreen({super.key, required this.subId});

  @override
  State<LecturesScreen> createState() => _LecturesScreenState();
}

class _LecturesScreenState extends State<LecturesScreen> {
  MainApplicationController mainApplicationController = Get.find();
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
      body: FutureBuilder<SubjectLectureModel>(
        future: mainApplicationController.getSubLecture(widget.subId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error: ${snapshot.error}",
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (snapshot.hasData) {
            final subLecture = snapshot.data!.data;
            if (subLecture!.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 12),
                      ListView.builder(
                        itemCount: subLecture?.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          var item = subLecture![index];
                          // print(jsonEncode(item));
                          return InkWell(
                            onTap: () {
                              if (item.isFreeContent == true ||
                                  item.isBatchPaidByUser == true) {
                                if (item.videoUrl != null) {
                                  Get.to(() => YoutubePlayerScreen(
                                        videoUrl: item.videoUrl!,
                                      ));
                                } else {
                                  Get.snackbar("Alert", "Video Not Found",
                                      snackPosition: SnackPosition.TOP);
                                }
                              } else {
                                Get.snackbar("Alert",
                                    "Kindly purchase the batch to access the content",
                                    snackPosition: SnackPosition.TOP);
                              }
                            },
                            child: Container(
                              width: size.width,
                              height: 78,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 6),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade200,
                                    blurRadius: 3,
                                    spreadRadius: 0.5,
                                    offset: const Offset(0, 0),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  (item.thumbnailImg!.url!.isNotEmpty &&
                                          item.thumbnailImg!.url! != "")
                                      ? Stack(
                                          children: [
                                            Container(
                                              width: 108,
                                              height: 64,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      item.thumbnailImg!.url!),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            (item.isFreeContent == true)
                                                ? const SizedBox()
                                                : (item.isBatchPaidByUser ==
                                                        true)
                                                    ? const SizedBox()
                                                    : Positioned(
                                                        top: 0,
                                                        left: 0,
                                                        right: 0,
                                                        bottom: 0,
                                                        child: Icon(
                                                          Icons.lock_sharp,
                                                          color: appColor,
                                                          size: 18,
                                                        ))
                                          ],
                                        )
                                      : const Icon(
                                          Icons.slow_motion_video_outlined,
                                          size: 40,
                                        ),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              // color: Colors.red,
                                              width: size.width * 0.536,
                                              child: (item.title!.isNotEmpty &&
                                                      item.title! != "")
                                                  ? Text("${item.title}",
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: GoogleFonts.roboto(
                                                        textStyle:
                                                            const TextStyle(
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ))
                                                  : const SizedBox(),
                                            ),
                                            const Icon(
                                              Icons.more_vert,
                                              size: 18,
                                            )
                                          ],
                                        ),
                                        const Spacer(),
                                        Divider(
                                          color: Colors.grey.shade200,
                                          height: 0.4,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            (item.duration!.isNotEmpty &&
                                                    item.duration! != "")
                                                ? Row(
                                                    children: [
                                                      Icon(
                                                        CupertinoIcons.timer,
                                                        size: 11,
                                                        color: lightGrey,
                                                      ),
                                                      Text(" ${item.duration}",
                                                          style: GoogleFonts
                                                              .roboto(
                                                            textStyle:
                                                                TextStyle(
                                                              color: lightGrey,
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ))
                                                    ],
                                                  )
                                                : const SizedBox(),
                                            (item.createdAt!.isNotEmpty &&
                                                    item.createdAt! != "")
                                                ? Text(
                                                    "${formatDate(item.createdAt!)}  ",
                                                    style: GoogleFonts.roboto(
                                                      textStyle: TextStyle(
                                                        color: lightGrey,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ))
                                                : SizedBox()
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              );
            } else {
              return const Center(
                child: Text("Videos not available"),
              );
            }
          } else {
            return const Center(
              child: Text("No Data Available"),
            );
          }
        },
      ),

      ///
      // body: Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 16),
      //   child: SingleChildScrollView(
      //     child: Column(
      //       children: [
      //         const SizedBox(height: 12),
      //         ListView.builder(
      //           itemCount: 6,
      //           shrinkWrap: true,
      //           physics: const NeverScrollableScrollPhysics(),
      //           padding: EdgeInsets.zero,
      //           itemBuilder: (context, index) {
      //             return Container(
      //               width: size.width,
      //               padding:
      //                   const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      //               margin:
      //                   const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      //               decoration: BoxDecoration(
      //                 color: Colors.white,
      //                 borderRadius: BorderRadius.circular(10),
      //                 boxShadow: [
      //                   BoxShadow(
      //                     color: Colors.grey.shade200,
      //                     blurRadius: 3,
      //                     spreadRadius: 0.5,
      //                     offset: const Offset(0, 0),
      //                   ),
      //                 ],
      //               ),
      //               child: Row(
      //                 children: [
      //                   const Icon(
      //                     Icons.slow_motion_video_outlined,
      //                     size: 40,
      //                   ),
      //                   const SizedBox(width: 10),
      //                   Expanded(
      //                     child: Column(
      //                       children: [
      //                         Row(
      //                           mainAxisAlignment:
      //                               MainAxisAlignment.spaceBetween,
      //                           children: [
      //                             Text("Demo lecture by Neelmani",
      //                                 style: GoogleFonts.roboto(
      //                                   textStyle: const TextStyle(
      //                                     fontSize: 13,
      //                                     fontWeight: FontWeight.w500,
      //                                   ),
      //                                 )),
      //                             const Icon(
      //                               Icons.more_horiz,
      //                               size: 24,
      //                             )
      //                           ],
      //                         ),
      //                         const SizedBox(height: 20),
      //                         Divider(
      //                           color: Colors.grey.shade300,
      //                           height: 1.0,
      //                         ),
      //                         Row(
      //                           mainAxisAlignment:
      //                               MainAxisAlignment.spaceBetween,
      //                           children: [
      //                             Row(
      //                               children: [
      //                                 Icon(
      //                                   CupertinoIcons.timer,
      //                                   size: 14,
      //                                   color: lightGrey,
      //                                 ),
      //                                 Text(" 00:57:50",
      //                                     style: GoogleFonts.roboto(
      //                                       textStyle: TextStyle(
      //                                         color: lightGrey,
      //                                         fontSize: 12,
      //                                         fontWeight: FontWeight.w400,
      //                                       ),
      //                                     ))
      //                               ],
      //                             ),
      //                             Text("14 Dec 2024",
      //                                 style: GoogleFonts.roboto(
      //                                   textStyle: TextStyle(
      //                                     color: lightGrey,
      //                                     fontSize: 12,
      //                                     fontWeight: FontWeight.w400,
      //                                   ),
      //                                 ))
      //                           ],
      //                         )
      //                       ],
      //                     ),
      //                   )
      //                 ],
      //               ),
      //             );
      //           },
      //         )
      //       ],
      //     ),
      //   ),
      // ),
    );
  }

  String formatDate(String inputDate) {
    try {
      DateTime dateTime = DateTime.parse(inputDate);

      String outputDate = DateFormat('dd-MM-yyyy').format(dateTime);
      return outputDate;
    } catch (e) {
      print('Invalid date format: $e');
      return 'Invalid Date';
    }
  }
}
