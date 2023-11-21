import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doktor_plus/src/doktor_plus_partner/doctor_home/doctor_home.dart';
import 'package:doktor_plus/src/doktor_plus_partner/pages/doctor_info/component.dart';
import 'package:doktor_plus/src/screen/home/home.dart';
import 'package:doktor_plus/src/screen/pages/user_info/components/components.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_image/flutter_native_image.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../utils/customWidget.dart';
import '../../../constant/constant.dart';
import '../../../screen/home/components/components.dart';
import '../../../screen/pages/otp/otp.dart';

class DoctorFormPage extends StatefulWidget {
  String number;
  DoctorFormPage({super.key, required this.number});
  static String verify = "";

  @override
  State<DoctorFormPage> createState() => _onboardingState(phone: number);
}

class _onboardingState extends State<DoctorFormPage> {
  var phone = "+911111111111";
  _onboardingState({required this.phone});
  final List<String> genderItems = [
    'Male',
    'Female',
  ];

  String? selectedValue;
  String? imageUrl;
  final _formKey = GlobalKey<FormState>();

  TextEditingController countryCode = TextEditingController();
  void initState() {
    countryCode.text = widget.number;
    super.initState();
  }

  final _auth = FirebaseAuth.instance;
  FirebaseStorage _storage = FirebaseStorage.instance;

  final nameEditingController = new TextEditingController();

  final dateofBirthEditingController = new TextEditingController();
  final genderEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();

  final addressEditingController = new TextEditingController();
  final phoneNumberEditingController = new TextEditingController();
  final degreeEditingController = new TextEditingController();
  final specializedEditingController = new TextEditingController();
  final languageEditingController = new TextEditingController();
  final feeEditingController = new TextEditingController();
  final expEditingController = new TextEditingController();

  final aboutEditingController = new TextEditingController();

  // final _auth = FirebaseAuth.instance;
  File? photo = File('');
  int photochoosen = 0;
  late DateTime _selectedDate;
  String dob = "Date of Birth";

  @override
  Widget build(BuildContext context) {
    final emailFiled = TextFormField(
        style: TextStyle(color: textColor),
        autofocus: false,
        controller: emailEditingController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Email cannot be Empty");
          }
          return null;
        },
        onSaved: (value) {
          emailEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          // prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20.sp, 15.sp, 20.sp, 15.sp),
          hintText: "Email Address",
          hintStyle: const TextStyle(color: Colors.grey),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.sp),
            // borderSide: BorderSide.none,
          ),
        ));

    final genderField = DropdownButtonFormField2(
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.sp),
        ),
      ),
      isExpanded: true,
      hint: Text(
        'Select Your Gender',
        style: TextStyle(fontSize: 16.sp, color: Colors.grey),
      ),
      items: genderItems
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(
                    color: textColor,
                    fontSize: 14,
                  ),
                ),
              ))
          .toList(),
      validator: (value) {
        if (value == null) {
          return 'Please select gender.';
        }
        return null;
      },
      onChanged: (value) {
        genderEditingController.text = value.toString();
      },
      onSaved: (value) {
        genderEditingController.text = value.toString();
      },
      buttonStyleData: ButtonStyleData(
        height: 49.h,
        padding: EdgeInsets.only(left: 3.w, right: 10.w),
      ),
      iconStyleData: const IconStyleData(
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.black45,
        ),
        iconSize: 30,
      ),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
    final phoneNumberField = TextFormField(
        enableInteractiveSelection: false,
        enabled: false,
        autofocus: false,
        controller: countryCode,
        keyboardType: TextInputType.number,
        validator: (value) {
          RegExp regex = new RegExp(r'/^(?:[+0]9)?[0-9]{10}$/');
          if (value!.isEmpty) {
            return ("Phone Number cannot be Empty");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid Phone number ");
          }
          return null;
        },
        onChanged: (val) {
          setState(() {
            phone = val;
          });
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          // prefixIcon: Icon(Icons.phone),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Phone Number",
          hintStyle: const TextStyle(color: Colors.grey),
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.sp),
              borderSide: BorderSide(width: 2.sp)),
        ));

    return Scaffold(
      appBar: customAppBar("Register Yourself"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.sp, vertical: 2.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  customText(
                      "Welcome\nas A Partner!", textColor, 30, FontWeight.w500),
                  Container(
                    height: 90.h,
                    width: 90.w,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("asset/icon/consultation.png"),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 17.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: FileImage(photo!),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(18.sp),
                      border: Border.all(
                        color: Color(0xff25265ff),
                      ),
                      // image: DecorationImage(image: )
                    ),
                    width: 110.h,
                    height: 110.w,
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      pickImageFromgallery();
                    },
                    child: Container(
                      height: 50.h,
                      width: 155.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14.sp),
                        color: primary,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          customText(
                            "Upload ",
                            white,
                            15,
                            FontWeight.w700,
                          ),
                          SizedBox(
                            width: 8.sp,
                          ),
                          Icon(
                            Icons.upload_outlined,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                child: Column(
                  children: [
                    customTextForm(nameEditingController, "Name", "Name"),
                    SizedBox(
                      height: 14.h,
                    ),
                    phoneNumberField,
                    SizedBox(
                      height: 14.h,
                    ),
                    emailFiled,
                    SizedBox(
                      height: 14.h,
                    ),
                    genderField,
                    SizedBox(
                      height: 14.h,
                    ),
                    customTextForm(
                        degreeEditingController, "Highest Degree", "Degree"),
                    SizedBox(
                      height: 14.h,
                    ),
                    customTextForm(specializedEditingController,
                        "What's your specialization.", "Specialization"),
                    SizedBox(
                      height: 14.h,
                    ),
                    customTextForm(languageEditingController,
                        "Languague you speak", "Language"),
                    SizedBox(
                      height: 14.h,
                    ),
                    customTextForm(
                        feeEditingController, "How much you charge?", "Charge"),
                    SizedBox(
                      height: 14.h,
                    ),
                    customTextForm(
                        expEditingController, "Your Experience", "Experience"),
                    SizedBox(
                      height: 14.h,
                    ),
                    aboutForm(aboutEditingController),
                    SizedBox(
                      height: 24.h,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Padding(
                padding: EdgeInsets.all(10.sp),
                child: customButton(45, double.infinity, 12, primary, white,
                    "Save", 20, FontWeight.w600, 1, 0, () {
                  imageUrl != null &&
                          nameEditingController.text.isNotEmpty &&
                          emailEditingController.text.isNotEmpty &&
                          degreeEditingController.text.isNotEmpty &&
                          specializedEditingController.text.isNotEmpty &&
                          languageEditingController.text.isNotEmpty &&
                          feeEditingController.text.isNotEmpty &&
                          expEditingController.text.isNotEmpty &&
                          aboutEditingController.text.isNotEmpty
                      ? _submitForm()
                      : ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please enter all details')));
                }),
              ),
              SizedBox(
                height: 50.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submitForm() async {
    await setLoginTrue();
    setPhoneNumber(countryCode.text);
    setName(nameEditingController.text);
    List<int> bufferData = photo!.readAsBytesSync();
    print(phone + "\n");
    print(bufferData);
    CustomWidget().showProgress(context: context);
    String iid = DateTime.now().millisecondsSinceEpoch.toString();
    FirebaseFirestore.instance.collection("doctors").doc(iid).set({
      "image": imageUrl,
      "name": nameEditingController.text,
      // "lastname": lastNameEditingController.text,
      "email": emailEditingController.text,
      "mobile": phone,
      "degree": degreeEditingController.text,
      "specialized": specializedEditingController.text,
      "language": languageEditingController.text,
      "fee": feeEditingController.text,
      "exp": expEditingController.text,
      "total_cons": 0,
      "about": aboutEditingController.text,
      "gender": genderEditingController.text,
      "id": iid
    }).then((value) {
      // SessionManager().setString(Constant.userID, iid);
      CustomWidget().hidProgress(context: context);
      // SessionManager().setString(Constant.isRegistered, '1');
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
    DoctorHome(number: phone)), (Route<dynamic> route) => false);
      // Navigator.push(context,
      //     MaterialPageRoute(builder: (context) => DoctorHome(number: phone)));
    }).catchError((error) => print("Error adding data: $error"));
  }

  Future<String> uploadPic(File file) async {
    Reference reference = _storage.ref().child("doctor_image_bucket/");

    UploadTask uploadTask = reference.putFile(file);

    TaskSnapshot location = await uploadTask.whenComplete(() => null);
    String url = await location.ref.getDownloadURL();
    imageUrl = url;
    return url;
  }

//compress the picked image in KB
  Future<File> customCompressed(
      {required File imagaePathToCompress,
      quality = 100,
      precentage = 10}) async {
    var path = FlutterNativeImage.compressImage(
      imagaePathToCompress.absolute.path,
      quality: 100,
      percentage: 10,
    );
    return path;
  }

  Future pickImageFromgallery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);

      File compressedImage =
          await customCompressed(imagaePathToCompress: imageTemp);
      final sizeInKb = compressedImage.lengthSync() / 1024;
      if (sizeInKb <= 1024) {
        print("\nimage size is: " + sizeInKb.toString());
        setState(() => photo = compressedImage);
        uploadPic(compressedImage);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Image size should be less than 1 MB'),
          ),
        );
        print("\nimage size is: " + sizeInKb.toString());
      }
      // setState(() => photo = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }
}

setPhoneNumber(String mobile) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString("phone", mobile);
}

setName(String name) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString("name", name);
}
