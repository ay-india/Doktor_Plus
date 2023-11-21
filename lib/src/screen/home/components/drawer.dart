import 'dart:convert';

import 'package:doktor_plus/src/constant/constant.dart';
import 'package:doktor_plus/src/screen/pages/appointment/appointment.dart';
import 'package:doktor_plus/src/screen/prescription/prescription.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/utils.dart';
import '../../pages/splash/splash.dart';
import '../../pages/user_info/userProfile.dart';

Widget drawerContent(
        BuildContext context, String number, String name, String image) =>
    Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              SizedBox(
                height: 8.h,
              ),
              Container(
                height: 140.h,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => profile(
                                        number: number,
                                      )));
                        },
                        child: Container(
                          height: 100.h,
                          width: 110.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.sp),
                              image: DecorationImage(
                                image: MemoryImage(
                                  Base64Decoder().convert(image),
                                ),
                                fit: BoxFit.cover,
                              )),
                          // child: ClipRRect(
                          //   borderRadius: BorderRadius.circular(14.sp),
                          //   child: FadeInImage.assetNetwork(
                          //     placeholder: 'asset/image/user.jpg',
                          //     image: Base64Decoder().convert(image),
                          //     // image: image,
                          //     // image: "https://tinyurl.com/55snkhwf",
                          //     fit: BoxFit.cover,
                          //   ),
                          // ),
                        ),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 60),
                        width: 130.w,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Welcome",
                                style: TextStyle(
                                    color: primary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.sp),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Text(
                                "$name",
                                style: TextStyle(
                                  color: black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 19.sp,
                                ),
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              profile(number: number)));
                                },
                                child: Text(
                                  "View/Edit Profile",
                                  style: TextStyle(
                                      color: primary,
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ]),
                      )
                    ]),
              ),
              Divider(
                color: grey,
                thickness: 1.h,
              ),
              SizedBox(
                height: 10.h,
              ),
              ListTile(
                leading: Icon(
                  Icons.calendar_month,
                  color: primary,
                ),
                title: Text("My Appointment",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: black,
                        fontSize: 15.sp)),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyAppointment(
                                number: number,
                              )));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.account_box,
                  color: primary,
                ),
                title: Text("My Prescription",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: black,
                        fontSize: 15.sp)),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyPrescription(number: number,)));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.grid_3x3_outlined,
                  color: primary,
                ),
                title: Text("Offers",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: black,
                        fontSize: 15.sp)),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(
                  Icons.image_aspect_ratio_outlined,
                  color: primary,
                ),
                title: Text("About App",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: black,
                        fontSize: 15.sp)),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(
                  Icons.account_box,
                  color: primary,
                ),
                title: Text("Logout",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: black,
                        fontSize: 15.sp)),
                onTap: () {
                  final FirebaseAuth auth = FirebaseAuth.instance;
                  clearSavedData();
                  auth.signOut();
                  Navigator.of(context, rootNavigator: true).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => new splash(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),

        // user
        Container(
          padding: EdgeInsets.all(10.sp),
          width: double.infinity,
          height: 66.h,
          color: primary,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "Version: 0.0.1",
              style: TextStyle(
                  color: white, fontSize: 11.sp, fontWeight: FontWeight.w500),
            ),
            Text(
              "Powered by Ashish Yadav",
              style: TextStyle(
                  color: white, fontSize: 11.sp, fontWeight: FontWeight.w500),
            ),
            Row(
              children: [
                Icon(
                  Icons.copyright_outlined,
                  color: white,
                ),
                Text(
                  "Ashish Yadav",
                  style: TextStyle(
                      color: white,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500),
                ),
              ],
            )
          ]),
        )
      ],
    );
