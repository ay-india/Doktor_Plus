import 'package:doktor_plus/src/screen/home/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../doctors_list/doctors.dart';

Widget specialiazedDoctor(BuildContext context, String name,String number)  => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            doctorCard("Gynecologist", "asset/image/gynecologist.jpeg", (){
                Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Doctors(
                                number: number,
                                name: name ,
                              ),
                            ),
                          );
              }),
            doctorCard(
                "Gastroenterologist", "asset/image/gastroenterologist.jpeg", (){
                Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Doctors(
                                number: number,
                                name: name ,
                              ),
                            ),
                          );
              }),
            doctorCard("Dermatologist", "asset/image/dermatologist.jpg", (){
                Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Doctors(
                                number: number,
                                name: name ,
                              ),
                            ),
                          );
              }),
          ],
        ),
        SizedBox(
          height: 18.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            doctorCard("Cardiology", "asset/image/cardiology.png", (){
                Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Doctors(
                                number: number,
                                name: name ,
                              ),
                            ),
                          );
              }),
            doctorCard("Nephrologist", "asset/image/nephrologist.jpeg", (){
                Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Doctors(
                                number: number,
                                name: name ,
                              ),
                            ),
                          );
              }),
            doctorCard("Psychiatrist", "asset/image/psychiatrist.jpg", (){
                Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Doctors(
                                number: number,
                                name: name ,
                              ),
                            ),
                          );
              }),
          ],
        ),
        SizedBox(
          height: 18.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            doctorCard("Anesthesia", "asset/image/anesthesia.jpg", (){
                Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Doctors(
                                number: number,
                                name: name ,
                              ),
                            ),
                          );
              }),
            doctorCard("ENT Specialist", "asset/image/ent.jpg", (){
                Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Doctors(
                                number: number,
                                name: name ,
                              ),
                            ),
                          );
              }),
            doctorCard("Homoeopath", "asset/image/homoeopath.jpg", (){
                Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Doctors(
                                number: number,
                                name: name ,
                              ),
                            ),
                          );
              }),
          ],
        )
      ],
    );

Widget consultDoctorOverVideo (BuildContext context, String name,String number) => Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            consultDoctor(
              "orthopedic.jpg",
              "Orthopedic",
              "If experiencing discomfort in bones and joints",
              599.00,
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
            consultDoctor(
              "psychiatrist1.jpg",
              "Psychiatrist",
              "It's keky to your happy life. Meet our experts for help",
              799.00,
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
          height: 7.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            consultDoctor(
              "diabetologist.jpeg",
              "Diabetologist",
              "Defeat the silent, killer, get best advice",
              499.00,
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
            consultDoctor(
              "sexo1.jpg",
              "Sexologist",
              "Discuss your sex-related issues",
              399.00,
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
        )
      ],
    );
