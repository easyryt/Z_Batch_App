// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//
// class BatchDetailsMainPage extends StatefulWidget {
//   const BatchDetailsMainPage({super.key});
//
//   @override
//   State<BatchDetailsMainPage> createState() => _BatchDetailsMainPageState();
// }
//
// class _BatchDetailsMainPageState extends State<BatchDetailsMainPage>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(vsync: this, initialIndex: 0, length: 5);
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     Color white = Colors.white;
//     Color black = Colors.black;
//     Color green = Colors.green;
//     Color appColor = const Color(0xFFFD0000);
//     Color lightGrey = Colors.grey.shade600;
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: white,
//         surfaceTintColor: white,
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(
//             bottom: Radius.circular(16),
//           ),
//         ),
//         elevation: 0,
//         leading: GestureDetector(
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: const Icon(
//             Icons.arrow_back_ios,
//           ),
//         ),
//         title: const Text(
//           'Batch',
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.w600,
//             height: 0,
//           ),
//         ),
//         actions: const [
//           Icon(FontAwesomeIcons.whatsapp),
//           SizedBox(
//             width: 20,
//           )
//         ],
//         bottom: PreferredSize(
//           preferredSize: Size.fromHeight(40),
//           child: Container(
//             color: Colors.green,
//             padding: EdgeInsets.only(left: 66),
//             child: TabBar(
//               isScrollable: false,
//               padding: EdgeInsets.zero,
//               indicatorSize: TabBarIndicatorSize.tab,
//               controller: _tabController,
//               tabs: const [
//                 Tab(
//                   child: Text(
//                     'Description',
//                     style: TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                 ),
//                 Tab(
//                   child: Text(
//                     'All Classes',
//                     style: TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                 ),
//                 Tab(
//                   child: Text(
//                     'Test',
//                     style: TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                 ),
//                 Tab(
//                   child: Text(
//                     'Test',
//                     style: TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                 ),
//                 Tab(
//                   child: Text(
//                     'Test',
//                     style: TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                 ),
//               ],
//               labelColor: Colors.black,
//               unselectedLabelColor: Colors.black.withOpacity(0.6),
//               labelStyle: const TextStyle(fontSize: 16),
//               unselectedLabelStyle:
//                   const TextStyle(fontSize: 16, color: Colors.black),
//               indicator: const UnderlineTabIndicator(
//                 borderSide: BorderSide(
//                   width: 2.0,
//                   color: Colors.black,
//                   // color: Color(0xFFF6A52C)
//                 ),
//                 insets: EdgeInsets.symmetric(horizontal: 0.0),
//               ),
//               indicatorPadding: EdgeInsets.zero,
//               dividerColor: Colors.blue,
//             ),
//           ),
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: [
//           Container(
//             height: 66,
//             width: 99,
//             color: Colors.red,
//           ),
//           Container(
//             height: 66,
//             width: 99,
//             color: Colors.green,
//           ),
//           Container(
//             height: 66,
//             width: 99,
//             color: Colors.yellow,
//           ),
//           Container(
//             height: 66,
//             width: 99,
//             color: Colors.grey,
//           ),
//           Container(
//             height: 66,
//             width: 99,
//             color: Colors.yellow,
//           ),
//         ],
//       ),
//     );
//   }
// }
///
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pk_education/controller/pk/main_app_controller.dart';
import 'package:pk_education/model/batch_description_model.dart';
import 'package:pk_education/model/class_subject_model.dart';
import 'package:pk_education/model/class_test_model.dart';
import 'package:pk_education/screens/home_batch/batch_classes.dart';
import 'package:pk_education/screens/home_batch/batch_description.dart';
import 'package:pk_education/screens/test/batch_test.dart';

class BatchDetailsMainPage extends StatefulWidget {
  final String batchId;
  final String batchName;
  final double? price;
  final double? mrp;
  final int? discount;
  final bool isFree;
  final bool myCourse;
  const BatchDetailsMainPage(
      {super.key,
      required this.batchId,
      this.price,
      this.mrp,
      this.discount,
      this.isFree = false,
      this.myCourse = false,
      required this.batchName});

  @override
  State<BatchDetailsMainPage> createState() => _BatchDetailsMainPageState();
}

class _BatchDetailsMainPageState extends State<BatchDetailsMainPage> {
  MainApplicationController mainApplicationController = Get.find();
  DescriptionData? batchDescription;
  ClassSubjectModel? classSubjectData;
  ClassTestModel? testSubject;
  bool isLoading = false;

  initFunction() async {
    await _fetchDescriptionData();
    await _fetchClassData();
    await _fetchTestData();
  }

  @override
  void initState() {
    initFunction();
    super.initState();
  }

  Future<void> _fetchDescriptionData() async {
    try {
      final data = await mainApplicationController
          .getBatchDescriptionDetail(widget.batchId);
      if (mounted) {
        setState(() {
          batchDescription = data;
        });
      }
    } catch (error) {
      print("Error fetching data: $error");
    }
  }

  Future<void> _fetchClassData() async {
    try {
      final data =
          await mainApplicationController.getBatchAllSubject(widget.batchId);
      setState(() {
        classSubjectData = data;
      });
    } catch (error) {
      print("Error fetching data: $error");
    }
  }

  Future<void> _fetchTestData() async {
    try {
      final data =
          await mainApplicationController.getBatchTestSubject(widget.batchId);
      setState(() {
        testSubject = data;
      });
    } catch (error) {
      print("Error fetching data: $error");
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
        // leadingWidth: 6,
        title: Text(widget.batchName,
            style: GoogleFonts.roboto(
              textStyle: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            )),
        actions: const [
          Icon(FontAwesomeIcons.whatsapp),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: SafeArea(
        child: DefaultTabController(
          length: 3,
          child: Stack(
            children: [
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0, right: 4),
                    child: Row(
                      children: [
                        Expanded(
                          child: ButtonsTabBar(
                            height: 30,
                            buttonMargin:
                                const EdgeInsets.symmetric(horizontal: 8),
                            labelStyle: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            unselectedLabelStyle:
                                TextStyle(color: Colors.grey[500]),
                            unselectedDecoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6)),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 0),
                            elevation: 0.0,
                            tabs: const [
                              Tab(
                                text: "Description",
                              ),
                              Tab(
                                text: "All Classes",
                              ),
                              Tab(
                                text: "Test",
                              ),
                              // Tab(
                              //   text: "Twist",
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: <Widget>[
                        BatchDescription(
                          batchId: widget.batchId,
                          batchDescription: batchDescription,
                        ),
                        BatchClasses(
                          batchId: widget.batchId,
                          classSubjectData: classSubjectData,
                        ),
                        BatchTest(
                          batchId: widget.batchId,
                          testSubject: testSubject,
                        ),
                        // Container(
                        //   color: green,
                        //   child: const Icon(Icons.directions_bike),
                        // ),
                      ],
                    ),
                  ),
                  if (widget.isFree == false && widget.myCourse == false)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                          color: white,
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(12),
                              topLeft: Radius.circular(12)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade400,
                                blurRadius: 1,
                                spreadRadius: 0.5,
                                offset: const Offset(0, 0))
                          ]),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (!widget.isFree && widget.price != null)
                                Row(
                                  children: [
                                    Text("₹400 ",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.roboto(
                                          textStyle: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )),
                                    if (widget.mrp != null)
                                      Text("₹500",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.roboto(
                                            textStyle: TextStyle(
                                              color: lightGrey,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          )),
                                  ],
                                ),
                              if (!widget.isFree)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 4),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: green,
                                        width: 1,
                                      )),
                                  child: Center(
                                    child: Text(
                                      "${widget.discount}% off",
                                      style: GoogleFonts.roboto(
                                        textStyle: TextStyle(
                                          color: green,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          InkWell(
                            onTap: () async {
                              // Get.to(() => const OrderSummary());
                              setState(() {
                                isLoading = true;
                              });
                              await mainApplicationController
                                  .buyBatch(widget.batchId);

                              setState(() {
                                isLoading = false;
                              });
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: size.width,
                              margin: const EdgeInsets.only(top: 10, bottom: 4),
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
                                child: Text("Buy Now",
                                    style: GoogleFonts.roboto(
                                      textStyle: TextStyle(
                                        color: white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                ],
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
          ),
        ),
      ),
    );
  }
}
