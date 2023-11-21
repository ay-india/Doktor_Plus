import 'package:doktor_plus/src/constant/constant.dart';
import 'package:doktor_plus/src/doktor_plus_partner/doctor_home/component/component.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../screen/home/components/components.dart';
import '../../screen/pages/appointment/components/components.dart';
import '../../screen/pages/splash/splash.dart';
import '../../screen/pages/user_info/userProfile.dart';
import 'component/service.dart';

class DoctorHome extends StatefulWidget {
  final String number;
  const DoctorHome({super.key, required this.number});

  @override
  State<DoctorHome> createState() => _DoctorHomeState();
}

class _DoctorHomeState extends State<DoctorHome> {
  List? userList;
  List? appointmentList;
  List? patientList;
  @override
  void initState() {
    fetchUserList();
    fetchDatabaseList();

    // TODO: implement initState
    super.initState();
  }

  fetchDatabaseList() async {
    dynamic resultant =
        await UserDatabaseManager().getAppointmentList(widget.number);
    if (resultant == null) {
      print("Unable to retrieve");
    } else {
      setState(() {
        appointmentList = resultant;
      });
    }
  }

  fetchUserList() async {
    dynamic resultant = await UserDatabaseManager().getUserList(widget.number);
    if (resultant == null) {
      print("Unable to retrieve");
    } else {
      setState(() {
        userList = resultant;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: userList == null
              ? Container(
                  height: 500.h,
                  width: double.infinity.w,
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(color: primary),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 140.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 3.r,
                              blurStyle: BlurStyle.outer),
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 3.r,
                              blurStyle: BlurStyle.outer)
                        ],
                        color: Colors.white70,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(
                            12.r,
                          ),
                          bottomRight: Radius.circular(
                            12.r,
                          ),
                        ),
                      ),
                      child: Column(children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: 12.sp,
                              right: 14.sp,
                              left: 14.sp,
                              bottom: 3.sp),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                  height: 40.h,
                                  width: 40.w,
                                  child: Image.asset("asset/icon/wallet.png")),
                              Row(
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  customText(
                                      "Doktor ", primary, 28, FontWeight.w900),
                                  customText(
                                      "+", Colors.red, 35, FontWeight.w900),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  final FirebaseAuth auth =
                                      FirebaseAuth.instance;
                                  clearSavedData();
                                  auth.signOut();
                                  Navigator.of(context, rootNavigator: true)
                                      .pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => new splash(),
                                    ),
                                  );
                                },
                                child: SizedBox(
                                    height: 25.h,
                                    width: 31.w,
                                    child:
                                        Image.asset("asset/icon/logout.png")),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: grey,
                          thickness: 1,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 14.sp, vertical: 3.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 60.h,
                                width: 60.h,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            userList![0]['image']))),
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  customText(
                                    "Dr. " + userList![0]['name'],
                                    textColor,
                                    17,
                                    FontWeight.w600,
                                  ),
                                  customText(
                                    userList![0]['specialized'],
                                    textColor,
                                    12,
                                    FontWeight.w500,
                                  ),
                                ],
                              ),
                              Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  customText("Fee: " + userList![0]['fee'],
                                      textColor, 14, FontWeight.w600),
                                  customText(
                                    "Exp. " + userList![0]['exp'] + " Years",
                                    textColor,
                                    12,
                                    FontWeight.w500,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ]),
                    ),
                    // SizedBox(height: 10.h,),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 14.w, vertical: 12.h),
                      height: 104.h,
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(horizontal: 0.sp, vertical: 7.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 2.r,
                              blurStyle: BlurStyle.outer,
                              color: grey,
                            )
                          ]),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: 50.h,
                                  width: 60.w,
                                  child: Image.asset("asset/icon/tick.png"),
                                ),
                                Spacer(),
                                customText(
                                  "Closed",
                                  textColor,
                                  13,
                                  FontWeight.w500,
                                ),
                                Spacer(),
                                customText(
                                  "6",
                                  Colors.black,
                                  19,
                                  FontWeight.w900,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: 50.h,
                                  width: 60.w,
                                  child: Image.asset("asset/icon/active.png"),
                                ),
                                Spacer(),
                                customText(
                                  "Active",
                                  textColor,
                                  13,
                                  FontWeight.w500,
                                ),
                                Spacer(),
                                customText(
                                  "2",
                                  Colors.black,
                                  19,
                                  FontWeight.w900,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: 50.h,
                                  width: 60.w,
                                  child: Image.asset("asset/icon/open.png"),
                                ),
                                Spacer(),
                                customText(
                                  "Open",
                                  textColor,
                                  13,
                                  FontWeight.w500,
                                ),
                                Spacer(),
                                customText(
                                  "1",
                                  Colors.black,
                                  19,
                                  FontWeight.w900,
                                ),
                              ],
                            ),
                          ]),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.sp,
                        vertical: 4.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          mediumTextBold(
                            "My Patients",
                            primary,
                          ),
                          mediumText("Where Patient Well-being Comes First! ",
                              textColor),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Expanded(
                        child: appointmentList == null
                            ? Container(
                                height: 500.h,
                                width: 300.w,
                                alignment: Alignment.center,
                                child: const CircularProgressIndicator(
                                    color: primary),
                              )
                            : appointmentList!.length != 0
                                ? ListView.builder(
                                    itemCount: appointmentList!.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 6.h, horizontal: 3.w),
                                        child: appointmentCardDoctor(
                                            appointmentList![index]['id'],
                                            appointmentList![index]['doctor'],
                                            appointmentList![index]['patient'],
                                            appointmentList![index]['symptoms'],
                                            appointmentList![index]['date'],
                                            appointmentList![index]['time'],
                                            appointmentList![index]
                                                ['patient_name'],
                                            appointmentList![index]
                                                ['specialized'],
                                            appointmentList![index]
                                                ['doctor_image'],
                                            appointmentList![index]
                                                ['completed'],
                                            context),
                                      );
                                    },
                                  )
                                : Center(
                                    child: customText(
                                        "Seamless, Hassle-Free\n   Consultations Await!",
                                        textColor,
                                        18,
                                        FontWeight.w600),
                                  ))
                  ],
                )),
    );
  }
}
