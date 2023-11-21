import 'package:doktor_plus/src/doktor_plus_partner/pages/patient/patient.dart';
import 'package:doktor_plus/src/screen/prescription/view_prescription.dart';
import 'package:doktor_plus/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constant/constant.dart';
import '../../../screen/home/components/components.dart';

Widget appointmentCardDoctor(
  String appId,
  String doctorNumber,
  String patientNumber,
  String symptoms,
  String date,
  String time,
  String doctorName,
  String specialization,
  String image,
  bool completed,
  BuildContext context,
) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 14.sp, vertical: 2.h),
    height: 192.h,
    width: double.infinity,
    padding: EdgeInsets.all(12.sp),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          15.r,
        ),
        boxShadow: [
          BoxShadow(
            blurStyle: BlurStyle.outer,
            blurRadius: 1.r,
          )
        ]),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Align(
        alignment: Alignment.topRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              Icons.circle,
              color: completed == false ? Colors.green : Colors.red,
              size: 12.h,
            ),
            SizedBox(
              width: 5.w,
            ),
            customText(
                completed == false ? "Open" : "Closed",
                completed == false ? Colors.green : Colors.red,
                16,
                FontWeight.w800),
          ],
        ),
      ),
      customText("$symptoms", textColor, 20, FontWeight.w700),
      SizedBox(
        height: 2.h,
      ),
      customText("$date | $time ", textColor, 13, FontWeight.w500),
      SizedBox(
        height: 2.h,
      ),
      Container(
        height: 66.h,
        width: double.infinity,
        margin: EdgeInsets.all(9.sp),
        padding: EdgeInsets.symmetric(
          vertical: 8.h,
          horizontal: 15.w,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            8.r,
          ),
          boxShadow: [
            BoxShadow(color: grey, blurStyle: BlurStyle.outer, blurRadius: 2)
          ],
          color: Colors.white,
        ),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 50.h,
                width: 50.h,
                decoration: BoxDecoration(
                  boxShadow: [BoxShadow(blurRadius: 2)],
                  borderRadius: BorderRadius.circular(100),
                  color: const Color.fromARGB(255, 225, 222, 222),
                  image: DecorationImage(
                    image: AssetImage("asset/icon/patient.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                width: 12.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customText("Patient", textColor, 13, FontWeight.w400),
                  customText("$doctorName", textColor, 16, FontWeight.w700),
                  SizedBox(
                    height: 3.h,
                  ),
                ],
              )
            ],
          )
        ]),
      ),
      completed==false?
      Align(
          alignment: Alignment.topRight,
          child: customButton(
              30, 90, 7, primary, white, "Connect", 12, FontWeight.w600, 1, 0,
              () {
         
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PatientPage(
                          appointmentId: appId,
                          doctorName: doctorName,
                          doctorNumber: doctorNumber,
                          patientNumber: patientNumber,
                        )));
          })):Align(
          alignment: Alignment.topRight,
          child: customButton(
              30, 120, 7, primary, white, "View Prescription", 12, FontWeight.w600, 1, 0,
              () {
         
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ViewPrescriptionPage(id: appId, number: patientNumber, title: symptoms)));
          })),
    ]),
  );
}
