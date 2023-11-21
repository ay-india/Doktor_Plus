import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doktor_plus/src/constant/constant.dart';
import 'package:doktor_plus/src/screen/pages/user_info/components/components.dart';
import 'package:doktor_plus/src/screen/pages/user_info/userInfo.dart';
import 'package:doktor_plus/src/screen/pages/user_info/userProfile.dart';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../utils/customWidget.dart';
import '../../home/components/components.dart';

class EditProfileScreen extends StatefulWidget {
  String number;
  String name = '';
  String dob;
  String email;
  String gender;
  String address;
  String allergy;

  String id;
  String image;

  EditProfileScreen(
      {super.key,
      required this.number,
      required this.address,
      required this.dob,
      required this.email,
      required this.allergy,
      required this.gender,
      required this.name,
      required this.image,
      required this.id});
  static String verify = "";

  @override
  State<EditProfileScreen> createState() =>
      _EditProfileScreenState(phone: number, id: id, name: name);
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String id;
  String name;
  var phone = "+911111111111";
  _EditProfileScreenState(
      {required this.phone, required this.id, required this.name});
  final List<String> genderItems = [
    'Male',
    'Female',
  ];
  late Stream<QuerySnapshot<Map<String, dynamic>>> firestore = FirebaseFirestore
      .instance
      .collection('userDetail')
      .orderBy('date', descending: true)
      .snapshots();
  late CollectionReference<Map<String, dynamic>> ref =
      FirebaseFirestore.instance.collection('userDetail');

  String? selectedValue;
  int ta = 1;
  final _formKey = GlobalKey<FormState>();

  TextEditingController countryCode = TextEditingController();

  final firstNameEditingController = new TextEditingController();

  final dateofBirthEditingController = new TextEditingController();
  final genderEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final addressEditingController = new TextEditingController();
  final allergyEditingController = new TextEditingController();
  final phoneNumberEditingController = new TextEditingController();
  void initState() {
    countryCode.text = widget.number;
    // getId();

    setState(() {
      firstNameEditingController.text = widget.name;

      allergyEditingController.text = widget.allergy;
      genderEditingController.text = widget.gender;
      addressEditingController.text = widget.address;

      dateofBirthEditingController.text = widget.dob;
      emailEditingController.text = widget.email;
    });
    super.initState();
  }

  // Future<void> getId() async {
  //   id = await SessionManager().getString("userid");
  // }

  final _auth = FirebaseAuth.instance;
  FirebaseStorage _storage = FirebaseStorage.instance;

  // final _auth = FirebaseAuth.instance;
  File? photo = File('');
  int photochoosen = 0;
  late DateTime _selectedDate;
  String dob = "Date of Birth";

  @override
  Widget build(BuildContext context) {
    if (widget.dob.isNotEmpty) {
      dob = widget.dob;
    }

    double height_variable = MediaQuery.of(context).size.height;
    double width_varible = MediaQuery.of(context).size.width;
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
        

          contentPadding: EdgeInsets.fromLTRB(20.sp, 15.sp, 20.sp, 15.sp),
          hintText: "Email Address",
          hintStyle: const TextStyle(color: Colors.grey),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.sp),
            
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
        genderEditingController.text.toString(),
        style: TextStyle(fontSize: 16.sp, color: Colors.black),
      ),
      items: genderItems
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style:  TextStyle(
                 color: textColor,
                    fontSize: 14.sp,
                  ),
                ),
              ))
          .toList(),
      validator: (genderEditingController) {
        if (genderEditingController == null) {
          return 'Please select gender.';
        }
        return null;
      },
      onChanged: (value) {
        genderEditingController.text = value.toString();
        //Do something when changing the item if you want.
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

    final addressField = TextFormField(
      style: TextStyle(color: textColor),
        autofocus: false,
        controller: addressEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value!.isEmpty) {
            return ("School Name cannot be Empty");
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

    final allergyField = TextFormField(
      style: TextStyle(color: textColor),
        autofocus: false,
        controller: allergyEditingController,
        // keyboardType: TextInputType.number,
        validator: (value) {
          RegExp regex = new RegExp(r'/^(?:[+0]9)?[0-9]{3}$/');
          if (value!.isEmpty) {
            return ("Class cannot be Empty");
          }
          if (!regex.hasMatch(value)) {
            // return ("Enter Valid Class ");
          }
          return null;
        },
        onSaved: (value) {
          allergyEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          // prefixIcon: Icon(Icons.book),
          contentPadding: EdgeInsets.fromLTRB(20.sp, 15.sp, 20.sp, 15.sp),
          hintText: "Allergy",
          hintStyle: const TextStyle(color: Colors.grey),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.sp),
            // borderSide: BorderSide.
          ),
        ));

    final phoneNumberField = TextFormField(
      style: TextStyle(color: textColor),
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
      appBar: customAppBar("Edit Profile"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.sp, vertical: 2.sp),
          child: StreamBuilder<QuerySnapshot>(
              stream: firestore,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customText(
                        "Update Your Profile", textColor, 20, FontWeight.w500),
                    SizedBox(
                      height: 23.h,
                    ),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            image: ta == 1
                                ? DecorationImage(
                                    image: MemoryImage(
                                      Base64Decoder().convert(widget.image),
                                    ),
                                    fit: BoxFit.cover,
                                  )
                                : DecorationImage(
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
                            setState(() {
                              ta = 0;
                            });
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
                      height: height_variable * 0.03,
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
                          dateofBirthField,
                          SizedBox(
                            height: 14.h,
                          ),
                          genderField,

                          SizedBox(
                            height: 14.h,
                          ),
                          addressField,
                          SizedBox(
                            height: 14.h,
                          ),
                          allergyField,
                          SizedBox(
                            height: 14.h,
                          ),

                          SizedBox(
                            height: 14.h,
                          ),
                          emailFiled
                          // SizedBox(
                          //   height: 20,
                          // ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    Container(
                      child: Column(
                        children: [
                          Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(14.sp),
                            color:primary,
                            child: MaterialButton(
                              padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                              minWidth: MediaQuery.of(context).size.width,
                              onPressed: () async {
                                firstNameEditingController.text.isNotEmpty &&
                                        dob != "Date of Birth" &&
                                        emailEditingController
                                            .text.isNotEmpty &&
                                        genderEditingController
                                            .text.isNotEmpty &&
                                        addressEditingController
                                            .text.isNotEmpty &&
                                        allergyEditingController.text.isNotEmpty
                                    ? {
                                        setName(
                                            firstNameEditingController.text),
                                        const Center(
                                          child: CircularProgressIndicator(
                                            color: primary,
                                          ),
                                        ),
                                        ref.doc(id).update({
                                          "image": ta != 1
                                              ? base64Encode(
                                                  photo!.readAsBytesSync())
                                              : widget.image,
                                          "name":
                                              firstNameEditingController.text,
                                          // "lastname": lastNameEditingController.text,
                                          "email": emailEditingController.text,
                                          "dateofbirth": dob,
                                          "gender":
                                              genderEditingController.text,

                                          "address":
                                              addressEditingController.text,
                                          "allergy":
                                              allergyEditingController.text,

                                          "phonenumber": phone,
                                        }).then((value) {
                                          // SessionManager().setString(Constant.userID, );
                                          SnackBar(
                                            content: Text(
                                              "Profile details updated",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18.sp),
                                            ),
                                            backgroundColor: Color(0xff25265f),
                                          );
                                          CustomWidget()
                                              .hidProgress(context: context);
                                          print('\n\nEnter the then block');
                                          // SessionManager().setString(Constant.isRegistered, '1');
                                          // Navigator.pop(context);
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pushReplacement(
                                            MaterialPageRoute(
                                              builder: (context) => profile(
                                                number: widget.number,
                                              ),
                                            ),
                                          );
                                        }).catchError((error) =>
                                            print("Error adding data: $error"))
                                      }
                                    : ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                            content: Text(
                                                'Please enter all details')));
                              },
                              child: Text(
                                "Save",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height_variable * 0.026,
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }

  Future<String> uploadPic(File file) async {
    //Get the file from the image picker and store it

    //Create a reference to the location you want to upload to in firebase
    Reference reference = _storage.ref().child("images/");

    //Upload the file to firebase
    UploadTask uploadTask = reference.putFile(file);

    // Waits till the file is uploaded then stores the download url
    TaskSnapshot location = await uploadTask.whenComplete(() => null);
    String url = await location.ref.getDownloadURL();

    //returns the download url
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
                onPrimary: white,
                onSurface: textColor,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: primary,
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
