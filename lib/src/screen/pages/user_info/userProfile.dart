// import 'dart:html';

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doktor_plus/src/constant/constant.dart';
import 'package:doktor_plus/src/screen/home/components/components.dart';
import 'package:doktor_plus/src/screen/pages/user_info/components/components.dart';
import 'package:doktor_plus/src/screen/pages/user_info/editProfile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../splash/splash.dart';

class profile extends StatefulWidget {
  final String number;
  const profile({super.key, required this.number});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  late String languageSelected;
  int _selectedIndex = 1;
  int enButtonColor = 0;

  int hiButtonColor = 0;

  int nextButtonColor = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // String number = "+911111111111";
  @override
  void initState() {
    // _getPhoneNumber();
    _getUserName(widget.number);
    // TODO: implement initState
    super.initState();
  }

  // _getPhoneNumber() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   number = prefs.getString("phone") ?? "+911111111111";
  // }

  var UserData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("Profile"),
      body: SingleChildScrollView(
        child: Center(
            child: UserData == null
                ? Container(
                    alignment: Alignment.center,
                    height: double.infinity,
                    width: double.infinity,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: primary,
                      ),
                    ),
                  )
                : Column(
                    children: [
                      SizedBox(
                        height: 5.h,
                      ),
                      Container(
                        height: 225.h,
                        width: 356.w,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 111.h,
                                width: 121.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100.sp),
                                    image: DecorationImage(
                                      image: MemoryImage(
                                        Base64Decoder()
                                            .convert(UserData['image']),
                                      ),
                                      fit: BoxFit.cover,
                                    )),
                              ),
                              Container(
                                height: 70.h,
                                width: double.infinity,
                                // color: Colors.blue,
                                child: Column(children: [
                                  SizedBox(
                                    height: 4.h,
                                  ),
                                  customText(UserData['name'], textColor, 19,
                                      FontWeight.w500),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                      ),
                                      customText(UserData['address'] ?? "India",
                                          textColor, 12, FontWeight.w500),
                                    ],
                                  ),
                                ]),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 17.sp),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditProfileScreen(
                                          image: UserData['image'],
                                          id: UserData['id'],
                                          number: UserData['phonenumber'],
                                          dob: UserData['dob'],
                                          email: UserData['email'],
                                          gender: UserData['gender'],
                                          name: UserData['name'],
                                          address: UserData['address'],
                                          allergy: UserData['allergy'],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Icon(
                                          Icons.edit,
                                          color: Color(0xff272727),
                                          size: 21.sp,
                                        ),
                                        SizedBox(
                                          width: 3.w,
                                        ),
                                        customText("Edit Bio", textColor, 16,
                                            FontWeight.w700),
                                      ]),
                                ),
                              )
                            ]),
                      ),
                      detailBox("Full Name", UserData['name']),
                      SizedBox(
                        height: 9.h,
                      ),
                      SizedBox(
                        height: 9.h,
                      ),
                      detailBox("Email ID", UserData['email']),
                      SizedBox(
                        height: 9.h,
                      ),
                      detailBox("Contact Number", UserData['phonenumber']),
                      SizedBox(
                        height: 9.h,
                      ),
                      detailBox("Gender", UserData['gender']),
                      SizedBox(
                        height: 9.h,
                      ),
                      detailBox("Allergy", UserData['allergy']),
                      SizedBox(
                        height: 9.h,
                      ),
                      detailBox("Address", UserData['address']),
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                        padding: EdgeInsets.all(23.sp),
                        height: 293.h,
                        width: 332.w,
                        decoration: BoxDecoration(
                          color: Color(0xfff4f6ff),
                          borderRadius: BorderRadius.circular(19.sp),
                        ),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            
                            endText("Help", () {}),
                            SizedBox(
                              height: 3.sp,
                            ),
                            Divider(
                              color: Color(0xffcfcfcf),
                              thickness: 1.6.sp,
                            ),
                            SizedBox(
                              height: 1.sp,
                            ),
                            endText("Notifications", () {}),
                            SizedBox(
                              height: 3.sp,
                            ),
                            Divider(
                              color: Color(0xffcfcfcf),
                              thickness: 1.6.sp,
                            ),
                            SizedBox(
                              height: 1.sp,
                            ),
                            endText("Logout", () {
                              clearSavedData();
                              auth.signOut();
                              Navigator.of(context, rootNavigator: true)
                                  .pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => new splash(),
                                ),
                              );
                            }),
                            SizedBox(
                              height: 3.sp,
                            ),
                            Divider(
                              color: Color(0xffcfcfcf),
                              thickness: 1.6.sp,
                            ),
                            endText('Terms of Services & privacy Policies',
                                () => null),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 50.h,
                      ),
                    ],
                  )),
      ),
    );
  }

  Future<void> _getUserName(String no) async {
    await FirebaseFirestore.instance
        .collection('userDetail')
        .where('phonenumber', isEqualTo: no)
        .limit(1)
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              setState(() {
                print("-------------${document.data()}");
                UserData = document.data();
              });

              //docIDs.add(document.reference.id);
            }));
  }

  Widget detailBox(String title, String data) {
    return Container(
      height: 54.h,
      width: 332.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.sp), color: Color(0xfff4f6ff)),
      child: Column(children: [
        Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 25.6.w, top: 12.7.h),
              child: Text(
                '$title',
                style: TextStyle(
                  color: Color(0xff25265f),
                  fontSize: 10.9.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            )),
        Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 25.6.w, top: 5.sp),
              child: Text(
                '$data',
                style: TextStyle(
                  color: Color(0xff25265f),
                  fontSize: 14.9.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ))
      ]),
    );
  }

  Widget endText(String title, Function()? onTap) {
    return Padding(
      padding: EdgeInsets.all(1.sp),
      child: InkWell(
        onTap: onTap,
        child: Text(
          "$title",
          style: TextStyle(
            color: Color(0xff25265f),
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

clearSavedData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();
}
