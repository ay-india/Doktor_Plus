import 'package:doktor_plus/src/constant/constant.dart';
import 'package:doktor_plus/src/screen/home/components/components.dart';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login/login.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              Color.fromARGB(255, 17, 88, 241),
              Color.fromARGB(230, 25, 87, 221),
              Color.fromARGB(255, 26, 103, 219),
              Color.fromARGB(225, 21, 100, 210),
              Color.fromARGB(232, 44, 115, 215),
              Color.fromARGB(255, 44, 125, 218),
              Color.fromARGB(237, 46, 113, 207),
            ],
            tileMode: TileMode.mirror,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(),
            Container(
              child: Column(children: [
                Container(
                  height: 150.h,
                  width: 140.h,
                  child: Image.asset("asset/icon/online.png"),
                ),
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    customText("Doktor ", white, 48, FontWeight.w900),
                    customText("+", Colors.red, 50, FontWeight.w900),
                  ],
                ),
                customText(
                  "ALWAYS THERE FOR YOU",
                  Color.fromARGB(255, 223, 221, 221),
                  12,
                  FontWeight.w400,
                ),
              ]),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customText(
                    "Please register yourself",
                    white,
                    15,
                    FontWeight.w600,
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  customText(
                    "Select the appropriate choice below",
                    white,
                    12,
                    FontWeight.w400,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25.h,
            ),
            optionCard(
                "I am a Patient",
                "Seeking skilled, experienced\nmedical care options.",
                "asset/icon/examination1.png", () {
              setUserMode("patient");
              Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
            }),
            optionCard("I am a doctor", "Able to treat the potients\nanywhere.",
                "asset/icon/doctor.png", () {
              setUserMode("doctor");
              Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
            }),
            SizedBox(
              height: 25.h,
            ),
          ],
        ),
      )),
    );
  }
}

Widget optionCard(
    String title, String content, String image, Function()? onTap) {
  return InkWell(
    onTap: onTap,
    child: Container(
      margin: EdgeInsets.all(
        12.sp,
      ),
      padding: EdgeInsets.all(
        12.sp,
      ),
      height: 100.h,
      width: double.infinity,
      decoration: BoxDecoration(
          color: const Color.fromARGB(171, 140, 172, 221),
          borderRadius: BorderRadius.circular(
            12.r,
          )),
      child: Row(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: double.maxFinite,
              width: 100.h,
              decoration: BoxDecoration(
                // color: Colors.red,
                image: DecorationImage(
                  image: AssetImage(image),
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
                SizedBox(
                  height: 5.h,
                ),
                customText(
                  title,
                  white,
                  16,
                  FontWeight.w600,
                ),
                SizedBox(
                  height: 4.h,
                ),
                customText(
                  content,
                  Colors.white,
                  12,
                  FontWeight.w400,
                ),
              ],
            )
          ]),
    ),
  );
}

setUserMode(String user) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString("user", user);
}
