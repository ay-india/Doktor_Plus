import 'package:doktor_plus/src/constant/constant.dart';
import 'package:doktor_plus/src/screen/home/components/components.dart';
import 'package:doktor_plus/src/screen/home/home.dart';
import 'package:doktor_plus/src/screen/pages/appointment/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../doctors_list/component/service.dart';
import 'components/service.dart';

class MyAppointment extends StatefulWidget {
  final String number;
  const MyAppointment({super.key, required this.number});

  @override
  State<MyAppointment> createState() => _MyAppointmentState();
}

class _MyAppointmentState extends State<MyAppointment> {
  List? appointmentList;
  @override
  void initState() {
    // TODO: implement initState
    fetchDatabaseList();
    super.initState();
  }

  fetchDatabaseList() async {
    dynamic resultant =
        await AppointmentDatabaseManager().getAppointmentList(widget.number);
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
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => HomePage(
                    number: widget.number,
                  )),
          (route) => false,
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: primary,
          title: customText(
            "My Consultations",
            white,
            15,
            FontWeight.w600,
          ),
        ),
        body: appointmentList == null
            ? Container(
                height: 500.h,
                width: double.infinity,
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
                        appointmentList![index]['completed'],
                        appointmentList![index]['isOnline'],context),
                  );
                },
              ),
      ),
    );
  }
}
