import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pk_education/constant/constants.dart';
import 'package:pk_education/controller/pk/home_controller.dart';
import 'package:pk_education/controller/pk/main_app_controller.dart';
import 'package:pk_education/screens/classes.dart';
import 'package:pk_education/widget/drawer.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  final MainApplicationController _mainApplicationController = Get.find();
  HomeController homeController = Get.put(HomeController());
  final _advancedDrawerController = AdvancedDrawerController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Color white = Colors.white;
    Color black = Colors.black;
    return AdvancedDrawer(
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(color: white
            // gradient: LinearGradient(
            //   begin: Alignment.topLeft,
            //   end: Alignment.bottomRight,
            //   colors: [Colors.blueGrey, Colors.blueGrey.withOpacity(0.2)],
            // ),
            ),
      ),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      // openScale: 1.0,
      disabledGestures: false,
      childDecoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[300]!,
            blurRadius: 2,
            spreadRadius: 3,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      drawer: buildDrawer(size.width, size.height),
      child: Scaffold(
        backgroundColor: white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Obx(() {
            final pageIndex = _mainApplicationController.pageIdx.value;
            return
                // pageIndex == 0
                //   ?
                AppBar(
              backgroundColor: white,
              surfaceTintColor: white,
              leading: Builder(
                builder: (context) => IconButton(
                  icon: Image.asset(
                    "assets/images/drawerIcon.png",
                    width: 24,
                    fit: BoxFit.fitWidth,
                  ),
                  onPressed: () => _advancedDrawerController.showDrawer(),
                ),
              ),
              actions: [
                Obx(() {
                  return InkWell(
                    onTap: () {
                      Get.to(() => const ClassesScreen());
                    },
                    child: Container(
                      height: 32,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: black.withOpacity(0.1), width: 1),
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Row(
                          children: [
                            SizedBox(
                              width: size.width * 0.45,
                              child: Text(
                                (_mainApplicationController.className.value !=
                                        "")
                                    ? _mainApplicationController.className.value
                                    : "Select Your Class",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.roboto(
                                    textStyle: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13)),
                              ),
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 12,
                              color: black.withOpacity(0.4),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
                const SizedBox(
                  width: 16,
                )
              ],
            );
            //  : const SizedBox();
          }),
        ),
        body: Obx(() {
          return _mainApplicationController
              .homeWidgets[_mainApplicationController.pageIdx.value];
        }),
        bottomNavigationBar: Obx(() {
          // if (_mainApplicationController.pageIdx.value == 3) {
          //   return const SizedBox.shrink();
          // }
          return Container(
            decoration: BoxDecoration(
              // image: DecorationImage(
              //   image: AssetImage('assets/images/bottom_navigation.png'),
              //   fit: BoxFit.cover,
              // ),
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16), topRight: Radius.circular(16)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[300]!,
                  blurRadius: 2,
                  spreadRadius: 3,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: BottomNavigationBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              type: BottomNavigationBarType.fixed,
              onTap: (index) {
                _mainApplicationController.pageIdx.value = index;
              },
              selectedItemColor: Constants.primaryColor,
              unselectedItemColor: Constants.lightTextColor.withOpacity(0.6),
              currentIndex: _mainApplicationController.pageIdx.value,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(FontAwesomeIcons.graduationCap),
                    label: "My Course"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.grading_outlined), label: "Test"),
                BottomNavigationBarItem(
                    icon: Icon(FontAwesomeIcons.userGraduate),
                    label: "Tuition"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.menu_book_sharp), label: "Material"),
              ],
            ),
          );
        }),
      ),
    );
  }
}
