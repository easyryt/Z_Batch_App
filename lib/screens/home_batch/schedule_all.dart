import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pk_education/screens/pdf_view_screen.dart';

class ScheduleAll extends StatefulWidget {
  final List schedule;
  const ScheduleAll({super.key, required this.schedule});

  @override
  State<ScheduleAll> createState() => _ScheduleAllState();
}

class _ScheduleAllState extends State<ScheduleAll> {
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
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            size: 18,
          ),
        ),
        title: Text('Your Schedule',
            style: GoogleFonts.roboto(
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            )),
        actions: const [
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              GridView.builder(
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, mainAxisSpacing: 8),
                itemCount: widget.schedule.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var item = widget.schedule[index];
                  return GestureDetector(
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
                                    borderRadius: BorderRadius.circular(16.0),
                                    image: DecorationImage(
                                      image: NetworkImage(item.icon!),
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                )
                              : CircleAvatar(
                                  radius: 26,
                                  backgroundColor: Colors.grey.shade300,
                                ),
                          const Spacer(),
                          if (item.subject != null)
                            Container(
                              alignment: Alignment.center,
                              width: 90,
                              child: Center(
                                child: Text(item.subject,
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
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
