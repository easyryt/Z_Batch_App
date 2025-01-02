import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pk_education/controller/pk/main_app_controller.dart';
import 'package:pk_education/model/sub_dpp_pdf_model.dart';

class DppPdfScreen extends StatefulWidget {
  final String subId;
  const DppPdfScreen({super.key, required this.subId});

  @override
  State<DppPdfScreen> createState() => _DppPdfScreenState();
}

class _DppPdfScreenState extends State<DppPdfScreen> {
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
      body: FutureBuilder<SubjectDPPPDFModel>(
        future: mainApplicationController.getSubDPPPDF(widget.subId),
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
            final subDPPPDF = snapshot.data!.data;

            if (subDPPPDF!.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 12),
                      ListView.builder(
                        itemCount: subDPPPDF?.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          var item = subDPPPDF![index];
                          return InkWell(
                            onTap: () {},
                            child: Container(
                              width: size.width,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 10),
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
                                  const Icon(
                                    FontAwesomeIcons.filePdf,
                                    size: 30,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          // color: Colors.red,
                                          width: size.width * 0.66,
                                          child: (item.title!.isNotEmpty &&
                                                  item.title! != "")
                                              ? Text("${item.title}",
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.roboto(
                                                    textStyle: const TextStyle(
                                                      fontSize: 12,
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
                child: Text("DPP PDF Not Available"),
              );
            }
          } else {
            return const Center(
              child: Text("No Data Available"),
            );
          }
        },
      ),
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
