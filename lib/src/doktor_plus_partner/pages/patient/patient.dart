import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:doktor_plus/src/constant/constant.dart';
import 'package:doktor_plus/src/doktor_plus_partner/doctor_home/doctor_home.dart';
import 'package:doktor_plus/src/doktor_plus_partner/pages/doctor_info/component.dart';
import 'package:doktor_plus/src/doktor_plus_partner/pages/patient/service.dart';
import 'package:doktor_plus/src/doktor_plus_partner/video_call/call.dart';
import 'package:doktor_plus/src/screen/home/components/components.dart';
import 'package:doktor_plus/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PatientPage extends StatefulWidget {
  final appointmentId, doctorNumber, patientNumber,doctorName;
  const PatientPage(
      {super.key,
      required this.appointmentId,
      required this.doctorName,
      required this.doctorNumber,
      required this.patientNumber});

  @override
  State<PatientPage> createState() => _PatientPageState();
}

class _PatientPageState extends State<PatientPage> {
  final diagnosisEditingController = new TextEditingController();
  final medicineEditingController = new TextEditingController();
  final usageEditingController = new TextEditingController();
  List? appointmentList;
  List? patientList;
  List<Map<String, String>> medicine = [{}, {}, {}, {}, {}, {}, {}, {}, {}, {}];
  int age = 25;
  int i = 0;
  @override
  void initState() {
    fetchDatabaseList();
    fetchUserList();
    // medicine = [];
    super.initState();
  }

  fetchDatabaseList() async {
    dynamic resultant =
        await PatientDatabaseManager().getAppointmentList(widget.appointmentId);
    if (resultant == null) {
      print("Unable to retrieve");
    } else {
      setState(() {
        appointmentList = resultant;
      });
    }
  }

  fetchUserList() async {
    dynamic resultant =
        await PatientDatabaseManager().getPatientList(widget.patientNumber);
    if (resultant == null) {
      print("Unable to retrieve");
    } else {
      setState(() {
        patientList = resultant;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primary,
          centerTitle: true,
          title: customText(
            "Patient",
            white,
            16,
            FontWeight.w600,
          ),
        ),
        body: CustomScrollView(slivers: [
          SliverFillRemaining(
              hasScrollBody: false,
              child: patientList == null || appointmentList == null
                  ? Container(
                      height: 500.h,
                      width: double.infinity.w,
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(color: primary),
                    )
                  : Container(
                      height: double.infinity,
                      width: double.infinity,
                      color: primary,
                      child: Column(children: [
                        Container(
                          height: 100.h,
                          width: double.infinity,
                          padding: EdgeInsets.all(18.sp),
                          child: Row(
                            children: [
                              Container(
                                height: 80.h,
                                width: 80.h,
                                decoration: BoxDecoration(
                                  boxShadow: [BoxShadow(blurRadius: 2.r)],
                                  borderRadius: BorderRadius.circular(100),
                                  color:
                                      const Color.fromARGB(255, 225, 222, 222),
                                  image: const DecorationImage(
                                    image: AssetImage("asset/icon/patient.png"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 25.w,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Spacer(),
                                  customText(
                                    patientList![0]['name'],
                                    white,
                                    18,
                                    FontWeight.w800,
                                  ),
                                  Spacer(),
                                  customText(
                                    "Sex: ${patientList![0]['gender']}",
                                    white,
                                    14,
                                    FontWeight.w500,
                                  ),
                                  Spacer(),
                                  customText(
                                    "Age: $age Years",
                                    white,
                                    14,
                                    FontWeight.w500,
                                  ),
                                  Spacer(),
                                  customText(
                                    "Allergy: ${patientList![0]['allergy']} ",
                                    white,
                                    14,
                                    FontWeight.w500,
                                  ),
                                  Spacer(),
                                ],
                              ),
                              Spacer(),
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      PatientDatabaseManager().liveUpdate(
                                          widget.appointmentId, true);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => CallPage(
                                                  callID: widget.appointmentId,
                                                  userName: widget.doctorName,
                                                  userId:
                                                      widget.doctorNumber)));
                                    },
                                    child: Container(
                                      height: 45.h,
                                      width: 45.w,
                                      padding: EdgeInsets.all(12.h),
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: white,
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'asset/icon/connect.png'))),
                                    ),
                                  ),
                                  Spacer(),
                                  customButton(
                                      17,
                                      49,
                                      13,
                                      Colors.red[300]!,
                                      white,
                                      "Connect",
                                      9,
                                      FontWeight.w600,
                                      0,
                                      0,
                                      () {
                                         PatientDatabaseManager().liveUpdate(
                                          widget.appointmentId, true);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => CallPage(
                                                  callID: widget.appointmentId,
                                                  userName: widget.doctorName,
                                                  userId:
                                                      widget.doctorNumber)));
                                      })
                                ],
                              )
                            ],
                          ),
                        ),

                        /// complian section
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 14.sp, vertical: 6.h),
                          padding: EdgeInsets.all(14.sp),
                          height: 90.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(
                              12.r,
                            ),
                          ),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                customText(
                                  "Complain",
                                  primary,
                                  16,
                                  FontWeight.w600,
                                ),
                                const Spacer(),
                                Text(
                                  appointmentList![0]['symptoms'],
                                  style: TextStyle(
                                    color: Colors.red[400],
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w800,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Spacer(),
                              ]),
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        // Container for Daignosis

                        Expanded(
                            child: Container(
                          height: double.infinity,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(
                                18.r,
                              ),
                              topRight: Radius.circular(18.r),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16.sp),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  customText("Diagnosis", primary, 18,
                                      FontWeight.w700),
                                  SizedBox(
                                    height: 14.h,
                                  ),
                                  customTextForm(diagnosisEditingController,
                                      "Diagnosis", "Diagnosis"),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  customText(
                                      "Medicine", primary, 18, FontWeight.w700),
                                  customText("Patient create doctor as God",
                                      grey, 12, FontWeight.w400),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  customTextForm(medicineEditingController,
                                      "Medicine Name", "Medicine Name"),
                                  SizedBox(
                                    height: 11.h,
                                  ),
                                  customTextForm(
                                      usageEditingController,
                                      "Instruction to take medicine",
                                      "Instruction"),
                                  SizedBox(
                                    height: 12.h,
                                  ),
                                  Align(
                                      alignment: Alignment.topRight,
                                      child: customButton(
                                          32,
                                          100,
                                          12,
                                          medicineEditingController
                                                      .text.isNotEmpty &&
                                                  usageEditingController
                                                      .text.isNotEmpty
                                              ? primary
                                              : white,
                                          medicineEditingController
                                                      .text.isNotEmpty &&
                                                  usageEditingController
                                                      .text.isNotEmpty
                                              ? white
                                              : primary,
                                          "Add ",
                                          12,
                                          FontWeight.w600,
                                          0,
                                          1,
                                          medicineEditingController
                                                      .text.isNotEmpty &&
                                                  usageEditingController
                                                      .text.isNotEmpty
                                              ? () {
                                                  medicine[i] = {
                                                    'medicine':
                                                        medicineEditingController
                                                            .text,
                                                    'usage':
                                                        usageEditingController
                                                            .text
                                                  };
                                                  showToast("Added");
                                                  print(medicine);
                                                  print(i);
                                                  setState(() {
                                                    i = i + 1;
                                                    medicineEditingController
                                                        .text = "";
                                                    usageEditingController
                                                        .text = "";
                                                  });
                                                }
                                              : () {})),
                                  SizedBox(
                                    height: 18.h,
                                  ),
                                  Spacer(),
                                  diagnosisEditingController.text.isNotEmpty &&
                                          medicine[0].isNotEmpty
                                      ? Align(
                                          alignment: Alignment.center,
                                          child: customButton(
                                              40,
                                              300,
                                              12,
                                              primary,
                                              white,
                                              "Save",
                                              13,
                                              FontWeight.w700,
                                              0,
                                              0,
                                              diagnosisEditingController
                                                          .text.isNotEmpty &&
                                                      medicine[0].isNotEmpty
                                                  ? () {
                                                      print(medicine);
                                                      List<Map<String, String>>
                                                          med = [];
                                                      for (int j = 0;
                                                          j < medicine.length;
                                                          j++) {
                                                        if (medicine[j]
                                                            .isNotEmpty) {
                                                          med.add(medicine[j]);
                                                        }
                                                      }
                                                      print(med);

                                                      PatientDatabaseManager()
                                                          .createNewAppointment(
                                                              widget
                                                                  .appointmentId,
                                                              diagnosisEditingController
                                                                  .text,
                                                              med);
                                                      var snackBar = SnackBar(
                                                        /// need to set following properties for best effect of awesome_snackbar_content
                                                        elevation: 0,
                                                        behavior:
                                                            SnackBarBehavior
                                                                .floating,
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        content:
                                                            AwesomeSnackbarContent(
                                                          title: 'Successful',
                                                          message:
                                                              'Patient has been checked-up successfully!',

                                                          /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                                          contentType:
                                                              ContentType
                                                                  .success,
                                                        ),
                                                      );
                                                      ScaffoldMessenger.of(
                                                          context)
                                                        ..hideCurrentSnackBar()
                                                        ..showSnackBar(
                                                            snackBar);
                                                      Future.delayed(
                                                        Duration(seconds: 1),
                                                        () {
                                                          Navigator.pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      DoctorHome(
                                                                          number:
                                                                              widget.doctorNumber)));
                                                        },
                                                      );
                                                    }
                                                  : () {}))
                                      : Container(),
                                  SizedBox(
                                    height: 18.h,
                                  ),
                                ]),
                          ),
                        ))
                      ]),
                    ))
        ]));
  }
}
