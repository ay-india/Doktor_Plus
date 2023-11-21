import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constant/constant.dart';
import '../../home/components/components.dart';

Widget doctorDetailPagePart(
  String name,
  String language,
  String exp,
  String specialization,
  String image,
  String about,
  int totalConsult,
) {
  return Container(
    padding: EdgeInsets.all(
      5.sp,
    ),
    height: 390.h,
    // color: Colors.red,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(3.sp),
              height: 80.h,
              width: 80.w,
              decoration: BoxDecoration(
                border: Border.all(color: grey),
                borderRadius: BorderRadius.circular(
                  100.r,
                ),
                image: DecorationImage(
                  image: NetworkImage(image),
                  fit: BoxFit.cover,
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
                    Icon(
                      Icons.verified,
                      size: 18.sp,
                      color: primary,
                    ),
                    SizedBox(
                      width: 6.w,
                    ),
                    customText(
                      "Dr. $name",
                      textColor,
                      15,
                      FontWeight.w700,
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.local_hospital_outlined,
                      size: 15.sp,
                      color: grey,
                    ),
                    SizedBox(
                      width: 6.w,
                    ),
                    customText(
                      specialization,
                      textColor,
                      13,
                      FontWeight.w400,
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.language,
                      size: 15.sp,
                      color: grey,
                    ),
                    SizedBox(
                      width: 6.w,
                    ),
                    customText(
                      "Speaks: $language",
                      textColor,
                      12,
                      FontWeight.w700,
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star_rounded,
                      size: 16.sp,
                      color: grey,
                    ),
                    SizedBox(
                      width: 6.w,
                    ),
                    customText(
                      "Experience: $exp Years",
                      textColor,
                      12,
                      FontWeight.w700,
                    ),
                  ],
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
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            customText(
              "About: Dr. $name",
              textColor,
              14,
              FontWeight.w500,
            ),
            Container(
              height: 210.h,
              child: SingleChildScrollView(
                child: Text(
                  about,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  // maxLines: 10,
                  // overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ]),
        )
      ],
    ),
  );
}

DateTime? selectedDate;
TimeOfDay? selectedTime;
Future<void> _selectDate(BuildContext context) async {
  final DateTime? pickedDate = await showDatePicker(
    
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime(2100),
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: Colors.amberAccent, // <-- SEE HERE
            onPrimary: Colors.redAccent, // <-- SEE HERE
            onSurface: Colors.blueAccent, // <-- SEE HERE
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              primary: Colors.red, // button text color
            ),
          ),
        ),
        child: child!,
      );
    },
  );

  if (pickedDate != null && pickedDate != selectedDate) {
    selectedDate = pickedDate;
  }
}

Future<void> _selectTime(BuildContext context) async {
  final TimeOfDay? pickedTime = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );

  if (pickedTime != null && pickedTime != selectedTime) {
    selectedTime = pickedTime;
  }
}
