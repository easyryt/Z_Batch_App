import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pk_education/controller/pk/main_app_controller.dart';
import 'package:pk_education/screens/home_batch/batch_details_main_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MainApplicationController mainApplicationController = Get.find();
  String totalBatch = "4";
  bool isLoading = false;
  @override
  void initState() {
    mainApplicationController.getAllBatch();
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
        body: Obx(() {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 14, right: 14, bottom: 16, top: 2),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("${mainApplicationController.batchList.length}",
                              style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              )),
                          Text(" Batches Available",
                              style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              )),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ListView.builder(
                        itemCount: mainApplicationController.batchList.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var item = mainApplicationController.batchList[index];

                          var title = item["title"] ?? "No Title Found";
                          var startDate = item["duration"]["startDate"];
                          var endDate = item["duration"]["endDate"];
                          var imgUrl = item["thumbnailImg"]["url"];
                          var clsName = item["clsName"];
                          var board = item["board"];
                          var isFree = item["isFree"];
                          var batchTag = item["batchTag"];
                          var price = item["price"] ?? 0.0;
                          var mrp = item["mrp"] ?? 0.0;
                          var discount = item["discount"] ?? 0;
                          var clsId = item["clsId"];
                          var batchId = item["_id"];

                          return GestureDetector(
                            onTap: () {
                              Get.to(() => BatchDetailsMainPage(
                                    batchId: batchId,
                                    // classId: clsId,
                                    batchName: title,
                                    price: double.parse("$price"),
                                    discount: discount,
                                    isFree: isFree,
                                    mrp: double.parse("$mrp"),
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
                                  Container(
                                    //   height: size.height * 0.25,
                                    height: 168,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade400,
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: NetworkImage('$imgUrl'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, right: 8, left: 8, bottom: 10),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: size.width * 0.59,
                                              child: Text("$title",
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.roboto(
                                                    textStyle: const TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  )),
                                            ),
                                            isFree
                                                ? const SizedBox()
                                                : Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 12,
                                                        vertical: 2),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        border: Border.all(
                                                          color: green,
                                                          width: 1,
                                                        )),
                                                    child: Center(
                                                      child: Text(
                                                          "$discount% off",
                                                          style: GoogleFonts
                                                              .roboto(
                                                            textStyle:
                                                                TextStyle(
                                                              color: green,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          )),
                                                    ),
                                                  ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons
                                                  .perm_contact_calendar_outlined,
                                              size: 18,
                                              color: lightGrey,
                                            ),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            Text("$clsName ",
                                                style: GoogleFonts.roboto(
                                                  textStyle: TextStyle(
                                                    color: lightGrey,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                )),
                                            Text("$board ",
                                                style: GoogleFonts.roboto(
                                                  textStyle: TextStyle(
                                                    color: lightGrey,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                )),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.calendar_month,
                                                  size: 17,
                                                  color: lightGrey,
                                                ),
                                                const SizedBox(
                                                  width: 2,
                                                ),
                                                SizedBox(
                                                  width: size.width * 0.4,
                                                  child: Text(
                                                      "Start on: $startDate",
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: GoogleFonts.roboto(
                                                        textStyle: TextStyle(
                                                          color: lightGrey,
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      )),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Icon(
                                                  Icons.calendar_month,
                                                  size: 17,
                                                  color: lightGrey,
                                                ),
                                                const SizedBox(
                                                  width: 2,
                                                ),
                                                SizedBox(
                                                  width: size.width * 0.35,
                                                  child: Text(
                                                      "End on: $endDate",
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: GoogleFonts.roboto(
                                                        textStyle: TextStyle(
                                                          color: lightGrey,
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 2),
                                        Divider(color: Colors.grey.shade300),
                                        const SizedBox(height: 2),
                                        isFree
                                            ? Text("Free",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.roboto(
                                                  textStyle: const TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ))
                                            : Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    width: size.width * 0.45,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text("₹$price",
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: GoogleFonts
                                                                .roboto(
                                                              textStyle:
                                                                  const TextStyle(
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            )),
                                                        Text("₹$mrp",
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: GoogleFonts
                                                                .roboto(
                                                              textStyle:
                                                                  TextStyle(
                                                                color:
                                                                    lightGrey,
                                                                decoration:
                                                                    TextDecoration
                                                                        .lineThrough,
                                                                fontSize: 11,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () async {
                                                      setState(() {
                                                        isLoading = true;
                                                      });
                                                      await mainApplicationController
                                                          .buyBatch(batchId);
                                                      setState(() {
                                                        isLoading = false;
                                                      });
                                                    },
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 16,
                                                          vertical: 6),
                                                      decoration: BoxDecoration(
                                                          color: appColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          border: Border.all(
                                                            color: appColor,
                                                            width: 1,
                                                          )),
                                                      child: Center(
                                                        child: Text("Buy Now",
                                                            style: GoogleFonts
                                                                .roboto(
                                                              textStyle:
                                                                  TextStyle(
                                                                color: white,
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            )),
                                                      ),
                                                    ),
                                                  ),
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
              ),
              Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : const SizedBox())
            ],
          );
        }));
  }
}
