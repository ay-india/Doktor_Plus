import 'package:doktor_plus/src/doktor_plus_partner/video_call/call.dart';
import 'package:doktor_plus/src/screen/prescription/view_prescription.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../constant/constant.dart';
import '../../../home/components/components.dart';

Widget appointmentCard(String appId, String patientName,String number,String symptoms, String date, String time, String doctorName,String specialization,String image,bool completed,bool isOnline,BuildContext context ) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 14.sp,vertical: 2.h),
    height: 185.h,
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal:12.sp,vertical: 8.h),
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
            Icon(Icons.circle,color:completed==false?Colors.green:Colors.red ,size: 12.h,),
            SizedBox(width: 5.w,),
            customText(
                completed==false?"Open" : "Closed", completed==false?Colors.green:Colors.red, 16, FontWeight.w800),
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
        height: 70.h,
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
                width: 50.w,
                decoration: BoxDecoration(
                  boxShadow: [BoxShadow(blurRadius: 2)],
                  borderRadius: BorderRadius.circular(100),
                  color: const Color.fromARGB(255, 225, 222, 222),
                  image: DecorationImage(
                    image: NetworkImage(image),
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
                  customText("Dr. $doctorName", textColor, 16, FontWeight.w500),
                  SizedBox(height: 3.h,),
                  customText("$specialization", textColor, 12, FontWeight.w400)
                ],
              )
            ],
          )
        ]),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          isOnline==true?
          Align(
              alignment: Alignment.topLeft,
              child: customButton(
                  25, 100, 7, Colors.red[400]!, white, "Join Call", 12, FontWeight.w700, 1, 0,
                  () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context)=> CallPage(callID: appId, userName: patientName, userId: number) ));
              })):Container(),
     completed==true? Align(
              alignment: Alignment.topRight,
              child: customButton(
                  25, 140, 7, primary, white, "View Prescription", 12, FontWeight.w600, 1, 0,
                  () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context)=> ViewPrescriptionPage(id: appId, number: number,title: symptoms,) ));
              })): Container(),
        ],
      ),
    ]),
  );
}
