import 'package:doktor_plus/src/constant/constant.dart';
import 'package:doktor_plus/src/screen/booking/booking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../home/components/components.dart';

PreferredSizeWidget? get doctorAppBar => AppBar(
      toolbarHeight: 45.h,
      shadowColor: Colors.grey,
      elevation: 3,
      leadingWidth: 60.w,
      backgroundColor: primary,
      automaticallyImplyLeading: true,
      title: Row(
        children: [
          Text(
            "Nearest Doctor",
            style: TextStyle(
                color: white, fontSize: 13.sp, fontWeight: FontWeight.w500),
          ),
          SizedBox(width: 5.w),
        ],
      ),
      // actions: [
      //   Padding(
      //     padding: const EdgeInsets.only(right: 22),
      //     child: Icon(Icons.search, color: white),
      //   ),
      // ],
    );

Widget doctorView(
  String patientName,
    String doctorContact,
    String name,
    String degree,
    String specialized,
    String language,
    String fee,
    String image,
    String exp,
    String about,
    BuildContext context,
    
    String number,
    int totalConsult,) {
  return InkWell(
    onTap: (){
      Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Booking(
                      patientName: patientName,
                      doctorContact:doctorContact,
                      name: name,
                      language: language,
                      specialization: specialized,
                      exp: exp,
                      amount: fee.toString(),
                      image: image,
                      number: number,
                      about: about,
                      totalConsult:totalConsult,
                    ),
                  ),
                );
    },
    child: Container(
      padding: EdgeInsets.all(
        4.sp,
      ),
      width: double.infinity,
      height: 205.h,
      decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(18.sp),
          boxShadow: [BoxShadow(blurRadius: 1.sp)]),
      child: Column(
        children: [
          Container(
            height: 160.h,
            width: double.infinity,
            child: Row(
              children: [
                Container(
                  height: 150.h,
                  width: 140.w,
                  // color: Colors.red,
                  child: Column(children: [
                    //image part
                    Container(
                      padding: EdgeInsets.all(8.sp),
                      height: 120.h,
                      width: 115.w,
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 1,
                            // offset: Offset(
                            //   1,
                            //   1,
                            // ),
                          ),
                        ],
                        image: DecorationImage(
                          image: NetworkImage(
                            image,
                          ),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(17.sp),
                        color: const Color.fromARGB(255, 222, 220, 220),
                      ),
                    ),
                    // ClipRRect(
                    //   borderRadius: BorderRadius.circular(14.sp),
                    //   child: FadeInImage.assetNetwork(
                    //     placeholder: 'asset/image/doctor.png',
                    //     image:image,
                    //     fit: BoxFit.cover,
                    //   ),
                    // ),
                    SizedBox(
                      height: 7.h,
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 17.h,
                      width: 90,
                      decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 1,
                              offset: Offset(
                                -1,
                                2,
                              ),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(
                            5.sp,
                          ),
                          color: Colors.lightBlue),
                      child: customText(
                        "$exp years exp",
                        white,
                        12,
                        FontWeight.w500,
                      ),
                    )
                  ]),
                ),
                Expanded(
                  child: Container(
                    height: 150.h,
                    padding: EdgeInsets.all(
                      8.sp,
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 12.h,
                          ),
                          customText(
                            "Dr. $name",
                            black,
                            16,
                            FontWeight.w600,
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          customText(
                            "$degree",
                            Colors.black87,
                            13,
                            FontWeight.w400,
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          customText(
                            specialized,
                            Colors.black87,
                            13,
                            FontWeight.w400,
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          customText(
                            "Speaks: $language",
                            Colors.black87,
                            13,
                            FontWeight.w400,
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          customText(
                            "Fees: $fee",
                            Colors.black87,
                            13,
                            FontWeight.w400,
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          Row(
                            children: [
                              customText(
                                "Available: ",
                                Colors.black87,
                                13,
                                FontWeight.w400,
                              ),
                              customText(
                                "Today",
                                Colors.blue,
                                13,
                                FontWeight.w600,
                              ),
                            ],
                          ),
                        ]),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              customButton(30, 130, 18, Color.fromARGB(255, 207, 232, 244),
                  primary, "Know More", 12, FontWeight.w700, 0, 0, () {
                showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                          12.r,
                        ),
                        topRight: Radius.circular(
                          12.r,
                        ),
                      ),
                    ),
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        padding: EdgeInsets.all(
                          15.sp,
                        ),
                        height: 300.h,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 80.h,
                                  width: 80.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      100.r,
                                    ),
                                    image: DecorationImage(
                                      image:  NetworkImage(image),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        customText(
                                          "Dr. $name",
                                          textColor,
                                          15,
                                          FontWeight.w700,
                                        ),
                                        SizedBox(
                                          width: 6.w,
                                        ),
                                        Icon(
                                          Icons.verified,
                                          size: 18.sp,
                                          color: primary,
                                        ),
                                      ],
                                    ),
                                    customText(
                                      degree,
                                      textColor,
                                      13,
                                      FontWeight.w400,
                                    ),
                                    customText(
                                      "$exp year of exp",
                                      textColor,
                                      12,
                                      FontWeight.w700,
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    customText(
                                      "Total Consultation: $totalConsult",
                                      textColor,
                                      13,
                                      FontWeight.w500,
                                    )
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 19.h,
                            ),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(12.sp),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  11.r,
                                ),
                                color: Color.fromARGB(93, 162, 179, 234),
                              ),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    customText(
                                      "About: Dr. $name",
                                      textColor,
                                      14,
                                      FontWeight.w500,
                                    ),
                                    Text(
                                      "$about",
                                      style: TextStyle(
                                        color: textColor,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      maxLines: 10,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ]),
                            )
                          ],
                        ),
                      );
                    });
              }),
              customButton(
                  30,
                  130,
                  18,
                  primary,
                  white,
                  "Fix Consult",
                  12,
                  FontWeight.w700,
                  0,
                  0, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Booking(
                      patientName: patientName,
                      doctorContact:doctorContact,
                      name: name,
                      language: language,
                      specialization: specialized,
                      exp: exp,
                      amount: fee.toString(),
                      image: image,
                      number: number,
                      about: about,
                      totalConsult:totalConsult,
                    ),
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    ),
  );
}
