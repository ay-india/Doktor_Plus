import 'package:doktor_plus/src/constant/constant.dart';
import 'package:doktor_plus/src/doktor_plus_partner/doctor_home/doctor_home.dart';
import 'package:doktor_plus/src/doktor_plus_partner/pages/doctor_info/doctor_info.dart';

import 'package:doktor_plus/src/screen/home/home.dart';
import 'package:doktor_plus/src/screen/pages/appointment/appointment.dart';
import 'package:doktor_plus/src/screen/pages/onboarding.dart';
import 'package:doktor_plus/src/screen/pages/splash/splash.dart';
import 'package:doktor_plus/src/screen/pages/user_choice.dart';
import 'package:doktor_plus/src/screen/pages/user_info/userInfo.dart';
import 'package:doktor_plus/src/screen/prescription/view_prescription.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: primary,
      statusBarBrightness: Brightness.light,
    ));
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Doktor+',
          theme: ThemeData(
            primaryColor: primary,

            // primarySwatch: Colors.blue,
            textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
          ),
          home: child,
        );
      },
      child: splash(),
    );
  }
}
