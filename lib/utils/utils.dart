import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../src/constant/constant.dart';

Future<dynamic> diaglog(BuildContext context, String title, String content) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "$title",
            style: TextStyle(color: textColor),
          ),
          content: Text(
            '$content',
            style: TextStyle(color: textColor),
          ),
        );
      });
}

AwesomeDialog displayErrorDialog(
    BuildContext context, String title, String desc) {
  return AwesomeDialog(
    // alignment: Alignment.topCenter,
    titleTextStyle: TextStyle(
        color: textColor, fontWeight: FontWeight.w600, fontSize: 20.sp),
    descTextStyle: const TextStyle(
      color: textColor,
    ),
    context: context,
    dialogType: DialogType.info,
    animType: AnimType.rightSlide,
    title: title,
    desc: desc,
    // btnCancelOnPress: () {},
    btnOkOnPress: () {},
  )..show();
}

AwesomeDialog displayWarningDialog(
    BuildContext context, String title, String desc) {
  return AwesomeDialog(
    // alignment: Alignment.topCenter,
    titleTextStyle: TextStyle(
        color: textColor, fontWeight: FontWeight.w600, fontSize: 20.sp),
    descTextStyle: const TextStyle(
      color: textColor,
    ),
    context: context,
    dialogType: DialogType.warning,
    animType: AnimType.rightSlide,
    title: title,
    desc: desc,
    // btnCancelOnPress: () {},
    btnOkOnPress: () {},
  )..show();
}
AwesomeDialog displaySuccessDialog(
    BuildContext context, String title, String desc) {
  return AwesomeDialog(
    // alignment: Alignment.topCenter,
    titleTextStyle: TextStyle(
        color: textColor, fontWeight: FontWeight.w600, fontSize: 20.sp),
    descTextStyle: const TextStyle(
      color: textColor,
    ),
    context: context,
    dialogType: DialogType.success,
    animType: AnimType.rightSlide,
    title: title,
    desc: desc,
    // btnCancelOnPress: () {},
    btnOkOnPress: () {},
  )..show();
}

String savedName="";
dynamic showToast(String title) =>
Fluttertoast.showToast(
        msg: title,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: primary,
        textColor: Colors.white,
        fontSize: 16.0
    );