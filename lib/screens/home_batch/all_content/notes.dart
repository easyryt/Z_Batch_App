import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pk_education/controller/pk/main_app_controller.dart';
import 'package:pk_education/model/sub_notes_model.dart';
import 'package:pk_education/screens/pdf_view_screen.dart';

class NotesScreen extends StatefulWidget {
  final String subId;
  const NotesScreen({super.key, required this.subId});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
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
      body: FutureBuilder<SubjectNotesModel>(
        future: mainApplicationController.getSubNotes(widget.subId),
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
            final subNotes = snapshot.data!.data;

            if (subNotes!.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 12),
                      ListView.builder(
                        itemCount: subNotes?.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          var item = subNotes![index];
                          return InkWell(
                            onTap: () {
                              if (item.isFreeContent == true) {
                                if (item.pdf!.url != null) {
                                  Get.to(() => PDFScreen(pathP: item.pdf!.url));
                                } else {
                                  Get.snackbar("Alert", "Pdf Not Found",
                                      snackPosition: SnackPosition.TOP);
                                }
                              } else if (item.isBatchPaidByUser == true) {
                                if (item.pdf!.url != null) {
                                  Get.to(() => PDFScreen(pathP: item.pdf!.url));
                                } else {
                                  Get.snackbar("Alert", "Pdf Not Found",
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
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 8),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 8),
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
                                  (item.isFreeContent == true)
                                      ? Icon(
                                          FontAwesomeIcons.solidFilePdf,
                                          color: appColor,
                                          size: 28,
                                        )
                                      : (item.isBatchPaidByUser == true)
                                          ? Icon(
                                              FontAwesomeIcons.solidFilePdf,
                                              color: appColor,
                                              size: 28,
                                            )
                                          : Icon(
                                              Icons.lock_open_outlined,
                                              color: black,
                                              size: 28,
                                            ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          // color: Colors.red,
                                          width: size.width * 0.665,
                                          child: (item.title!.isNotEmpty &&
                                                  item.title! != "")
                                              ? Text("${item.title}",
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.roboto(
                                                    textStyle: const TextStyle(
                                                      fontSize: 11.5,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ))
                                              : const SizedBox(),
                                        ),
                                        Row(
                                          children: [
                                            (item.createdAt!.isNotEmpty &&
                                                    item.createdAt! != "")
                                                ? Text(
                                                    "${formatDate(item.createdAt!)}  ",
                                                    style: GoogleFonts.roboto(
                                                      textStyle: TextStyle(
                                                        color: lightGrey,
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ))
                                                : SizedBox()
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: lightGrey,
                                    size: 16,
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
                child: Text("PDF not available"),
              );
            }
          } else {
            return const Center(
              child: Text("No Data Available"),
            );
          }
        },
      ),
      // body: Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 16),
      //   child: SingleChildScrollView(
      //     child: Column(
      //       children: [
      //         const SizedBox(height: 12),
      //         ListView.builder(
      //           itemCount: 7,
      //           shrinkWrap: true,
      //           physics: const NeverScrollableScrollPhysics(),
      //           padding: EdgeInsets.zero,
      //           itemBuilder: (context, index) {
      //             return Container(
      //               width: size.width,
      //               padding:
      //                   const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
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
      //                     Icons.picture_as_pdf_outlined,
      //                     size: 30,
      //                   ),
      //                   const SizedBox(width: 8),
      //                   Expanded(
      //                     child: Column(
      //                       crossAxisAlignment: CrossAxisAlignment.start,
      //                       children: [
      //                         Container(
      //                           // color: Colors.red,
      //                           width: size.width * 0.66,
      //                           child: Text(
      //                               "Class Schedule || Udaan Achievers 2025",
      //                               maxLines: 2,
      //                               overflow: TextOverflow.ellipsis,
      //                               style: GoogleFonts.roboto(
      //                                 textStyle: const TextStyle(
      //                                   fontSize: 12,
      //                                   fontWeight: FontWeight.w500,
      //                                 ),
      //                               )),
      //                         ),
      //                         Row(
      //                           children: [
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
      //                   ),
      //                   const SizedBox(width: 6),
      //                   Icon(
      //                     Icons.arrow_forward_ios_rounded,
      //                     color: lightGrey,
      //                     size: 16,
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
