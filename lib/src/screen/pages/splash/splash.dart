import 'package:doktor_plus/src/constant/constant.dart';
import 'package:doktor_plus/src/doktor_plus_partner/doctor_home/doctor_home.dart';
import 'package:doktor_plus/src/screen/home/home.dart';
import 'package:doktor_plus/src/screen/pages/onboarding.dart';
import 'package:doktor_plus/src/screen/pages/user_info/userInfo.dart';
import 'package:doktor_plus/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../home/components/components.dart';

class splash extends StatefulWidget {
  const splash({super.key});

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  void initState() {
    super.initState();
    _navigatetologin();
  }

  _navigatetologin() async {
    await Future.delayed(Duration(seconds: 5), () {});
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String number = prefs.getString("phone") ?? "+911111111111";
    bool isLogin = prefs.getBool("isLogin") ?? false;
    String user = prefs.getString("user")??"patient";
    savedName = prefs.getString("name") ?? "";

    isLogin
        ? {
            user == "patient"
                ? Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomePage(number: number)))
                : Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DoctorHome(number: number)))
          }
        : Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => OnBoardingScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    // padding: EdgeInsets.all(16.sp),
                    height: 122.h,
                    width: 122.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.sp),
                      color: Colors.transparent,
                    ),
                    child: Container(
                      height: 89.h,
                      width: 89.w,
                      decoration: const BoxDecoration(
                        // color: Color(0xFF25265F),
                        image: DecorationImage(
                          image: AssetImage("asset/icon/icon.png"),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 7.64.h,
                  ),
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
                  Text(
                    "Always there for YOU",
                    style: TextStyle(
                      color: textColor,
                      letterSpacing: 1.2.sp,
                      fontSize: 12.42.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "asset/icon/icon.png",
                  width: 40.w,
                  height: 40.h,
                ),
                SizedBox(
                  width: 10.38.w,
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Developer",
                        style: TextStyle(
                            color: Color(0xFF484848),
                            fontSize: 11.54.sp,
                            fontStyle: FontStyle.italic),
                      ),
                      Text(
                        "Ashish Yadav",
                        style: TextStyle(
                            color: Color(0xFF484848),
                            fontSize: 12.69.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
