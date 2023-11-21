import 'package:doktor_plus/src/constant/constant.dart';
import 'package:doktor_plus/src/constant/constant.dart';
import 'package:doktor_plus/src/screen/doctors_list/doctors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget mediumTextBold(
  String text,
  Color color,
) {
  return Text(
    overflow: TextOverflow.ellipsis,
    text,
    style: TextStyle(
      letterSpacing: 0.1,
      color: color,
      fontWeight: FontWeight.w700,
      fontSize: 14.sp,
    ),
  );
}

Widget mediumText(String text, Color color) {
  return Text(
    text,
    style: TextStyle(
        overflow: TextOverflow.ellipsis,
        letterSpacing: 0.1,
        color: color,
        // fontWeight: FontWeight.w600,
        fontSize: 11.6.sp,
        fontWeight: FontWeight.w400),
  );
}

Widget serviceMode(String text, String image,BuildContext context,String number,String name) {
  return SizedBox(
    height: 140.h,
    width: 120.w,
    child: Column(children: [
      InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Doctors(number: number,name: name,),),);
        },
        child: Container(
          height: 110.h,
          width: 120.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.sp),
              image:
                  DecorationImage(image: AssetImage(image), fit: BoxFit.cover)),
        ),
      ),
      SizedBox(
        height: 8.h,
      ),
      mediumTextBold(text, CupertinoColors.black)
    ]),
  );
}

Widget customText(String text, Color color, double size, FontWeight weight) {
  return Text(
    text,
    style: TextStyle(
      overflow: TextOverflow.ellipsis,
      letterSpacing: 0.1,
      color: color,
      fontWeight: weight,
      fontSize: size.sp,
    ),
  );
}

Widget customButton(
  double height,
  double width,
  double radius,
  Color color,
  Color textColor,
  String text,
  double fontSize,
  FontWeight fontWeight,
  int shadow,
  int border,
  Function()? onTap,
) {
  return InkWell(
    onTap: onTap,
    child: Container(
      alignment: Alignment.center,
      height: height.h,
      width: width.w,
      decoration: BoxDecoration(
        border: border == 1
            ? Border.all(
                color: grey,
              )
            : Border(),
        boxShadow: [
          shadow == 1
              ? BoxShadow(
                  blurRadius: 1,
                  offset: Offset(
                    -1,
                    2,
                  ),
                )
              : BoxShadow(
                  blurRadius: 0,
                ),
        ],
        color: color,
        borderRadius: BorderRadius.circular(
          radius.sp,
        ),
      ),
      child: customText(
        text,
        textColor,
        fontSize,
        fontWeight,
      ),
    ),
  );
}

Widget recommedDoctorCard() {
  return Container(
    padding: EdgeInsets.all(
      4.sp,
    ),
    width: double.infinity,
    height: 170.h,
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
                  Container(
                    padding: EdgeInsets.all(8.sp),
                    height: 120.h,
                    width: 115.w,
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
                      image: const DecorationImage(
                        image: AssetImage(
                          "asset/image/doctor.png",
                        ),
                        fit: BoxFit.fill,
                      ),
                      borderRadius: BorderRadius.circular(17.sp),
                      color: primary,
                    ),
                  ),
                  SizedBox(
                    height: 7.h,
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 17.h,
                    width: 90.w,
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
                      "18 years exp",
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
                          "Dr. Pawan Kumar",
                          black,
                          16,
                          FontWeight.w600,
                        ),
                        customText(
                          "BPTh/BPT",
                          Colors.black87,
                          13,
                          FontWeight.w400,
                        ),
                        customText(
                          "Physiotherapy",
                          Colors.black87,
                          13,
                          FontWeight.w400,
                        ),
                        customText(
                          "Speaks: English, Hindi",
                          Colors.black87,
                          13,
                          FontWeight.w400,
                        ),
                      ]),
                ),
              )
            ],
          ),
        ),
        // SizedBox(
        //   height: .h,
        // ),
        //buttons are comment off
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //   children: [
        //     customButton(
        //       25,
        //       120,
        //       18,
        //       Color.fromARGB(255, 207, 232, 244),
        //       primary,
        //       "Know More",
        //       12,
        //       FontWeight.w700,
        //       1,
        //       0,
        //       (){}
        //     ),
        //     customButton(
        //       25,
        //       120,
        //       18,
        //       primary,
        //       Color.fromARGB(255, 214, 232, 240),
        //       "Call Now",
        //       12,
        //       FontWeight.w700,
        //       1,
        //       0,
        //       (){
                
        //       }
        //     ),
        //   ],
        // ),
      ],
    ),
  );
}

Widget doctorCard(String text, String image,Function()? onTap) {
  return InkWell(
    onTap: onTap,
    child: SizedBox(
      height: 100.h,
      width: 90.w,
      child: Column(children: [
        Container(
          height: 78.h,
          width: 90.w,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 2,
                  offset: Offset(
                    -1.h,
                    0.h,
                  ),
                  color: grey,
                ),
              ],
              borderRadius: BorderRadius.circular(
                15.sp,
              ),
              image:
                  DecorationImage(image: AssetImage(image), fit: BoxFit.cover)),
        ),
        SizedBox(
          height: 8.h,
        ),
        mediumText(text, const Color.fromARGB(255, 121, 117, 117))
      ]),
    ),
  );
}

Widget symptomsHeading(String text) {
  return Row(
    children: [
      customText(
        text,
        textColor,
        13,
        FontWeight.w600,
      ),
      SizedBox(
        width: 15.w,
      ),
      Container(
        height: 2.h,
        width: 150.w,
        color: primary,
      ),
    ],
  );
}

Widget symptomsCard(String icon, String text,Function()? onTap) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
      ),
      height: 70.h,
      width: 158.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          8.r,
        ),
        color: secondary,
      ),
      child: Row(children: [
        Container(
          height: 50.h,
          width: 50.w,
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(
              10.r,
            ),
            image: DecorationImage(
              image: AssetImage(
                "asset/image/$icon",
              ),
            ),
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        Expanded(
          child: Text(
            text,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: textColor,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ]),
    ),
  );
}

Widget consultDoctor(
    String image, String title, String subtitle, double amount,Function()? onTap) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.all(
        4.sp,
      ),
      height: 235.h,
      width: 160.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 170.h,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                10.r,
              ),
              boxShadow: [
                BoxShadow(
                  color: grey,
                  blurRadius: 1.sp,
                ),
              ],
              image: DecorationImage(
                image: AssetImage("asset/image/$image"),
                fit: BoxFit.cover,
              ),
              color: black,
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          mediumTextBold(
            "$title",
            textColor,
          ),
          Text(
            "$subtitle",
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w400,
              color: textColor,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customText(
                "Avail in 2 min",
                primary,
                11,
                FontWeight.w400,
              ),
              customText(
                "Avail in: ₹ $amount",
                primary,
                11,
                FontWeight.bold,
              )
            ],
          )
        ],
      ),
    ),
  );
}

Widget get endPart {
  return Container(
    width: double.infinity,
    height: 177.h,
    decoration: BoxDecoration(
        color: Color(0xFF3D79D2),
        image: DecorationImage(
            image: AssetImage("asset/image/end_part.png"),
            fit: BoxFit.contain)),
  );
}
