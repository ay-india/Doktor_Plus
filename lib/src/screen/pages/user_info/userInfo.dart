import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
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
import '../../home/components/components.dart';
import '../otp/otp.dart';

class UserDetailForm extends StatefulWidget {
  String number;
  UserDetailForm({super.key, required this.number});
  static String verify = "";

  @override
  State<UserDetailForm> createState() => _onboardingState(phone: number);
}

class _onboardingState extends State<UserDetailForm> {
  var phone = "+911111111111";
  _onboardingState({required this.phone});
  final List<String> genderItems = [
    'Male',
    'Female',
  ];

  String? selectedValue;

  final _formKey = GlobalKey<FormState>();

  TextEditingController countryCode = TextEditingController();
  void initState() {
    countryCode.text = widget.number;
    super.initState();
  }

  final _auth = FirebaseAuth.instance;
  FirebaseStorage _storage = FirebaseStorage.instance;

  final firstNameEditingController = new TextEditingController();

  final dateofBirthEditingController = new TextEditingController();
  final genderEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();

  final allergyEditingController = new TextEditingController();
  final addressEditingController = new TextEditingController();
  final phoneNumberEditingController = new TextEditingController();
  // final _auth = FirebaseAuth.instance;
  File? photo = File('');
  int photochoosen = 0;
  late DateTime _selectedDate;
  String dob = "Date of Birth";

  @override
  Widget build(BuildContext context) {
    final firstNameField = TextFormField(
        style: TextStyle(color: textColor),
        autofocus: false,
        controller: firstNameEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("First Name cannot be Empty");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid name(Min. 3 Character)");
          }
          return null;
        },
        onSaved: (value) {
          firstNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          // prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20.sp, 15.sp, 20.sp, 15.sp),
          hintText: "What's your name ?",
          hintStyle: const TextStyle(color: Colors.grey),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.sp),
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
        ));

    final dateofBirthField = GestureDetector(
      onTap: () {
        _pickDateDialog();
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            14.sp,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(2.sp, 15.sp, 20.sp, 15.sp),

          // padding: EdgeInsets.all(8.0.sp),
          child: Row(
            children: [
              // Icon(Icons.calendar_today),
              SizedBox(width: 20.sp),
              Text(
                dob,
                style: TextStyle(
                    color: dob == "Date of Birth" ? Colors.grey : Colors.black),
              )
            ],
          ),
        ),
      ),
    );

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

    final allergyField = TextFormField(
        style: TextStyle(color: textColor),
        autofocus: false,
        controller: allergyEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Allergy cannot be Empty");
          }
          return null;
        },
        onSaved: (value) {
          allergyEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          // prefixIcon: Icon(Icons.health_and_safety),
          contentPadding: EdgeInsets.fromLTRB(20.sp, 15.sp, 20.sp, 15.sp),
          hintText: "Type of Allergy",
          hintStyle: const TextStyle(color: Colors.grey),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.sp),
            // borderSide: BorderSide.none
          ),
        ));

    final addressField = TextFormField(
        style: TextStyle(color: textColor),
        autofocus: false,
        controller: addressEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Address cannot be Empty");
          }
          return null;
        },
        onSaved: (value) {
          addressEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          // prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20.sp, 15.sp, 20.sp, 15.sp),
          hintText: "Address",
          hintStyle: const TextStyle(color: Colors.grey),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.sp),
            // borderSide: BorderSide.none,
          ),
        ));

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
    final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(14.sp),
      color: Color(0xff25265f),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () async {
          firstNameEditingController.text.isNotEmpty &&
                  dob != "Date of Birth" &&
                  emailEditingController.text.isNotEmpty &&
                  genderEditingController.text.isNotEmpty &&
                  allergyEditingController.text.isNotEmpty &&
                  addressEditingController.text.isNotEmpty
              ? _submitForm()
              : ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Please enter all details')));
        },
        child: Text(
          "Save",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
    return Scaffold(
      appBar: customAppBar("Register Yourself"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.sp, vertical: 2.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 21.h,
              ),
              customText("Let's Sign up.", textColor, 30, FontWeight.w500),
              SizedBox(
                height: 17.h,
              ),
              customText(
                  "Welcome\nto Doktor PLUS!", textColor, 30, FontWeight.w500),
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
                    firstNameField,
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
                    dateofBirthField,
                    SizedBox(
                      height: 14.h,
                    ),
                    genderField,
                    SizedBox(
                      height: 14.h,
                    ),
                    allergyField,
                    SizedBox(
                      height: 14.h,
                    ),
                    addressField,
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
                  _submitForm();
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
    setLoginTrue();
    setPhoneNumber(countryCode.text);
    setName(firstNameEditingController.text);
    List<int> bufferData = photo!.readAsBytesSync();
    print(phone + "\n");
    print(bufferData);
    CustomWidget().showProgress(context: context);
    String iid = DateTime.now().millisecondsSinceEpoch.toString();
    FirebaseFirestore.instance.collection("userDetail").doc(iid).set({
      "image": base64Encode(bufferData),
      "name": firstNameEditingController.text,
      // "lastname": lastNameEditingController.text,
      "email": emailEditingController.text,
      "dob": dob,
      "gender": genderEditingController.text,
      "allergy": allergyEditingController.text,
      "address": addressEditingController.text,
      "totalConsultation": 0,
      "phonenumber": phone,
      // "udid": await _getId(),
      "id": iid
    }).then((value) {
      // SessionManager().setString(Constant.userID, iid);
      CustomWidget().hidProgress(context: context);
      // SessionManager().setString(Constant.isRegistered, '1');
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
    HomePage(
                                                        number: phone,
                                                      )), (Route<dynamic> route) => false);
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => HomePage(number: phone,)));
    }).catchError((error) => print("Error adding data: $error"));
  }

  Future<String> uploadPic(File file) async {
    Reference reference = _storage.ref().child("images/");

    UploadTask uploadTask = reference.putFile(file);

    TaskSnapshot location = await uploadTask.whenComplete(() => null);
    String url = await location.ref.getDownloadURL();

    return url;
  }

  void _pickDateDialog() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime.now(),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: primary,
                onPrimary: white, // <-- SEE HERE
                onSurface: textColor, // <-- SEE HERE
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: primary, // button text color
                ),
              ),
            ),
            child: child!,
          );
        }).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        //for rebuilding the ui
        _selectedDate = pickedDate;
        dob =
            '${_selectedDate.day.toString().padLeft(2, "0")}/${_selectedDate.month.toString().padLeft(2, "0")}/'
            '${_selectedDate.year.toString()} ';
        //  dateofBirthEditingController.text == _selectedDate.toString();
      });
    });
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

  Future pickImageFromCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemp = File(image.path);
      File compressedImage =
          await customCompressed(imagaePathToCompress: imageTemp);
      final sizeInKb = compressedImage.lengthSync() / 1024;
      if (sizeInKb <= 1024) {
        print("\nimage size is: " + sizeInKb.toString());
        setState(() => photo = compressedImage);
      } else {
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
