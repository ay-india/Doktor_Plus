import 'package:doktor_plus/src/constant/constant.dart';
import 'package:doktor_plus/src/screen/home/components/components.dart';
import 'package:doktor_plus/src/screen/pages/otp/otp.dart';
import 'package:doktor_plus/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/customWidget.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});
  static String verify = "";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final TextEditingController controller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState

    controller.text = "+91";
    super.initState();
  }

  String mobile = "";
  int? _resendToken;
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
          "Login",
          textColor,
          16,
          FontWeight.w500,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(
            12.sp,
          ),
          child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Spacer(),
                SizedBox(
                  height: 10.h,
                ),
                Image.asset("asset/icon/login.png"),
                // Spacer()
                // Container(height: 150.h,
                // width: double.infinity,
                // decoration: BoxDecoration(image: DecorationImage(image: AssetImage("asset/icon/login.png"))),)
                SizedBox(
                  height: 25.h,
                ),
                customText(
                  "User Login",
                  textColor,
                  24,
                  FontWeight.w500,
                ),
                SizedBox(
                  height: 25.h,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 25.h,
                    horizontal: 15.w,
                  ),
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
                      TextFormField(
                        controller: controller,
                        onChanged: (value) {
                          setState(() {
                            mobile = value;
                          });
                        },
                        keyboardType: TextInputType.phone,
                        style: TextStyle(color: textColor),
                        decoration: InputDecoration(
                          label: const Text('Mobile No.'),
                          hintText: 'Enter Mobile No.',
                          focusColor: textColor,
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2.w,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 2.w,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Padding(
                        padding: EdgeInsets.all(
                          10.sp,
                        ),
                        child: customButton(
                            45,
                            double.infinity,
                            10,
                            primary,
                            white,
                            "Send OTP",
                            15,
                            FontWeight.w500,
                            0,
                            0, () async {
                          CustomWidget().showProgress(context: context);
                          print(mobile);
                          await FirebaseAuth.instance.verifyPhoneNumber(
                            timeout: const Duration(seconds: 60),
                            phoneNumber: mobile,
                            verificationCompleted: (PhoneAuthCredential
                                phoneAuthCredential) async {
                              print('inside verification');

                              // adduser();
                              // await auth.signInWithCredential(credential);
                              // CustomWidget().hidProgress(context: context);
                            },
                            verificationFailed: (FirebaseAuthException e) {
                              print(e);
                              if (e.code == 'invalid-phone-number') {
                                print(
                                    'The provided phone number is not valid.');
                              }
                              print('inside verification failedf');
                              // CustomWidget().hidProgress(context: context);
                              Navigator.pop(context);
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => login()));
                            },
                            codeSent:
                                (String verificationId, int? resendToken) {
                              LoginPage.verify = verificationId;
                              _resendToken = resendToken;
                              print(
                                  'login verification====${LoginPage.verify}');
                              Navigator.pop(context);
                              showToast("OTP Sent");
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OTPPage(
                                    mobile: mobile,
                                  ),
                                ),
                              );
                            },
                            forceResendingToken: _resendToken,
                            codeAutoRetrievalTimeout: (String verificationId) {
                              print(verificationId);
                            },
                          );

                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (context) => otp()));
                        }
                            // () {
                            //   isMobileNumberValid(mobile)
                            //       ? Navigator.push(
                            //           context,
                            //           MaterialPageRoute(
                            //             builder: (context) =>
                            //                 OTPPage(mobile: mobile),
                            //           ),
                            //         )
                            //       : displayErrorDialog(
                            //           context,
                            //           "Invalid Mobile Number",
                            //           "Please re-enter the correct \nmobile number.");
                            // },
                            ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Center(
                        child: customText(
                          "By clicking proceed, you agree to our",
                          textColor,
                          14,
                          FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Center(
                        child: customText(
                          "Terms & Conditions",
                          primary,
                          13,
                          FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                )
              ]),
        ),
      ),
    ));
  }
}

bool isMobileNumberValid(String phoneNumber) {
  String regexPattern = r'^(?:[+0][1-9])?[0-9]{10,12}$';
  var regExp = new RegExp(regexPattern);

  if (phoneNumber.length == 0) {
    return false;
  } else if (regExp.hasMatch(phoneNumber)) {
    return true;
  }
  return false;
}
