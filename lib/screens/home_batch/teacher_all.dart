import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pk_education/widget/teacher_bottom_sheet.dart';

class TeacherAll extends StatefulWidget {
  final List teacher;
  const TeacherAll({super.key, required this.teacher});

  @override
  State<TeacherAll> createState() => _TeacherAllState();
}

class _TeacherAllState extends State<TeacherAll> {
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
        title: Text('Your Teacher',
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
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              GridView.builder(
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, mainAxisSpacing: 8),
                itemCount: widget.teacher.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var item = widget.teacher[index];
                  return GestureDetector(
                    onTap: () {
                      CustomBottomSheet.show(
                        context: context,
                        teacherName: item.teacherName,
                        expertise: item.expertise,
                        pic: item.pic,
                        title: 'Quotes',
                        description: 'Welcome To NPC Classes!',
                      );

                      // showModalBottomSheet(
                      //   backgroundColor: Colors.white,
                      //   context: context,
                      //   shape: const RoundedRectangleBorder(
                      //     borderRadius:
                      //         BorderRadius.vertical(top: Radius.circular(20)),
                      //   ),
                      //   builder: (BuildContext context) {
                      //     return Container(
                      //       // height: 130,
                      //       padding: const EdgeInsetsDirectional.symmetric(
                      //           horizontal: 16, vertical: 16),
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
                      //                         style: GoogleFonts.roboto(
                      //                           textStyle: const TextStyle(
                      //                             fontSize: 13,
                      //                             fontWeight: FontWeight.w500,
                      //                           ),
                      //                         )),
                      //                     Text(item.expertise!,
                      //                         style: GoogleFonts.roboto(
                      //                           textStyle: TextStyle(
                      //                             color: lightGrey,
                      //                             fontSize: 12,
                      //                             fontWeight: FontWeight.w400,
                      //                           ),
                      //                         )),
                      //                   ],
                      //                 ),
                      //               InkWell(
                      //                 onTap: () {
                      //                   Navigator.pop(context);
                      //                 },
                      //                 child: const Icon(Icons.cancel_outlined),
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
                      //                         BorderRadius.circular(16.0),
                      //                     image: DecorationImage(
                      //                       image: NetworkImage(item.pic!),
                      //                       fit: BoxFit.fitHeight,
                      //                     ),
                      //                   ),
                      //                 )
                      //               : CircleAvatar(
                      //                   radius: 38,
                      //                   backgroundColor: Colors.grey.shade200,
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
                                    borderRadius: BorderRadius.circular(16.0),
                                    image: DecorationImage(
                                      image: NetworkImage(item.pic!),
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                )
                              : CircleAvatar(
                                  radius: 35,
                                  backgroundColor: Colors.grey.shade200,
                                ),
                          const Spacer(),
                          if (item.teacherName != null)
                            Text(item.teacherName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.roboto(
                                  textStyle: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )),
                          const SizedBox(height: 1),
                          if (item.expertise != null)
                            Text(item.expertise,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Exp: ${item.yearOfEx} Yr",
                                    style: GoogleFonts.roboto(
                                      textStyle: TextStyle(
                                        color: lightGrey,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )),
                                Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                        color: Colors.red[50],
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      size: 13,
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
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
