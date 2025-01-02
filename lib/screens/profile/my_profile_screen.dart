import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pk_education/constant/constants.dart';
import 'package:pk_education/controller/pk/profile_controller.dart';
import 'package:pk_education/services/global.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  final ProfileController _updateProfileController = Get.find();

  File? _selectedImage;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _updateProfileController.getProfile().then((profileData) {
      if (profileData != null) {
        final data = profileData;

        Global.storageServices.setString("phoneNumber", data.phone ?? "");
        Global.storageServices.setString("name", data.fullName ?? "");

        Global.storageServices
            .setString("imageUrl", data.profilePic?.url ?? "");
        Global.storageServices.setString("email", data.email ?? "");

        setState(() {
          _updateProfileController.imgUrl.value = data.profilePic!.url!;
          _updateProfileController.name.text = data.fullName ?? "";
          _updateProfileController.phoneNumber.text = data.phone ?? "";
          _updateProfileController.email.text = data.email ?? "";
          _updateProfileController.dob.text = data.dob ?? "";
          _updateProfileController.state.text = data.state ?? "";
          _updateProfileController.city.text = data.city ?? "";
          final gender = data.gender ?? "";
          _updateProfileController.gender.value = (gender == "Male")
              ? 0
              : (gender == "Female")
                  ? 1
                  : 2;
        });
      } else {
        Get.snackbar("Error", "Something went wrong ...Profile not found. ");
      }
    }).catchError((error) {
      Get.snackbar("Error", "An error occurred while fetching profile data.");
    });
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
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
      body: SafeArea(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              SizedBox(
                height: AppBar().preferredSize.height,
                width: size.height,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 12),
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(
                            Icons.arrow_back_ios_new_sharp,
                            size: 18,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "Profile",
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () async {
                            setState(() {
                              isLoading = true;
                            });
                            await _updateProfileController
                                .updateProfile(_selectedImage);
                            setState(() {
                              isLoading = false;
                            });
                          },
                          child: Text(
                            "Save",
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Constants.primaryColor,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 2),
                                      Obx(() {
                                        return Center(
                                          child: CircleAvatar(
                                              radius: 32,
                                              backgroundColor: Colors.grey[400],
                                              child: _selectedImage != null
                                                  ? Container(
                                                      height: 58,
                                                      width: 58,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                        image: DecorationImage(
                                                            image: FileImage(
                                                                _selectedImage!),
                                                            fit: BoxFit.cover),
                                                      ),
                                                    )
                                                  : _updateProfileController
                                                              .imgUrl.value !=
                                                          ""
                                                      ? Container(
                                                          height: 58,
                                                          width: 58,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30),
                                                            image: DecorationImage(
                                                                image: NetworkImage(
                                                                    _updateProfileController
                                                                        .imgUrl
                                                                        .value),
                                                                fit: BoxFit
                                                                    .cover),
                                                          ),
                                                        )
                                                      : Image.asset(
                                                          "assets/images/home_person.png",
                                                          height: 58,
                                                          width: 58,
                                                          fit: BoxFit.cover,
                                                        )),
                                        );
                                      }),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      Center(
                                        child: InkWell(
                                          onTap: () async {
                                            await _pickImage();
                                          },
                                          child: Text(
                                            "Edit Picture",
                                            style: GoogleFonts.roboto(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15,
                                              color: Constants.primaryColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      SizedBox(
                                        height: 50,
                                        child: TextFormField(
                                          controller:
                                              _updateProfileController.name,
                                          cursorColor: Constants.primaryColor,
                                          decoration: InputDecoration(
                                            labelText: "Name",
                                            labelStyle: GoogleFonts.roboto(
                                                color:
                                                    Constants.lightTextColor),
                                            floatingLabelStyle:
                                                GoogleFonts.roboto(
                                                    color:
                                                        Constants.primaryColor),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color:
                                                        Colors.grey.shade300),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                      Constants.primaryColor),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      SizedBox(
                                        height: 50,
                                        child: TextFormField(
                                          controller: _updateProfileController
                                              .phoneNumber,
                                          cursorColor: Constants.primaryColor,
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            labelText: "Phone Number",
                                            labelStyle: GoogleFonts.roboto(
                                                color:
                                                    Constants.lightTextColor),
                                            floatingLabelStyle:
                                                GoogleFonts.roboto(
                                                    color:
                                                        Constants.primaryColor),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color:
                                                        Colors.grey.shade300),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                      Constants.primaryColor),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      SizedBox(
                                        height: 50,
                                        child: TextFormField(
                                          controller:
                                              _updateProfileController.email,
                                          cursorColor: Constants.primaryColor,
                                          decoration: InputDecoration(
                                            labelText: "Email ID",
                                            labelStyle: GoogleFonts.roboto(
                                                color:
                                                    Constants.lightTextColor),
                                            floatingLabelStyle:
                                                GoogleFonts.roboto(
                                                    color:
                                                        Constants.primaryColor),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color:
                                                        Colors.grey.shade300),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                      Constants.primaryColor),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      SizedBox(
                                        height: 50,
                                        child: TextFormField(
                                          controller:
                                              _updateProfileController.dob,
                                          cursorColor: Constants.primaryColor,
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            labelText: "DOB",
                                            labelStyle: GoogleFonts.roboto(
                                                color:
                                                    Constants.lightTextColor),
                                            suffixIcon: IconButton(
                                                onPressed: () async {
                                                  selectDOB(context, true);
                                                },
                                                icon: const Icon(
                                                  Icons.calendar_month,
                                                  color: Colors.black,
                                                )),
                                            floatingLabelStyle:
                                                GoogleFonts.roboto(
                                                    color:
                                                        Constants.primaryColor),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color:
                                                        Colors.grey.shade300),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                      Constants.primaryColor),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      SizedBox(
                                        height: 50,
                                        child: TextFormField(
                                          controller:
                                              _updateProfileController.state,
                                          cursorColor: Constants.primaryColor,
                                          //  readOnly: true,
                                          decoration: InputDecoration(
                                            labelText: "State",
                                            labelStyle: GoogleFonts.roboto(
                                                color:
                                                    Constants.lightTextColor),
                                            floatingLabelStyle:
                                                GoogleFonts.roboto(
                                                    color:
                                                        Constants.primaryColor),
                                            // suffixIcon: IconButton(
                                            //     onPressed: () async {
                                            //       selectDOB(context, false);
                                            //     },
                                            //     icon: const Icon(
                                            //       Icons.calendar_month,
                                            //       color: Colors.black,
                                            //     )),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color:
                                                        Colors.grey.shade300),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                      Constants.primaryColor),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      SizedBox(
                                        height: 50,
                                        child: TextFormField(
                                          controller:
                                              _updateProfileController.city,
                                          cursorColor: Constants.primaryColor,
                                          // readOnly: true,
                                          decoration: InputDecoration(
                                            labelText: "City",
                                            labelStyle: GoogleFonts.roboto(
                                                color:
                                                    Constants.lightTextColor),
                                            floatingLabelStyle:
                                                GoogleFonts.roboto(
                                                    color:
                                                        Constants.primaryColor),
                                            // suffixIcon: IconButton(
                                            //     onPressed: () async {
                                            //       selectDOB(context, false);
                                            //     },
                                            //     icon: const Icon(
                                            //       Icons.calendar_month,
                                            //       color: Colors.black,
                                            //     )),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color:
                                                        Colors.grey.shade300),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                      Constants.primaryColor),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]),
                                const SizedBox(height: 6),
                                Text(
                                  "Gender",
                                  style: GoogleFonts.roboto(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Obx(() {
                                        return InkWell(
                                          onTap: () {
                                            _updateProfileController
                                                .gender.value = 0;
                                          },
                                          overlayColor:
                                              MaterialStateProperty.all(
                                                  Colors.transparent),
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 15,
                                                width: 15,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      color: Constants
                                                          .primaryColor),
                                                ),
                                                child: _updateProfileController
                                                            .gender.value ==
                                                        0
                                                    ? Center(
                                                        child: Container(
                                                          height: 10,
                                                          width: 10,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Constants
                                                                .primaryColor,
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                        ),
                                                      )
                                                    : const SizedBox(),
                                              ),
                                              const SizedBox(width: 6),
                                              Text(
                                                "Male",
                                                style: GoogleFonts.roboto(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      }),
                                    ),
                                    Expanded(
                                      child: Obx(() {
                                        return InkWell(
                                          onTap: () {
                                            _updateProfileController
                                                .gender.value = 1;
                                          },
                                          overlayColor:
                                              MaterialStateProperty.all(
                                                  Colors.transparent),
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 15,
                                                width: 15,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      color: Constants
                                                          .primaryColor),
                                                ),
                                                child: _updateProfileController
                                                            .gender.value ==
                                                        1
                                                    ? Center(
                                                        child: Container(
                                                          height: 10,
                                                          width: 10,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Constants
                                                                .primaryColor,
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                        ),
                                                      )
                                                    : const SizedBox(),
                                              ),
                                              const SizedBox(width: 6),
                                              Text(
                                                "Female",
                                                style: GoogleFonts.roboto(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      }),
                                    ),
                                    Expanded(
                                      child: Obx(() {
                                        return InkWell(
                                          overlayColor:
                                              MaterialStateProperty.all(
                                                  Colors.transparent),
                                          onTap: () {
                                            _updateProfileController
                                                .gender.value = 2;
                                          },
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 15,
                                                width: 15,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      color: Constants
                                                          .primaryColor),
                                                ),
                                                child: _updateProfileController
                                                            .gender.value ==
                                                        2
                                                    ? Center(
                                                        child: Container(
                                                          height: 10,
                                                          width: 10,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Constants
                                                                .primaryColor,
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                        ),
                                                      )
                                                    : const SizedBox(),
                                              ),
                                              const SizedBox(width: 6),
                                              Text(
                                                "Other",
                                                style: GoogleFonts.roboto(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      }),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                              ],
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   height: 1.h,
                        // ),
                        // InkWell(
                        //   onTap: () {
                        //     Get.back();
                        //   },
                        //   child: PrimaryFilledButton(
                        //     width: 90.w,
                        //     buttonText: "Update",
                        //   ),
                        // ),
                        const SizedBox(height: 10),
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
              ))
            ],
          ),
        ),
      ),
    );
  }

  DateTime selectedDOB = DateTime.now();
  Future<void> selectDOB(BuildContext context, isDob) async {
    final DateTime? picked = await showDatePicker(
      barrierDismissible: false,

      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      // lastDate: DateTime(2101),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDOB) {
      setState(() {
        selectedDOB = picked;

        if (isDob) {
          _updateProfileController.dob.text =
              DateFormat("dd-MM-yyyy").format(selectedDOB);
        } else {}
      });
    }
  }
}
