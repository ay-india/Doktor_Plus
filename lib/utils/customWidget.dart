import 'package:doktor_plus/src/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CustomWidget{
  void hidProgress({required BuildContext context}){
    return Navigator.pop(context);

  }

  Future showProgress(
      {
        required BuildContext context,


      }){
    return showDialog(context: context,
        barrierDismissible: false,


        builder: (BuildContext context){
          return WillPopScope(
            onWillPop: () async => false,

            child: Container(
              width: 100,
              height: 100,
              child: CircleAvatar(
                radius: 100.r,

                backgroundColor: Colors.transparent,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 30.r,
                  child: CircularProgressIndicator(
                    color: primary,
                  ),
                ),
              ),
            ),
          );

        });


  }


}