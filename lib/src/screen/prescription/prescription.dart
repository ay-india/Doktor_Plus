import 'package:doktor_plus/src/screen/pages/user_info/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constant/constant.dart';
import '../home/components/components.dart';
import '../pages/appointment/components/components.dart';
import '../pages/appointment/components/service.dart';

class MyPrescription extends StatefulWidget {
  final String number;
  const MyPrescription({super.key,required this.number});

  @override
  State<MyPrescription> createState() => _MyPrescriptionState();
}

class _MyPrescriptionState extends State<MyPrescription> {
  List? appointmentList;
  @override
  void initState() {
    // TODO: implement initState
    fetchDatabaseList();
    super.initState();
  }

  fetchDatabaseList() async {
    dynamic resultant =
        await AppointmentDatabaseManager().getClosedAppointmentList(widget.number);
    if (resultant == null) {
      print("Unable to retrieve");
    } else {
      setState(() {
        appointmentList = resultant;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: primary,
          title: customText(
            "My Prescription",
            white,
            15,
            FontWeight.w600,
          ),
        ),
        body: appointmentList == null
            ? Container(
                height: 500.h,
                width: 300.w,
                alignment: Alignment.center,
                child: const CircularProgressIndicator(color: primary),
              )
            : ListView.builder(
                itemCount: appointmentList!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 6.h, horizontal: 3.w),
                    child: appointmentCard(
                       appointmentList![index]['id'],
                       appointmentList![index]['patient_name'],
                        appointmentList![index]['patient'],
                        appointmentList![index]['symptoms'],
                        appointmentList![index]['date'],
                        appointmentList![index]['time'],
                        appointmentList![index]['doctor_name'],
                        appointmentList![index]['specialized'],
                        appointmentList![index]['doctor_image'],
                        appointmentList![index]['completed'],appointmentList![index]['isOnline'],context),
                  );
                },
              ),
      );
  }
}