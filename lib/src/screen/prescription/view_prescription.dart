import 'package:doktor_plus/src/screen/prescription/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constant/constant.dart';
import '../home/components/components.dart';

class ViewPrescriptionPage extends StatefulWidget {
  final String id, number,title;
  const ViewPrescriptionPage({
    super.key,
    required this.id,
    required this.number,
    required this.title,
  });

  @override
  State<ViewPrescriptionPage> createState() => _ViewPrescriptionPageState();
}

class _ViewPrescriptionPageState extends State<ViewPrescriptionPage> {
  List? prescriptionList;
  @override
  void initState() {
    fetchDatabaseList();
    super.initState();
  }

  fetchDatabaseList() async {
    dynamic resultant =
        await UserDatabaseManager().getPrescriptionList(widget.id);
    if (resultant == null) {
      print("Unable to retrieve");
    } else {
      setState(() {
        prescriptionList = resultant;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 211, 220, 244),
        appBar: AppBar(
          iconTheme: IconThemeData(
    color: Colors.black, //change your color here
  ),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 211, 220, 244),
          title: customText(
           widget.title,
            Colors.red[700]!,
            20,
            FontWeight.w600,
          ),
        ),
        body: prescriptionList == null
            ? Container(
                height: 500.h,
                width: double.infinity,
                alignment: Alignment.center,
                child: const CircularProgressIndicator(color: primary),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.all(14.sp),
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
                            "Diagnosis",
                            grey,
                            16,
                            FontWeight.w600,
                          ),
                          Spacer(),
                          Text(
                            prescriptionList![0]['diagnosis'],
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
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 12.w),
                    padding: EdgeInsets.all(12.sp),
                    width: double.infinity,
                    height: 69.h,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 252, 223, 209),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                          12.r,
                        ),
                        topRight: Radius.circular(12.r),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 40.h,
                          width: 40.w,
                          child: Image.asset("asset/icon/drug.png"),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Medicine for your ${prescriptionList![0]["symptoms"]}",
                              style: TextStyle(
                                color: Color.fromARGB(255, 94, 58, 55),
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w700,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Spacer(),
                            customText(
                              "Start your medicine today for effective \nrecovery",
                              Colors.grey[800]!,
                              13,
                              FontWeight.w400,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: prescriptionList![0]['medicine'].length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 14.sp, vertical: 5.h),
                          padding: EdgeInsets.all(12.sp),
                          height: 80.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(
                              12.r,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                height: 40.h,
                                width: 40,
                                child: Image.asset("asset/icon/medicine.png"),
                              ),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    customText(
                                      prescriptionList![0]['medicine'][index]['medicine'],
                                      textColor,
                                      18,
                                      FontWeight.w800,
                                    ),
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                    SizedBox(
                                      width: 200.w,
                                      child: Text(
                                        prescriptionList![0]['medicine'][index]['usage'],
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 61, 40, 38),
                                          fontSize: 11.4.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ),
                                  ]),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
              ));
  }
}
