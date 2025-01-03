import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pk_education/controller/pk/main_app_controller.dart';

class ScoreScreen extends StatefulWidget {
  const ScoreScreen({super.key});

  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  MainApplicationController mainApplicationController = Get.find();
  bool isLoading = false;
  @override
  void initState() {
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
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : (mainApplicationController.scoreCardModel?.data != null)
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
                                if (mainApplicationController
                                        .scoreCardModel?.data!.totalMarks !=
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
                                              "${mainApplicationController.scoreCardModel?.data!.totalMarks} . ",
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
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      InkWell(
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
                  child: Text("Still not score "),
                ),
      // body: Obx(() {
      //   return Padding(
      //     padding:
      //         const EdgeInsets.only(left: 14, right: 14, bottom: 16, top: 2),
      //     child: SingleChildScrollView(
      //       child: Column(
      //         children: [
      //           ListView.builder(
      //             itemCount:
      //                 mainApplicationController.submittedTestList.length,
      //             physics: const NeverScrollableScrollPhysics(),
      //             shrinkWrap: true,
      //             itemBuilder: (context, index) {
      //               var item =
      //                   mainApplicationController.submittedTestList[index];
      //
      //               var title =
      //                   item["batchDetails"]["title"] ?? "No Title Found";
      //               var startDate =
      //                   item["batchDetails"]["duration"]["startDate"];
      //               var endDate = item["batchDetails"]["duration"]["endDate"];
      //               var imgUrl = item["batchDetails"]["thumbnailImg"]["url"];
      //               var clsName = item["batchDetails"]["clsName"];
      //               var board = item["batchDetails"]["board"];
      //               var isFree = item["batchDetails"]["isFree"];
      //               var isbatchActive = item["batchDetails"]["isbatchActive"];
      //               var batchTag = item["batchDetails"]["batchTag"];
      //               var price = item["batchDetails"]["price"] ?? 0.0;
      //               var mrp = item["batchDetails"]["mrp"] ?? 0.0;
      //               var discount = item["batchDetails"]["discount"] ?? 0;
      //               //  var clsId = item["clsId"];
      //               var batchId = item["batchDetails"]["batchId"];
      //
      //               return GestureDetector(
      //                 onTap: () {
      //                   Get.to(() => BatchDetailsMainPage(
      //                         batchId: batchId,
      //                         batchName: title,
      //                         price: double.parse("$price"),
      //                         discount: discount,
      //                         isFree: isFree,
      //                         mrp: double.parse("$mrp"),
      //                         myCourse: true,
      //                       ));
      //                 },
      //                 child: Container(
      //                   margin: const EdgeInsets.only(
      //                       bottom: 16, left: 2, right: 2),
      //                   decoration: BoxDecoration(
      //                     color: Colors.white,
      //                     borderRadius: BorderRadius.circular(10),
      //                     boxShadow: [
      //                       BoxShadow(
      //                         color: Colors.grey[300]!,
      //                         blurRadius: 1,
      //                         spreadRadius: 1,
      //                         offset: const Offset(0, 0),
      //                       ),
      //                     ],
      //                   ),
      //                   child: Column(
      //                     children: [
      //                       Container(
      //                         //   height: size.height * 0.25,
      //                         height: 168,
      //                         decoration: BoxDecoration(
      //                           color: Colors.grey.shade400,
      //                           borderRadius: BorderRadius.circular(10),
      //                           image: DecorationImage(
      //                             image: NetworkImage('$imgUrl'),
      //                             fit: BoxFit.cover,
      //                           ),
      //                         ),
      //                       ),
      //                       Padding(
      //                         padding: const EdgeInsets.only(
      //                             top: 10, right: 8, left: 8, bottom: 10),
      //                         child: Column(
      //                           children: [
      //                             Row(
      //                               mainAxisAlignment:
      //                                   MainAxisAlignment.spaceBetween,
      //                               children: [
      //                                 SizedBox(
      //                                   width: size.width * 0.59,
      //                                   child: Text("$title",
      //                                       maxLines: 1,
      //                                       overflow: TextOverflow.ellipsis,
      //                                       style: GoogleFonts.roboto(
      //                                         textStyle: const TextStyle(
      //                                           fontSize: 13,
      //                                           fontWeight: FontWeight.w500,
      //                                         ),
      //                                       )),
      //                                 ),
      //                                 // isFree
      //                                 //     ? const SizedBox()
      //                                 //     : Container(
      //                                 //         padding:
      //                                 //             const EdgeInsets.symmetric(
      //                                 //                 horizontal: 12,
      //                                 //                 vertical: 2),
      //                                 //         decoration: BoxDecoration(
      //                                 //             borderRadius:
      //                                 //                 BorderRadius.circular(
      //                                 //                     20),
      //                                 //             border: Border.all(
      //                                 //               color: green,
      //                                 //               width: 1,
      //                                 //             )),
      //                                 //         child: Center(
      //                                 //           child: Text("$discount% off",
      //                                 //               style: GoogleFonts.roboto(
      //                                 //                 textStyle: TextStyle(
      //                                 //                   color: green,
      //                                 //                   fontSize: 12,
      //                                 //                   fontWeight:
      //                                 //                       FontWeight.w400,
      //                                 //                 ),
      //                                 //               )),
      //                                 //         ),
      //                                 //       ),
      //                               ],
      //                             ),
      //                             const SizedBox(height: 8),
      //                             Row(
      //                               children: [
      //                                 Icon(
      //                                   Icons.perm_contact_calendar_outlined,
      //                                   size: 18,
      //                                   color: lightGrey,
      //                                 ),
      //                                 const SizedBox(
      //                                   width: 4,
      //                                 ),
      //                                 Text("$clsName ",
      //                                     style: GoogleFonts.roboto(
      //                                       textStyle: TextStyle(
      //                                         color: lightGrey,
      //                                         fontSize: 12,
      //                                         fontWeight: FontWeight.w400,
      //                                       ),
      //                                     )),
      //                                 Text("$board ",
      //                                     style: GoogleFonts.roboto(
      //                                       textStyle: TextStyle(
      //                                         color: lightGrey,
      //                                         fontSize: 12,
      //                                         fontWeight: FontWeight.w400,
      //                                       ),
      //                                     )),
      //                               ],
      //                             ),
      //                             const SizedBox(height: 8),
      //                             Row(
      //                               mainAxisAlignment:
      //                                   MainAxisAlignment.spaceBetween,
      //                               children: [
      //                                 Row(
      //                                   children: [
      //                                     Icon(
      //                                       Icons.calendar_month,
      //                                       size: 17,
      //                                       color: lightGrey,
      //                                     ),
      //                                     const SizedBox(
      //                                       width: 2,
      //                                     ),
      //                                     SizedBox(
      //                                       width: size.width * 0.4,
      //                                       child: Text(
      //                                           "Start on: $startDate",
      //                                           maxLines: 1,
      //                                           overflow:
      //                                               TextOverflow.ellipsis,
      //                                           style: GoogleFonts.roboto(
      //                                             textStyle: TextStyle(
      //                                               color: lightGrey,
      //                                               fontSize: 11,
      //                                               fontWeight:
      //                                                   FontWeight.w400,
      //                                             ),
      //                                           )),
      //                                     ),
      //                                   ],
      //                                 ),
      //                                 Row(
      //                                   mainAxisAlignment:
      //                                       MainAxisAlignment.end,
      //                                   children: [
      //                                     Icon(
      //                                       Icons.calendar_month,
      //                                       size: 17,
      //                                       color: lightGrey,
      //                                     ),
      //                                     const SizedBox(
      //                                       width: 2,
      //                                     ),
      //                                     SizedBox(
      //                                       width: size.width * 0.35,
      //                                       child: Text("End on: $endDate",
      //                                           maxLines: 1,
      //                                           overflow:
      //                                               TextOverflow.ellipsis,
      //                                           style: GoogleFonts.roboto(
      //                                             textStyle: TextStyle(
      //                                               color: lightGrey,
      //                                               fontSize: 11,
      //                                               fontWeight:
      //                                                   FontWeight.w400,
      //                                             ),
      //                                           )),
      //                                     ),
      //                                   ],
      //                                 ),
      //                               ],
      //                             ),
      //                             const SizedBox(height: 2),
      //                             // Divider(color: Colors.grey.shade300),
      //                             // const SizedBox(height: 2),
      //                             // isFree
      //                             //     ? Text("Free",
      //                             //         maxLines: 1,
      //                             //         overflow: TextOverflow.ellipsis,
      //                             //         style: GoogleFonts.roboto(
      //                             //           textStyle: const TextStyle(
      //                             //             fontSize: 13,
      //                             //             fontWeight: FontWeight.w500,
      //                             //           ),
      //                             //         ))
      //                             //     : Row(
      //                             //         mainAxisAlignment:
      //                             //             MainAxisAlignment.spaceBetween,
      //                             //         children: [
      //                             //           SizedBox(
      //                             //             width: size.width * 0.45,
      //                             //             child: Column(
      //                             //               crossAxisAlignment:
      //                             //                   CrossAxisAlignment.start,
      //                             //               children: [
      //                             //                 Text("₹$price",
      //                             //                     maxLines: 1,
      //                             //                     overflow: TextOverflow
      //                             //                         .ellipsis,
      //                             //                     style:
      //                             //                         GoogleFonts.roboto(
      //                             //                       textStyle:
      //                             //                           const TextStyle(
      //                             //                         fontSize: 13,
      //                             //                         fontWeight:
      //                             //                             FontWeight.w500,
      //                             //                       ),
      //                             //                     )),
      //                             //                 Text("₹$mrp",
      //                             //                     maxLines: 1,
      //                             //                     overflow: TextOverflow
      //                             //                         .ellipsis,
      //                             //                     style:
      //                             //                         GoogleFonts.roboto(
      //                             //                       textStyle: TextStyle(
      //                             //                         color: lightGrey,
      //                             //                         decoration:
      //                             //                             TextDecoration
      //                             //                                 .lineThrough,
      //                             //                         fontSize: 11,
      //                             //                         fontWeight:
      //                             //                             FontWeight.w400,
      //                             //                       ),
      //                             //                     )),
      //                             //               ],
      //                             //             ),
      //                             //           ),
      //                             //           InkWell(
      //                             //             onTap: () {},
      //                             //             child: Container(
      //                             //               padding: const EdgeInsets
      //                             //                   .symmetric(
      //                             //                   horizontal: 16,
      //                             //                   vertical: 6),
      //                             //               decoration: BoxDecoration(
      //                             //                   color: appColor,
      //                             //                   borderRadius:
      //                             //                       BorderRadius.circular(
      //                             //                           10),
      //                             //                   border: Border.all(
      //                             //                     color: appColor,
      //                             //                     width: 1,
      //                             //                   )),
      //                             //               child: Center(
      //                             //                 child: Text("Buy Now",
      //                             //                     style:
      //                             //                         GoogleFonts.roboto(
      //                             //                       textStyle: TextStyle(
      //                             //                         color: white,
      //                             //                         fontSize: 13,
      //                             //                         fontWeight:
      //                             //                             FontWeight.w500,
      //                             //                       ),
      //                             //                     )),
      //                             //               ),
      //                             //             ),
      //                             //           ),
      //                             //         ],
      //                             //       ),
      //                           ],
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //               );
      //             },
      //           )
      //         ],
      //       ),
      //     ),
      //   );
      // })
    );
  }
}
