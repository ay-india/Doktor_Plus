import 'package:doktor_plus/src/constant/constant.dart';
import 'package:doktor_plus/src/screen/home/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

PreferredSizeWidget? get appBar => AppBar(
  centerTitle: true,
      toolbarHeight: 45.h,
      shadowColor: Colors.grey,
      elevation: 3,
      leadingWidth: 60.w,
      backgroundColor: primary,
      automaticallyImplyLeading: true,
      title:
          
          Center(
            child: Row(
                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Spacer(),
                                    customText(
                                        "Doktor ", white, 26, FontWeight.w900),
                                    customText(
                                        "+", Colors.red, 35, FontWeight.w900),
                                        Spacer(),
                                        SizedBox(width: 40.h,),
                                  ],
                                ),
          ),
        
       
      // actions: [
      //   Padding(
      //     padding: const EdgeInsets.only(right: 22),
      //     child: Icon(Icons.search, color: white),
      //   ),
      // ],
    );
