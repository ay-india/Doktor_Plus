import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doktor_plus/src/constant/constant.dart';
import 'package:doktor_plus/src/screen/ai_bot/src/screens/homepage.dart';
import 'package:doktor_plus/src/screen/doctors_list/doctors.dart';
import 'package:doktor_plus/src/screen/home/components/appBar.dart';
import 'package:doktor_plus/src/screen/home/components/components.dart';
import 'package:doktor_plus/src/screen/home/components/drawer.dart';
import 'package:doktor_plus/src/screen/home/components/specializedDoctor.dart';
import 'package:doktor_plus/src/screen/home/components/symptoms.dart';
import 'package:doktor_plus/utils/customWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  final String number;
  const HomePage({super.key, required this.number});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // String number = "+911111111111";
  String? name;
  @override
  void initState() {
    _getUserName(widget.number);

    // _getName();
    // TODO: implement initState
    super.initState();
  }

  var UserData;

  @override
  Widget build(BuildContext context) {
    return UserData == null
        ? Scaffold(
            body: Container(
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
              child: CircularProgressIndicator(color: primary),
            ),
          )
        : Scaffold(
            //appbar and drawer
            floatingActionButton: Container(
              height: 65.h,
              width: 65.w,
              child: FloatingActionButton(
                child: Padding(
                  padding: EdgeInsets.all(6.sp),
                  child: Image.asset("asset/icon/chatbot.png"),
                ),
                // backgroundColor: Colors.transparent,
                backgroundColor: primary,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AIHomePage()));
                },
              ),
            ),
            appBar: appBar,
            drawer: Drawer(
                backgroundColor: Color.fromARGB(255, 225, 236, 246),
                child: drawerContent(
                    context,
                    widget.number,
                    UserData['name'] ?? "",
                    UserData['image'] ?? "https://tinyurl.com/55snkhwf")),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 14.w, right: 14, top: 10.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5.h,),
                        mediumTextBold(
                          "We are offering multiple consultation modes",
                          primary,
                        ),
                        mediumText(
                          "We promote the best doctors on visual and physical platforms",
                          grey,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            serviceMode(
                                "Appointment",
                                "asset/image/appointment.jpg",
                                context,
                                widget.number,
                                UserData['name'] ?? ""),
                            serviceMode(
                                "Consult Now",
                                "asset/image/consult.jpg",
                                context,
                                widget.number,
                                UserData['name'] ?? ""),
                          ],
                        ),

                        // one special doctor(recommendation)

                        SizedBox(
                          height: 12.h,
                        ),
                        mediumTextBold(
                          "Video consultation with doctors",
                          primary,
                        ),
                        mediumText(
                          "Consult in a clinic-like environment",
                          grey,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        recommedDoctorCard(),
                        SizedBox(
                          height: 14.h,
                        ),
                        customButton(
                            38,
                            double.infinity,
                            10,
                            white,
                            textColor,
                            "See All Video Doctor",
                            14,
                            FontWeight.w600,
                            0,
                            1, () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Doctors(
                                number: widget.number,
                                name: UserData['name'] ?? "",
                              ),
                            ),
                          );
                        }),
                        SizedBox(
                          height: 14.h,
                        ),

                        // specialized doctors part
                        mediumTextBold(
                          "Our Specialized doctors are below",
                          primary,
                        ),
                        mediumText(
                          "Choose accurate doctors as per the specialization.",
                          grey,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        specialiazedDoctor(
                            context, widget.number, UserData['name'] ?? ""),
                        SizedBox(height: 14.h),
                        customButton(38, double.infinity, 10, white, textColor,
                            "View All Category", 14, FontWeight.w600, 0, 1, () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Doctors(
                                number: widget.number,
                                name: UserData['name'] ?? "",
                              ),
                            ),
                          );
                        }),
                        SizedBox(
                          height: 15.h,
                        ),

                        //Not feeling well?
                        mediumTextBold(
                          "Not feeling Well",
                          primary,
                        ),
                        mediumText(
                          "Choose between video and in-clinic consultation",
                          grey,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        symptomsHeading("Fever"),
                        SizedBox(
                          height: 10.h,
                        ),

                        feverSymptoms(
                            context, widget.number, UserData['name'] ?? ""),

                        // Runny nose
                        SizedBox(
                          height: 10.h,
                        ),
                        symptomsHeading("Runny Nose"),
                        SizedBox(
                          height: 10.h,
                        ),
                        runnyNoseSymptoms(
                            context, widget.number, UserData['name'] ?? ""),

                        SizedBox(
                          height: 15.h,
                        ),
                        customButton(38, double.infinity, 10, white, textColor,
                            "View All Symptoms", 14, FontWeight.w600, 0, 1, () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Doctors(
                                number: widget.number,
                                name: UserData['name'] ?? "",
                              ),
                            ),
                          );
                        }),

                        //**********************
                        //
                        SizedBox(
                          height: 10.h,
                        ),
                        mediumTextBold(
                          "Consult Doctor ove video",
                          primary,
                        ),
                        mediumText(
                          "Book doctor as per specialization.",
                          grey,
                        ),

                        SizedBox(
                          height: 8.h,
                        ),
                        consultDoctorOverVideo(
                            context, widget.number, UserData['name'] ?? ""),
                        SizedBox(
                          height: 10.h,
                        ),
                        customButton(
                            38,
                            double.infinity,
                            10,
                            white,
                            textColor,
                            "View All Specialist",
                            14,
                            FontWeight.w600,
                            0,
                            1, () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Doctors(
                                number: widget.number,
                                name: UserData['name'] ?? "",
                              ),
                            ),
                          );
                        }),
                        SizedBox(
                          height: 14.h,
                        ),
                        mediumTextBold(
                          "Premium video consultant",
                          primary,
                        ),
                        mediumText(
                          "Top Video consult only for you",
                          grey,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        recommedDoctorCard(),
                        SizedBox(
                          height: 14.h,
                        ),
                        customButton(
                            38,
                            double.infinity,
                            10,
                            white,
                            textColor,
                            "See All Premium Doctor",
                            14,
                            FontWeight.w600,
                            0,
                            1, () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Doctors(
                                number: widget.number,
                                name: UserData['name'] ?? "",
                              ),
                            ),
                          );
                        }),
                        SizedBox(
                          height: 14.h,
                        ),

                        SizedBox(
                          height: 14.h,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  endPart,
                ],
              ),
            ),
          );
  }

  Future<void> _getUserName(String no) async {
    await FirebaseFirestore.instance
        .collection('userDetail')
        .where('phonenumber', isEqualTo: no)
        .limit(1)
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              setState(() {
                print("-------------${document.data()}");
                UserData = document.data();
              });

              //docIDs.add(document.reference.id);
            }));
  }
}
