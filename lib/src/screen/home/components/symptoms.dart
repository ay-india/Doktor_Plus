import 'package:doktor_plus/src/screen/home/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../doctors_list/doctors.dart';

Widget feverSymptoms (BuildContext context, String name,String number) => Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            symptomsCard(
              "body_temperature.png",
              "Body Temperature",
               (){
                Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Doctors(
                                number: number,
                                name: name ,
                              ),
                            ),
                          );
              }
            ),
            symptomsCard("vomit.png", "Vomiting", (){
                Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Doctors(
                                number: number,
                                name: name ,
                              ),
                            ),
                          );
              })
          ],
        ),
        SizedBox(
          height: 6.8.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            symptomsCard(
              "body_pain.png",
              "Body Pain",
               (){
                Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Doctors(
                                number: number,
                                name: name ,
                              ),
                            ),
                          );
              }
            ),
            symptomsCard(
              "headache.png",
              "Headache",
               (){
                Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Doctors(
                                number: number,
                                name: name ,
                              ),
                            ),
                          );
              }
            ),
          ],
        ),
      ],
    );
Widget  runnyNoseSymptoms(BuildContext context, String name,String number) => Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            symptomsCard(
              "nose.png",
              "Block Nose",
              (){
                Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Doctors(
                                number: number,
                                name: name ,
                              ),
                            ),
                          );
              }
            ),
            symptomsCard(
              "stuffness.png",
              "Persistent stuffiness",
               (){
                Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Doctors(
                                number: number,
                                name: name ,
                              ),
                            ),
                          );
              }
            ),
          ],
        ),
        SizedBox(
          height: 6.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            symptomsCard(
              "drip.png",
              "Postnasal drip",
               (){
                Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Doctors(
                                number: number,
                                name: name ,
                              ),
                            ),
                          );
              }
            ),
            symptomsCard(
              "sense.png",
              "Loss in sense or smell",
               (){
                Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Doctors(
                                number: number,
                                name: name ,
                              ),
                            ),
                          );
              }
            ),
          ],
        ),
        SizedBox(
          height: 6.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            symptomsCard(
              "facial_pain.png",
              "Facial pain",
               (){
                Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Doctors(
                                number: number,
                                name: name ,
                              ),
                            ),
                          );
              }
            ),
            symptomsCard(
              "snoring.png",
              "Snoring",
               (){
                Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Doctors(
                                number: number,
                                name: name ,
                              ),
                            ),
                          );
              }
            ),
          ],
        ),
        SizedBox(
          height: 6.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            symptomsCard(
              "nausea.png",
              "Nausea",
               (){
                Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Doctors(
                                number: number,
                                name: name ,
                              ),
                            ),
                          );
              }
            ),
            symptomsCard(
              "headache.png",
              "Headache",
               (){
                Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Doctors(
                                number: number,
                                name: name ,
                              ),
                            ),
                          );
              }
            ),
          ],
        ),
      ],
    );
