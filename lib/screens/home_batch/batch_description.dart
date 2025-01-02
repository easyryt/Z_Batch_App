import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pk_education/model/batch_description_model.dart';
import 'package:pk_education/screens/home_batch/schedule_all.dart';
import 'package:pk_education/screens/home_batch/teacher_all.dart';
import 'package:pk_education/screens/pdf_view_screen.dart';
import 'package:pk_education/widget/expense_tile.dart';
import 'package:pk_education/widget/teacher_bottom_sheet.dart';

class BatchDescription extends StatefulWidget {
  final DescriptionData? batchDescription;
  final String batchId;
  const BatchDescription(
      {super.key, required this.batchId, this.batchDescription});

  @override
  State<BatchDescription> createState() => _BatchDescriptionState();
}

class _BatchDescriptionState extends State<BatchDescription> {
  // MainApplicationController mainApplicationController = Get.find();
  //DescriptionData? batchDescription;
  // List<DescriptionData>? _batchDescription=[];

  // @override
  // void initState() {
  //   super.initState();
  //   _fetchData();
  // }

  // Future<void> _fetchData() async {
  //   try {
  //     final data = await mainApplicationController
  //         .getBatchDescriptionDetail(widget.batchId);
  //     setState(() {
  //       batchDescription = data;
  //     });
  //   } catch (error) {
  //     // Handle errors here
  //     print("Error fetching data: $error");
  //   }
  // }

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
      body: widget.batchDescription != null
          ? Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      "This Batch Includes",
                      style: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    if (widget.batchDescription?.courseDuration!.startDate !=
                            null &&
                        widget.batchDescription?.courseDuration!.endDate !=
                            null)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.calendar_month,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Course Duration:",
                                  style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w400,
                                        color: lightGrey),
                                  )),
                              Text(
                                  "${formatDate(widget.batchDescription!.courseDuration!.startDate!!)} - ${formatDate(widget.batchDescription!.courseDuration!.endDate!)}",
                                  style: GoogleFonts.roboto(
                                    textStyle: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ))
                            ],
                          )
                        ],
                      ),
                    const SizedBox(height: 6),
                    if (widget.batchDescription!.batchIncludes!.isNotEmpty)
                      ListView.builder(
                        itemCount:
                            widget.batchDescription!.batchIncludes!.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var item =
                              widget.batchDescription!.batchIncludes![index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.star,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                SizedBox(
                                  //  color: Colors.red,
                                  width: size.width * 0.83,
                                  child: Text(item,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.roboto(
                                        textStyle: const TextStyle(
                                          fontSize: 13.5,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      )),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    if (widget.batchDescription!.subjects!.isNotEmpty)
                      ListView.builder(
                        //  itemCount: batchDescription.subjects!.length,
                        itemCount: 1,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var subject =
                              widget.batchDescription!.subjects![index];
                          String allSubjects =
                              widget.batchDescription!.subjects!.join(', ');
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.star,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "Subject: ",
                                  style: GoogleFonts.roboto(
                                    textStyle: const TextStyle(
                                      fontSize: 13.5,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  // color: Colors.red,
                                  width: size.width * 0.6,
                                  child: Text(allSubjects,
                                      style: GoogleFonts.roboto(
                                        textStyle: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      )),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    const SizedBox(height: 14),
                    if (widget.batchDescription!.knowYourTeachers!.isNotEmpty)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: size.width * 0.68,
                            child: Text("Know your teacher",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.roboto(
                                  textStyle: const TextStyle(
                                    fontSize: 14.5,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )),
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(() => TeacherAll(
                                  teacher: widget
                                      .batchDescription!.knowYourTeachers!));
                            },
                            child: Text("View All",
                                style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                    color: appColor,
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )),
                          ),
                        ],
                      ),
                    const SizedBox(height: 10),
                    if (widget.batchDescription!.knowYourTeachers!.isNotEmpty)
                      SizedBox(
                        height: 170,
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: widget.batchDescription!.knowYourTeachers!
                                      .length <
                                  8
                              ? widget
                                  .batchDescription!.knowYourTeachers!.length
                              : 8,
                          scrollDirection: Axis.horizontal,
                          physics: const AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            var item = widget
                                .batchDescription!.knowYourTeachers![index];
                            return InkWell(
                              onTap: () {
                                // showModalBottomSheet(
                                //   backgroundColor: Colors.white,
                                //   context: context,
                                //   shape: const RoundedRectangleBorder(
                                //     borderRadius: BorderRadius.vertical(
                                //         top: Radius.circular(20)),
                                //   ),
                                //   builder: (BuildContext context) {
                                //     return Container(
                                //       // height: 130,
                                //       padding:
                                //           const EdgeInsetsDirectional.symmetric(
                                //               horizontal: 16, vertical: 16),
                                //       child: Column(
                                //         children: [
                                //           Row(
                                //             mainAxisAlignment:
                                //                 MainAxisAlignment.spaceBetween,
                                //             children: [
                                //               if (item.teacherName != null)
                                //                 Column(
                                //                   crossAxisAlignment:
                                //                       CrossAxisAlignment.start,
                                //                   children: [
                                //                     Text(item.teacherName!,
                                //                         style:
                                //                             GoogleFonts.roboto(
                                //                           textStyle:
                                //                               const TextStyle(
                                //                             fontSize: 13,
                                //                             fontWeight:
                                //                                 FontWeight.w500,
                                //                           ),
                                //                         )),
                                //                     Text(item.expertise!,
                                //                         style:
                                //                             GoogleFonts.roboto(
                                //                           textStyle: TextStyle(
                                //                             color: lightGrey,
                                //                             fontSize: 12,
                                //                             fontWeight:
                                //                                 FontWeight.w400,
                                //                           ),
                                //                         )),
                                //                   ],
                                //                 ),
                                //               InkWell(
                                //                 onTap: () {
                                //                   Navigator.pop(context);
                                //                 },
                                //                 child: const Icon(
                                //                     Icons.cancel_outlined),
                                //               )
                                //             ],
                                //           ),
                                //           const SizedBox(height: 12),
                                //           (item.pic != null)
                                //               ? Container(
                                //                   height: 100,
                                //                   width: 120,
                                //                   decoration: BoxDecoration(
                                //                     // color: Colors.red,
                                //                     borderRadius:
                                //                         BorderRadius.circular(
                                //                             16.0),
                                //                     image: DecorationImage(
                                //                       image: NetworkImage(
                                //                           item.pic!),
                                //                       fit: BoxFit.fitHeight,
                                //                     ),
                                //                   ),
                                //                 )
                                //               : CircleAvatar(
                                //                   radius: 38,
                                //                   backgroundColor:
                                //                       Colors.grey.shade200,
                                //                   // backgroundImage: (item.pic != null)
                                //                   //     ? NetworkImage(item.pic!)
                                //                   //     : null,
                                //                 ),
                                //           const SizedBox(height: 16),
                                //           Text("Quotes",
                                //               style: GoogleFonts.roboto(
                                //                 textStyle: const TextStyle(
                                //                   fontSize: 16,
                                //                   fontWeight: FontWeight.w600,
                                //                 ),
                                //               )),
                                //           const SizedBox(height: 8),
                                //           Text("Welcome To NPC Classes!",
                                //               style: GoogleFonts.roboto(
                                //                 textStyle: TextStyle(
                                //                   color: lightGrey,
                                //                   fontSize: 14,
                                //                   fontWeight: FontWeight.w400,
                                //                 ),
                                //               )),
                                //         ],
                                //       ),
                                //     );
                                //   },
                                // );
                                CustomBottomSheet.show(
                                  context: context,
                                  teacherName: item.teacherName,
                                  expertise: item.expertise,
                                  pic: item.pic,
                                  title: 'Quotes',
                                  description: 'Welcome To NPC Classes!',
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 10),
                                margin: const EdgeInsets.only(
                                    right: 8, left: 4, top: 2, bottom: 2),
                                decoration: BoxDecoration(
                                    color: white,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.shade300,
                                          spreadRadius: 0.01,
                                          blurRadius: 2,
                                          offset: const Offset(0, 0))
                                    ]),
                                child: Column(
                                  children: [
                                    (item.pic != null)
                                        ? Container(
                                            height: 70,
                                            width: 80,
                                            decoration: BoxDecoration(
                                              // color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(16.0),
                                              image: DecorationImage(
                                                image: NetworkImage(item.pic!),
                                                fit: BoxFit.fitHeight,
                                              ),
                                            ),
                                          )
                                        : CircleAvatar(
                                            radius: 35,
                                            backgroundColor:
                                                Colors.grey.shade200,
                                            // backgroundImage: (item.pic != null)
                                            //     ? NetworkImage(item.pic!)
                                            //     : null,
                                          ),
                                    const Spacer(),
                                    if (item.teacherName != null)
                                      Text(item.teacherName!,
                                          style: GoogleFonts.roboto(
                                            textStyle: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )),
                                    const SizedBox(height: 1),
                                    if (item.expertise != null)
                                      Text(item.expertise!,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.roboto(
                                            textStyle: const TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          )),
                                    const SizedBox(height: 1),
                                    if (item.yearOfEx != null)
                                      Row(
                                        children: [
                                          Text("Exp: ${item.yearOfEx} Yr",
                                              style: GoogleFonts.roboto(
                                                textStyle: TextStyle(
                                                  color: lightGrey,
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              )),
                                          const SizedBox(width: 32),
                                          Container(
                                              padding: const EdgeInsets.all(3),
                                              decoration: BoxDecoration(
                                                  color: Colors.red[50],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Icon(
                                                Icons.arrow_forward_ios,
                                                size: 12.5,
                                                color: appColor,
                                              ))
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    const SizedBox(height: 20),
                    if (widget.batchDescription!.schedule!.isNotEmpty)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: size.width * 0.68,
                            child: Text("Checkout Your schedule",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.roboto(
                                  textStyle: const TextStyle(
                                    fontSize: 14.5,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )),
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(() => ScheduleAll(
                                  schedule:
                                      widget.batchDescription!.schedule!));
                            },
                            child: Text("View All",
                                style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                    color: appColor,
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )),
                          ),
                        ],
                      ),
                    const SizedBox(height: 10),
                    if (widget.batchDescription!.schedule!.isNotEmpty)
                      SizedBox(
                        height: 112,
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount:
                              widget.batchDescription!.schedule!.length < 8
                                  ? widget.batchDescription!.schedule!.length
                                  : 8,
                          scrollDirection: Axis.horizontal,
                          physics: const AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            var item =
                                widget.batchDescription!.schedule![index];
                            return InkWell(
                              onTap: () {
                                if (item.pdf != null && item.pdf != "") {
                                  Get.to(() => PDFScreen(
                                        pathP: item.pdf,
                                      ));
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 6),
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
                                    (item.icon != null)
                                        ? Container(
                                            height: 56,
                                            width: 62,
                                            decoration: BoxDecoration(
                                              // color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(16.0),
                                              image: DecorationImage(
                                                image: NetworkImage(item.icon!),
                                                fit: BoxFit.fitHeight,
                                              ),
                                            ),
                                          )
                                        : CircleAvatar(
                                            radius: 26,
                                            backgroundColor:
                                                Colors.grey.shade300,
                                          ),
                                    const Spacer(),
                                    if (item.subject != null)
                                      Container(
                                        alignment: Alignment.center,
                                        width: 90,
                                        child: Center(
                                          child: Text(item.subject!,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.roboto(
                                                textStyle: const TextStyle(
                                                  fontSize: 12.5,
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
                      ),
                    const SizedBox(height: 20),
                    if (widget.batchDescription!.otherDetails!.isNotEmpty)
                      ListView.builder(
                        itemCount: 1,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var item =
                              widget.batchDescription!.otherDetails![index];
                          return ExpansionTile(
                            shape: BeveledRectangleBorder(
                                side: const BorderSide(
                                    color: Colors.grey, width: 0.4),
                                borderRadius: BorderRadius.circular(4)),
                            collapsedShape: BeveledRectangleBorder(
                                side: const BorderSide(
                                    color: Colors.grey, width: 0.4),
                                borderRadius: BorderRadius.circular(4)),
                            dense: true,
                            childrenPadding: const EdgeInsets.only(bottom: 8),
                            tilePadding:
                                const EdgeInsets.symmetric(horizontal: 8),
                            title: Text(
                              "Other Details",
                              style: GoogleFonts.roboto(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            children: widget.batchDescription!.otherDetails!
                                .map((item) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                    vertical:
                                        6.0), // Add padding for better visual separation
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    item,
                                    style: GoogleFonts.roboto(
                                      textStyle: const TextStyle(
                                        fontSize: 13.5,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          );
                        },
                      ),
                    const SizedBox(height: 20),
                    if (widget.batchDescription!.faq!.isNotEmpty)
                      Text("FAQ's",
                          style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w600,
                            ),
                          )),
                    const SizedBox(height: 10),
                    if (widget.batchDescription!.faq!.isNotEmpty)
                      ListView.builder(
                        itemCount: widget.batchDescription!.faq!.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var item = widget.batchDescription!.faq![index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child:
                                faqTile("${item.question}", "${item.answer}"),
                          );
                        },
                      ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            )
          : const Center(child: CircularProgressIndicator()),
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

///
// body: FutureBuilder<DescriptionData>(
//   future:
//       mainApplicationController.getBatchDescriptionDetail(widget.batchId),
//   builder: (context, snapshot) {
//     if (snapshot.connectionState == ConnectionState.waiting) {
//       return const Center(child: CircularProgressIndicator());
//     } else if (snapshot.hasError) {
//       return Center(
//         child: Text(
//           "Error: ${snapshot.error}",
//           style: const TextStyle(color: Colors.red),
//         ),
//       );
//     } else if (snapshot.hasData) {
//       final batchDescription = snapshot.data!;
//
//       return Padding(
//         padding: const EdgeInsets.only(left: 16, right: 16),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 16),
//               Text("This Batch Includes",
//                   style: GoogleFonts.roboto(
//                     textStyle: const TextStyle(
//                       fontSize: 14.5,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   )),
//               const SizedBox(height: 14),
//               if (batchDescription.courseDuration!.startDate != null &&
//                   batchDescription.courseDuration!.endDate != null)
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     const Icon(
//                       Icons.calendar_month,
//                       size: 20,
//                     ),
//                     const SizedBox(width: 10),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text("Course Duration:",
//                             style: GoogleFonts.roboto(
//                               textStyle: TextStyle(
//                                   fontSize: 11,
//                                   fontWeight: FontWeight.w400,
//                                   color: lightGrey),
//                             )),
//                         Text(
//                             "${formatDate(batchDescription.courseDuration!.startDate!)} - ${formatDate(batchDescription.courseDuration!.endDate!)}",
//                             style: GoogleFonts.roboto(
//                               textStyle: const TextStyle(
//                                 fontSize: 11,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ))
//                       ],
//                     )
//                   ],
//                 ),
//               const SizedBox(height: 6),
//               if (batchDescription.batchIncludes!.isNotEmpty)
//                 ListView.builder(
//                   itemCount: batchDescription.batchIncludes!.length,
//                   physics: const NeverScrollableScrollPhysics(),
//                   shrinkWrap: true,
//                   itemBuilder: (context, index) {
//                     var item = batchDescription.batchIncludes![index];
//                     return Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 6.0),
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           const Icon(
//                             Icons.star,
//                             size: 20,
//                           ),
//                           const SizedBox(width: 8),
//                           SizedBox(
//                             //  color: Colors.red,
//                             width: size.width * 0.83,
//                             child: Text(item,
//                                 maxLines: 2,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: GoogleFonts.roboto(
//                                   textStyle: const TextStyle(
//                                     fontSize: 13.5,
//                                     fontWeight: FontWeight.w400,
//                                   ),
//                                 )),
//                           )
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               if (batchDescription.subjects!.isNotEmpty)
//                 ListView.builder(
//                   //  itemCount: batchDescription.subjects!.length,
//                   itemCount: 1,
//                   physics: const NeverScrollableScrollPhysics(),
//                   shrinkWrap: true,
//                   itemBuilder: (context, index) {
//                     var subject = batchDescription.subjects![index];
//                     String allSubjects =
//                         batchDescription.subjects!.join(', ');
//                     return Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 6.0),
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           const Icon(
//                             Icons.star,
//                             size: 20,
//                           ),
//                           const SizedBox(width: 8),
//                           Text(
//                             "Subject: ",
//                             style: GoogleFonts.roboto(
//                               textStyle: const TextStyle(
//                                 fontSize: 13.5,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             // color: Colors.red,
//                             width: size.width * 0.6,
//                             child: Text(allSubjects,
//                                 style: GoogleFonts.roboto(
//                                   textStyle: const TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w400,
//                                   ),
//                                 )),
//                           )
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               const SizedBox(height: 14),
//               if (batchDescription.knowYourTeachers!.isNotEmpty)
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     SizedBox(
//                       width: size.width * 0.68,
//                       child: Text("Know your teacher",
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           style: GoogleFonts.roboto(
//                             textStyle: const TextStyle(
//                               fontSize: 14.5,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           )),
//                     ),
//                     InkWell(
//                       onTap: () {
//                         Get.to(() => TeacherAll());
//                       },
//                       child: Text("View All",
//                           style: GoogleFonts.roboto(
//                             textStyle: TextStyle(
//                               color: appColor,
//                               fontSize: 13.5,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           )),
//                     ),
//                   ],
//                 ),
//               const SizedBox(height: 10),
//               if (batchDescription.knowYourTeachers!.isNotEmpty)
//                 SizedBox(
//                   height: 170,
//                   child: ListView.builder(
//                     padding: EdgeInsets.zero,
//                     itemCount: batchDescription.knowYourTeachers!.length,
//                     scrollDirection: Axis.horizontal,
//                     physics: const AlwaysScrollableScrollPhysics(),
//                     shrinkWrap: true,
//                     itemBuilder: (context, index) {
//                       var item =
//                           batchDescription.knowYourTeachers![index];
//                       return Container(
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 8, horizontal: 10),
//                         margin: const EdgeInsets.only(
//                             right: 8, left: 4, top: 2, bottom: 2),
//                         decoration: BoxDecoration(
//                             color: white,
//                             borderRadius: BorderRadius.circular(12),
//                             boxShadow: [
//                               BoxShadow(
//                                   color: Colors.grey.shade300,
//                                   spreadRadius: 0.01,
//                                   blurRadius: 2,
//                                   offset: const Offset(0, 0))
//                             ]),
//                         child: Column(
//                           children: [
//                             (item.pic != null)
//                                 ? Container(
//                                     height: 70,
//                                     width: 80,
//                                     decoration: BoxDecoration(
//                                       // color: Colors.red,
//                                       borderRadius:
//                                           BorderRadius.circular(16.0),
//                                       image: DecorationImage(
//                                         image: NetworkImage(item.pic!),
//                                         fit: BoxFit.fitHeight,
//                                       ),
//                                     ),
//                                   )
//                                 : CircleAvatar(
//                                     radius: 35,
//                                     backgroundColor: Colors.grey.shade200,
//                                     // backgroundImage: (item.pic != null)
//                                     //     ? NetworkImage(item.pic!)
//                                     //     : null,
//                                   ),
//                             const Spacer(),
//                             if (item.teacherName != null)
//                               Text(item.teacherName!,
//                                   style: GoogleFonts.roboto(
//                                     textStyle: const TextStyle(
//                                       fontSize: 13,
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                   )),
//                             const SizedBox(height: 1),
//                             if (item.expertise != null)
//                               Text(item.expertise!,
//                                   style: GoogleFonts.roboto(
//                                     textStyle: const TextStyle(
//                                       fontSize: 11,
//                                       fontWeight: FontWeight.w400,
//                                     ),
//                                   )),
//                             const SizedBox(height: 1),
//                             Row(
//                               children: [
//                                 Text("Exp: 5 Yr",
//                                     style: GoogleFonts.roboto(
//                                       textStyle: TextStyle(
//                                         color: lightGrey,
//                                         fontSize: 11,
//                                         fontWeight: FontWeight.w400,
//                                       ),
//                                     )),
//                                 const SizedBox(width: 32),
//                                 Container(
//                                     padding: const EdgeInsets.all(3),
//                                     decoration: BoxDecoration(
//                                         color: Colors.red[50],
//                                         borderRadius:
//                                             BorderRadius.circular(20)),
//                                     child: Icon(
//                                       Icons.arrow_forward_ios,
//                                       size: 12.5,
//                                       color: appColor,
//                                     ))
//                               ],
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               const SizedBox(height: 20),
//               if (batchDescription.schedule!.isNotEmpty)
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     SizedBox(
//                       width: size.width * 0.68,
//                       child: Text("Checkout Your schedule",
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           style: GoogleFonts.roboto(
//                             textStyle: const TextStyle(
//                               fontSize: 14.5,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           )),
//                     ),
//                     InkWell(
//                       onTap: () {
//                         Get.to(() => const ScheduleAll());
//                       },
//                       child: Text("View All",
//                           style: GoogleFonts.roboto(
//                             textStyle: TextStyle(
//                               color: appColor,
//                               fontSize: 13.5,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           )),
//                     ),
//                   ],
//                 ),
//               const SizedBox(height: 10),
//               if (batchDescription.schedule!.isNotEmpty)
//                 SizedBox(
//                   height: 112,
//                   child: ListView.builder(
//                     padding: EdgeInsets.zero,
//                     itemCount: batchDescription.schedule!.length,
//                     scrollDirection: Axis.horizontal,
//                     physics: const AlwaysScrollableScrollPhysics(),
//                     shrinkWrap: true,
//                     itemBuilder: (context, index) {
//                       var item = batchDescription.schedule![index];
//                       return Container(
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 8, horizontal: 6),
//                         margin: const EdgeInsets.only(
//                             right: 8, left: 4, top: 2, bottom: 2),
//                         decoration: BoxDecoration(
//                             color: white,
//                             borderRadius: BorderRadius.circular(10),
//                             boxShadow: [
//                               BoxShadow(
//                                   color: Colors.grey.shade300,
//                                   spreadRadius: 0.01,
//                                   blurRadius: 2,
//                                   offset: const Offset(0, 0))
//                             ]),
//                         child: Column(
//                           children: [
//                             (item.icon != null)
//                                 ? Container(
//                                     height: 56,
//                                     width: 62,
//                                     decoration: BoxDecoration(
//                                       // color: Colors.red,
//                                       borderRadius:
//                                           BorderRadius.circular(16.0),
//                                       image: DecorationImage(
//                                         image: NetworkImage(item.icon!),
//                                         fit: BoxFit.fitHeight,
//                                       ),
//                                     ),
//                                   )
//                                 : CircleAvatar(
//                                     radius: 26,
//                                     backgroundColor: Colors.grey.shade300,
//                                   ),
//                             const Spacer(),
//                             if (item.subject != null)
//                               Container(
//                                 alignment: Alignment.center,
//                                 width: 90,
//                                 child: Center(
//                                   child: Text(item.subject!,
//                                       maxLines: 1,
//                                       overflow: TextOverflow.ellipsis,
//                                       style: GoogleFonts.roboto(
//                                         textStyle: const TextStyle(
//                                           fontSize: 12.5,
//                                           fontWeight: FontWeight.w500,
//                                         ),
//                                       )),
//                                 ),
//                               ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               const SizedBox(height: 20),
//               if (batchDescription.otherDetails!.isNotEmpty)
//                 ListView.builder(
//                   itemCount: 1,
//                   physics: const NeverScrollableScrollPhysics(),
//                   shrinkWrap: true,
//                   itemBuilder: (context, index) {
//                     var item = batchDescription.otherDetails![index];
//                     return ExpansionTile(
//                       shape: BeveledRectangleBorder(
//                           side: const BorderSide(
//                               color: Colors.grey, width: 0.4),
//                           borderRadius: BorderRadius.circular(4)),
//                       collapsedShape: BeveledRectangleBorder(
//                           side: const BorderSide(
//                               color: Colors.grey, width: 0.4),
//                           borderRadius: BorderRadius.circular(4)),
//                       dense: true,
//                       childrenPadding: const EdgeInsets.only(bottom: 8),
//                       tilePadding:
//                           const EdgeInsets.symmetric(horizontal: 8),
//                       title: Text(
//                         "Other Details",
//                         style: GoogleFonts.roboto(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       children:
//                           batchDescription.otherDetails!.map((item) {
//                         return Padding(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 10.0,
//                               vertical:
//                                   6.0), // Add padding for better visual separation
//                           child: Align(
//                             alignment: Alignment.centerLeft,
//                             child: Text(
//                               item,
//                               style: GoogleFonts.roboto(
//                                 textStyle: const TextStyle(
//                                   fontSize: 13.5,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         );
//                       }).toList(),
//                     );
//                   },
//                 ),
//               const SizedBox(height: 20),
//               if (batchDescription.faq!.isNotEmpty)
//                 Text("FAQ's",
//                     style: GoogleFonts.roboto(
//                       textStyle: const TextStyle(
//                         fontSize: 14.5,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     )),
//               const SizedBox(height: 10),
//               if (batchDescription.faq!.isNotEmpty)
//                 ListView.builder(
//                   itemCount: batchDescription.faq!.length,
//                   physics: const NeverScrollableScrollPhysics(),
//                   shrinkWrap: true,
//                   itemBuilder: (context, index) {
//                     var item = batchDescription.faq![index];
//                     return Padding(
//                       padding: const EdgeInsets.only(bottom: 10.0),
//                       child:
//                           faqTile("${item.question}", "${item.answer}"),
//                     );
//                   },
//                 ),
//               const SizedBox(height: 10),
//             ],
//           ),
//         ),
//       );
//     } else {
//       return const Center(
//         child: Text("No Data Available"),
//       );
//     }
//   },
// ),
