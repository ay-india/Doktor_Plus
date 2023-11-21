import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constant/constant.dart';

TextFormField customTextForm(
    TextEditingController textEditingController, String hint, String disp) {
  return TextFormField(
      style: TextStyle(color: textColor),
      autofocus: false,
      controller: textEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("$disp cannot be Empty");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid $disp(Min. 3 Character)");
        }
        return null;
      },
      onSaved: (value) {
        textEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        // prefixIcon: Icon(Icons.account_circle),
        contentPadding: EdgeInsets.fromLTRB(20.sp, 15.sp, 20.sp, 15.sp),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.sp),
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
      ));
}

Widget aboutForm(TextEditingController aboutEditingController) {
  return SizedBox(
    height: 100.h,
    width: 315.w,
    child: TextFormField(
textAlign: TextAlign.start,
      maxLines: null,
      expands: true,
        style: TextStyle(color: textColor),
        autofocus: false,
        controller: aboutEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("About cannot be Empty");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid About(Min. 100 Character)");
          }
          return null;
        },
        onSaved: (value) {
          aboutEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          // prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20.sp, 15.sp, 20.sp, 15.sp),
          hintText: "Write about Yourself",
          hintStyle: const TextStyle(color: Colors.grey),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.sp),
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
        )),
  );
}
