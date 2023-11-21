import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doktor_plus/src/constant/constant.dart';
import 'package:doktor_plus/src/doktor_plus_partner/doctor_home/doctor_home.dart';
import 'package:doktor_plus/src/doktor_plus_partner/pages/doctor_info/doctor_info.dart';
import 'package:doktor_plus/src/screen/home/components/components.dart';
import 'package:doktor_plus/src/screen/home/home.dart';
import 'package:doktor_plus/src/screen/pages/login/login.dart';
import 'package:doktor_plus/src/screen/pages/user_info/userInfo.dart';
import 'package:doktor_plus/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../utils/customWidget.dart';

class OTPPage extends StatefulWidget {
  final String mobile;
  const OTPPage({super.key, required this.mobile});

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  //logical stuff
  int resendOn = 0;

  int? _resendToken;

  late bool isRegistered;
  final otpEditingController = new TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  String? user;
  @override
  void initState() {
    // _getUserName(widget.number);
    startTimer();
    _getUser();
    super.initState();
    // _checkIfRegistered();
  }

  _getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    user = prefs.getString("user");
  }

  var code = "";
  int start = 59;
  bool wait = false;
  void startTimer() {
    const onsec = Duration(seconds: 1);
    Timer _timer = Timer.periodic(onsec, (timer) {
      if (start == 0) {
        setState(() {
          timer.cancel();
          resendOn = 1;
          wait = false;
        });
      } else {
        setState(() {
          start--;
        });
      }
    });
  }

  //*************************************************** */
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: textColor,
        ),
        elevation: 0,
        // shadowColor: white,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: customText(
          "Verification",
          textColor,
          14,
          FontWeight.w500,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12.sp),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'asset/icon/otp.png',
                height: 100.h,
              ),
              SizedBox(
                height: 28.h,
              ),
              customText(
                "OTP Verification",
                textColor,
                26,
                FontWeight.w800,
              ),
              SizedBox(
                height: 10.h,
              ),
              customText(
                "Enter the 6-digit number that we send ",
                grey,
                15,
                FontWeight.w400,
              ),
              SizedBox(
                height: 4.h,
              ),
              customText(
                "to ${widget.mobile}",
                grey,
                15,
                FontWeight.w400,
              ),
              SizedBox(
                height: 42.h,
              ),
              Container(
                padding: EdgeInsets.all(15.sp),
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(
                      12.r,
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromARGB(255, 89, 89, 89),
                          blurRadius: 3.sp,
                          spreadRadius: 2.sp,
                          blurStyle: BlurStyle.outer),
                    ]),
                child: Column(
                  children: [
                    OtpTextField(
                      numberOfFields: 6,
                      textStyle: TextStyle(color: textColor),
                      borderColor: Color(0xFF512DA8),
                      //set to true to show as box or false to show as dash
                      showFieldAsBox: true,
                      //runs when a code is typed in
                      onCodeChanged: (String otp) {
                        //handle validation or checks here
                      },
                      //runs when every textfield is filled
                      onSubmit: (String verificationCode) {
                        code = verificationCode;
                      }, // end onSubmit
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Didn’t get the code?',
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                        InkWell(
                          onTap: resendOn == 1
                              ? () async {
                                  setState(() {
                                    start = 59;
                                    resendOn = 0;
                                  });
                                  CustomWidget().showProgress(context: context);

                                  await FirebaseAuth.instance.verifyPhoneNumber(
                                    timeout: const Duration(seconds: 60),
                                    phoneNumber: widget.mobile,
                                    verificationCompleted: (PhoneAuthCredential
                                        phoneAuthCredential) async {
                                      Navigator.pop(context);
                                      print('inside verification');
                                    },
                                    verificationFailed:
                                        (FirebaseAuthException e) {
                                      Navigator.pop(context);
                                      print('inside verification failed');
                                    },
                                    codeSent: (String verificationId,
                                        int? resendToken) {
                                      Navigator.pop(context);
                                      showToast("Code Sent Successfully");
                                      startTimer();
                                      LoginPage.verify = verificationId;
                                      _resendToken = resendToken;
                                      print(
                                          'login verification====${LoginPage.verify}');
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             otp(number: number)));
                                    },
                                    forceResendingToken: _resendToken,
                                    codeAutoRetrievalTimeout:
                                        (String verificationId) {
                                      print(verificationId);
                                    },
                                  );
                                }
                              : () {},
                          child: Text(
                            ' Resend',
                            style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w800,
                                color: resendOn == 1 ? primary : Colors.grey),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.sp,
                    ),
                    start >= 10
                        ? Text(
                            'Expires in 00:$start',
                            style: TextStyle(color: primary),
                          )
                        : Text('Expires in 00:0$start',
                            style: TextStyle(color: primary)),
                    SizedBox(
                      height: 15.h,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.sp),
                      child: customButton(45, double.infinity, 12, primary,
                          white, "Verify", 15, FontWeight.w600, 0, 0, () async {
                        try {
                          CustomWidget().showProgress(context: context);
                          print(
                              'login verification at otp====${LoginPage.verify}');
                          print('Code-----$code');

                          PhoneAuthCredential credential =
                              PhoneAuthProvider.credential(
                                  verificationId: LoginPage.verify,
                                  smsCode: code);
                          //
                          // Sign the user in (or link) with the credential
                          await auth
                              .signInWithCredential(credential)
                              .whenComplete(() =>
                                  CustomWidget().hidProgress(context: context));
                          showToast("Login Successfully");

// logic for taking user detail input or directly navigation to home page
                          user == "patient"
                              ? {
                                  await doesPatientAlreadyExist(widget.mobile)
                                      ? {
                                          setLoginTrue(),
                                          setPhoneNumber(widget.mobile),
                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          HomePage(
                                                            number:
                                                                widget.mobile,
                                                          )),
                                                  (Route<dynamic> route) =>
                                                      false)
                                          // Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //         builder: (context) =>
                                          //             HomePage(
                                          //               number: widget.mobile,
                                          //             )))
                                        }
                                      // ignore: use_build_context_synchronously
                                      : {
                                          // setLoginTrue(),
                                          setPhoneNumber(widget.mobile),
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      UserDetailForm(
                                                          number:
                                                              widget.mobile)))
                                        }
                                }
                              : {
                                  await doesDoctorAlreadyExist(widget.mobile)
                                      ? {
                                          setLoginTrue(),
                                          setPhoneNumber(widget.mobile),
                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DoctorHome(
                                                              number: widget
                                                                  .mobile)),
                                                  (Route<dynamic> route) =>
                                                      false)
                                          // Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //         builder: (context) =>
                                          //             DoctorHome(
                                          //               number: widget.mobile,
                                          //             )))
                                        }
                                      // ignore: use_build_context_synchronously
                                      : {
                                          // setLoginTrue(),
                                          setPhoneNumber(widget.mobile),
                                          // ignore: use_build_context_synchronously
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DoctorFormPage(
                                                          number:
                                                              widget.mobile)))
                                        }
                                };
//************************************************************************** */
                        } catch (e) {
                          print(e);
                          //print('Wrong Otp');
                          displayWarningDialog(
                              context, "Wrong OTP", "Please enter correct OTP");
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      "Wrong OTP Please enter correct OTP")));
                        }
                      }),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}

Future<bool> doesPatientAlreadyExist(String name) async {
  print(name);
  final QuerySnapshot result = await FirebaseFirestore.instance
      .collection('userDetail')
      .where('phonenumber', isEqualTo: name)
      .limit(1)
      .get();
  final List<DocumentSnapshot> documents = result.docs;
  //print(result.docs);
  return documents.length == 1;
}

Future<bool> doesDoctorAlreadyExist(String name) async {
  print(name);
  final QuerySnapshot result = await FirebaseFirestore.instance
      .collection('doctors')
      .where('mobile', isEqualTo: name)
      .limit(1)
      .get();
  final List<DocumentSnapshot> documents = result.docs;
  //print(result.docs);
  return documents.length == 1;
}

setLoginTrue() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool("isLogin", true);
}

setPhoneNumber(String mobile) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString("phone", mobile);
}
