import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pk_education/controller/pk/main_app_controller.dart';
import 'package:pk_education/screens/home_batch/all_content/dpp_pdf.dart';
import 'package:pk_education/screens/home_batch/all_content/lectures.dart';
import 'package:pk_education/screens/home_batch/all_content/notes.dart';

class AllContentClasses extends StatefulWidget {
  final String subId;
  final String subName;
  const AllContentClasses(
      {super.key, required this.subId, required this.subName});

  @override
  State<AllContentClasses> createState() => _AllContentClassesState();
}

class _AllContentClassesState extends State<AllContentClasses> {
  MainApplicationController mainApplicationController = Get.find();

  initFunction() async {}

  @override
  void initState() {
    initFunction();
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
        title: Text(widget.subName,
            style: GoogleFonts.roboto(
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            )),
        actions: const [
          // Icon(FontAwesomeIcons.whatsapp),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: SafeArea(
        child: DefaultTabController(
          length: 3,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 4.0, right: 4),
                child: Row(
                  children: [
                    Expanded(
                      child: ButtonsTabBar(
                        height: 30,
                        buttonMargin: const EdgeInsets.symmetric(horizontal: 8),
                        labelStyle: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w500),
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
                            text: "Lectures",
                          ),
                          Tab(
                            text: "Notes",
                          ),
                          // Tab(
                          //   text: "DPP",
                          // ),
                          Tab(
                            text: "DPP PDF",
                          ),
                          // Tab(
                          //   text: "DPP VIDEOS",
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
                    LecturesScreen(
                      subId: widget.subId,
                    ),
                    NotesScreen(
                      subId: widget.subId,
                    ),
                    DppPdfScreen(
                      subId: widget.subId,
                    ),
                    // Container(
                    //   color: green,
                    // ),
                    // Container(
                    //   color: green,
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
