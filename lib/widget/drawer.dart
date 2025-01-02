import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pk_education/controller/pk/profile_controller.dart';
import 'package:pk_education/screens/profile/my_profile_screen.dart';
import 'package:pk_education/services/global.dart';

Drawer buildDrawer(double width, double height) {
  final ProfileController updateProfileController =
      Get.put(ProfileController());
  if (Global.storageServices.getString("imageUrl") != null) {
    updateProfileController.imgUrl.value =
        Global.storageServices.getString("imageUrl")!;
  }
  if (Global.storageServices.getString("name") != null &&
      Global.storageServices.getString("name") != "") {
    updateProfileController.nameS.value =
        Global.storageServices.getString("name")!;
  }
  if (Global.storageServices.getString("email") != null &&
      Global.storageServices.getString("email") != "") {
    updateProfileController.emailS.value =
        Global.storageServices.getString("email")!;
  }
  return Drawer(
    child: Container(
        clipBehavior: Clip.antiAlias,
        padding: const EdgeInsets.only(top: 40, left: 16),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Get.to(() => const MyProfileScreen());
              },
              child: Obx(() {
                return Row(
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.grey[400],
                        child: updateProfileController.imgUrl.value != ""
                            ? Container(
                                height: 58,
                                width: 58,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          updateProfileController.imgUrl.value),
                                      fit: BoxFit.cover),
                                ),
                              )
                            : Image.asset(
                                "assets/images/home_person.png",
                                height: 58,
                                width: 58,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            (updateProfileController.nameS.value != "")
                                ? updateProfileController.nameS.value
                                : "Your Name",
                            style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            )),
                        Text(
                            (updateProfileController.emailS.value != "")
                                ? updateProfileController.emailS.value
                                : "email here",
                            style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            )),
                      ],
                    )
                  ],
                );
              }),
            ),
            const SizedBox(
              height: 50,
            ),
            InkWell(
              onTap: () {},
              child: Row(
                children: [
                  const Icon(
                    CupertinoIcons.person_2,
                    size: 20,
                  ),
                  SizedBox(
                    width: width * 0.02,
                  ),
                  Text('For Sub Admin',
                      style: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                ],
              ),
            ),
            const SizedBox(height: 12),
            InkWell(
              onTap: () {},
              child: Row(
                children: [
                  const Icon(
                    Icons.shopping_cart_checkout_outlined,
                    size: 20,
                  ),
                  SizedBox(
                    width: width * 0.02,
                  ),
                  Text('Our Store',
                      style: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                ],
              ),
            ),
            const SizedBox(height: 12),
            InkWell(
              onTap: () {},
              child: Row(
                children: [
                  const Icon(
                    FontAwesomeIcons.hotel,
                    size: 18,
                  ),
                  SizedBox(
                    width: width * 0.025,
                  ),
                  Text('Our Centres',
                      style: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                ],
              ),
            ),
            const SizedBox(height: 12),
            InkWell(
              onTap: () {},
              child: Row(
                children: [
                  const Icon(
                    Icons.school_outlined,
                    size: 20,
                  ),
                  SizedBox(
                    width: width * 0.02,
                  ),
                  Text('Scholarship',
                      style: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                ],
              ),
            ),
            const SizedBox(height: 12),
            InkWell(
              onTap: () {},
              child: Row(
                children: [
                  const Icon(
                    Icons.screen_share_outlined,
                    size: 20,
                  ),
                  SizedBox(
                    width: width * 0.02,
                  ),
                  Text('Refer & Earn',
                      style: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                ],
              ),
            ),
            const SizedBox(height: 12),
            InkWell(
              onTap: () {},
              child: Row(
                children: [
                  const Icon(
                    Icons.contact_mail_outlined,
                    size: 20,
                  ),
                  SizedBox(
                    width: width * 0.02,
                  ),
                  Text('Contact Us',
                      style: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                ],
              ),
            ),
            const SizedBox(height: 12),
            InkWell(
              onTap: () {},
              child: Row(
                children: [
                  const Icon(
                    Icons.info_outline,
                    size: 20,
                  ),
                  SizedBox(
                    width: width * 0.02,
                  ),
                  Text('About Us',
                      style: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                ],
              ),
            ),
            const SizedBox(height: 12),
          ],
        )),
  );
}
