import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doktor_plus/src/constant/constant.dart';
import 'package:doktor_plus/src/screen/booking/components/component.dart';
import 'package:doktor_plus/src/screen/booking/components/datetime.dart';
import 'package:doktor_plus/src/screen/home/components/components.dart';
import 'package:doktor_plus/src/screen/pages/appointment/appointment.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../utils/customWidget.dart';

class Booking extends StatefulWidget {
  final String patientName,name,
      doctorContact,
      language,
      exp,
      specialization,
      image,
      amount,
      number,
      about;
  final int totalConsult;
  const Booking({
    super.key,
    required this.patientName,
    required this.doctorContact,
    required this.name,
    required this.language,
    required this.specialization,
    required this.exp,
    required this.amount,
    required this.image,
    required this.number,
    required this.about,
    required this.totalConsult,
  });

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  final _auth = FirebaseAuth.instance;
  FirebaseStorage _storage = FirebaseStorage.instance;
  final symptomsEditingController = new TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  int isTapped = 0;
  int isDateSelected = 0;
  int isTimeSelectd = 0;
  @override
  Widget build(BuildContext context) {
    String formattedTime = _selectedTime != null
        ? DateFormat('h:mm a').format(DateTime(
            _selectedDate!.year,
            _selectedDate!.month,
            _selectedDate!.day,
            _selectedTime!.hour,
            _selectedTime!.minute,
          ))
        : '';

    String formattedDate = _selectedDate != null
        ? DateFormat('dd-MM-yyyy').format(_selectedDate!)
        : '';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: customText("Dr. ${widget.name}", white, 16, FontWeight.w500),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.all(
                12.sp,
              ),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  doctorDetailPagePart(widget.name, widget.language, widget.exp,
                      widget.specialization, widget.image, widget.about,widget.totalConsult),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (isDateSelected == 1)
                        customText("Selected Date: $formattedDate", textColor,
                            15, FontWeight.w600),
                      SizedBox(
                        width: 12.w,
                      ),
                      customButton(
                        30,
                        110,
                        10,
                        primary,
                        white,
                        "Select Date",
                        14,
                        FontWeight.w400,
                        1,
                        0,
                        () {
                          _selectDate(context);
                          isDateSelected = 1;
                          if (isDateSelected == 1 && isTimeSelectd == 1)
                            isTapped = 1;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (isTimeSelectd == 1)
                        customText("Selected Time: $formattedTime", textColor,
                            15, FontWeight.w600),
                      SizedBox(
                        width: 12.w,
                      ),
                      customButton(
                        30,
                        110,
                        10,
                        primary,
                        white,
                        "Select Date",
                        14,
                        FontWeight.w400,
                        1,
                        0,
                        () {
                          _selectTime(context);
                          isTimeSelectd = 1;
                          if (isDateSelected == 1 && isTimeSelectd == 1)
                            isTapped = 1;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: TextFormField(
                style: TextStyle(color: textColor),
                autofocus: false,
                controller: symptomsEditingController,
                keyboardType: TextInputType.name,
                validator: (value) {
                  RegExp regex = new RegExp(r'^.{3,}$');
                  if (value!.isEmpty) {
                    return ("Symptoms cannot be Empty");
                  }
                  if (!regex.hasMatch(value)) {
                    return ("Enter Valid symptoms(Min. 3 Character)");
                  }
                  return null;
                },
                onSaved: (value) {
                  symptomsEditingController.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  // prefixIcon: Icon(Icons.account_circle),
                  contentPadding:
                      EdgeInsets.fromLTRB(20.sp, 15.sp, 20.sp, 15.sp),
                  hintText: "Symptoms",
                  hintStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14.sp),
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.sp),
              child: customButton(
                  44,
                  double.infinity,
                  12,
                  isTapped == 1 ? primary : white,
                  isTapped == 1 ? white : primary,
                  "Book Appointment",
                  15,
                  FontWeight.w600,
                  0,
                  1,
                  isTapped == 0
                      ? () {}
                      : () {
                          SnackBar snackBar;
                          symptomsEditingController.text.isNotEmpty &&
                                  formattedDate.isNotEmpty &&
                                  formattedTime.isNotEmpty
                              ? {
                                  snackBar = SnackBar(
                                    /// need to set following properties for best effect of awesome_snackbar_content
                                    elevation: 0,
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Colors.transparent,
                                    content: AwesomeSnackbarContent(
                                      title: 'Congratulations!',
                                      message:
                                          'You have booked your appointement successfully!. Be ready on Time.',

                                      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                      contentType: ContentType.success,
                                    ),
                                  ),
                                  ScaffoldMessenger.of(context)
                                    ..hideCurrentSnackBar()
                                    ..showSnackBar(snackBar),
                                  Future.delayed(
                                    Duration(seconds: 1),
                                    () {
                                      _bookAppointment(formattedTime.toString(),
                                          formattedDate.toString());
                                    },
                                  ),
                                }
                              : ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text('Please enter all details')));
                        }),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _bookAppointment(String time, String date) async {
    CustomWidget().showProgress(context: context);
    String iid = DateTime.now().millisecondsSinceEpoch.toString();
    FirebaseFirestore.instance.collection("appointments").doc(iid).set({
      "doctor": widget.doctorContact,
      "patient": widget.number,
      "patient_name":widget.patientName,
      "symptoms": symptomsEditingController.text,
      "completed": false,
      "isOnline":false,
      "time": time,
      "date": date,
      // "patient_name":widget.patientName,
      // "patient_image":widget.patientImage,
      "doctor_image": widget.image,
      "doctor_name": widget.name,
      "specialized": widget.specialization,
      "id": iid
    }).then((value) {
      CustomWidget().hidProgress(context: context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => MyAppointment(
            number: widget.number,
          ),
        ),
      );
    }).catchError((error) => print("Error adding data: $error"));
  }
}
