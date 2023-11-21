import 'package:doktor_plus/src/constant/constant.dart';
import 'package:doktor_plus/src/screen/doctors_list/component/component.dart';
import 'package:doktor_plus/src/screen/home/components/appBar.dart';
import 'package:doktor_plus/src/screen/home/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'component/service.dart';

class Doctors extends StatefulWidget {
  final String number;
  final String name;
  const Doctors({super.key, required this.number,required this.name});

  @override
  State<Doctors> createState() => _DoctorsState();
}

class _DoctorsState extends State<Doctors> {
  List? doctorList;
  @override
  void initState() {
    super.initState();
    fetchDatabaseList();
  }

  fetchDatabaseList() async {
    dynamic resultant = await DatabaseManager().getUsersList();
    if (resultant == null) {
      print("Unable to retrieve");
    } else {
      setState(() {
        doctorList = resultant;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: doctorAppBar,
      body: Padding(
        padding: EdgeInsets.only(left: 14.w, right: 14, top: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            mediumTextBold(
              "Our Best Doctors",
              primary,
            ),
            mediumText(
              "Book appointments with minimum wait-time and verified doctor details.",
              grey,
            ),
            SizedBox(
              height: 20.h,
            ),
            // doctorView(
            //     "Afreen Nishat",
            //     "MBBS",
            //     "General Physician",
            //     "English, Hindi, Bengal",
            //     200.00,
            //     "asset/image/doctor.png",
            //     "2",
            //     context,
            //     widget.number),
            doctorList == null
                ? Container(
                    height: 500.h,
                    width: 300.w,
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(color: primary),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: doctorList!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 7.h, horizontal: 3.w),
                          child: doctorView(
                            widget.name,
                            doctorList![index]['mobile'],
                            doctorList![index]['name'],
                            doctorList![index]['degree'],
                            doctorList![index]['specialized'],
                            doctorList![index]['language'],
                            doctorList![index]['fee'],
                            doctorList![index]['image'],
                            doctorList![index]['exp'],
                            doctorList![index]['about'],
                            context,
                            widget.number,
                            doctorList![index]['total_cons'],
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
