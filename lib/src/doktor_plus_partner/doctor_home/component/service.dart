


import 'package:cloud_firestore/cloud_firestore.dart';

class UserDatabaseManager {
  final CollectionReference doctorList =
      FirebaseFirestore.instance.collection('doctors');

  Future getUserList(String phoneNumber) async {
    List itemsList = [];
    try {
      await doctorList.where('mobile', isEqualTo: phoneNumber).get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          itemsList.add(element.data());
        });
      });
      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  final CollectionReference appointmentList =
      FirebaseFirestore.instance.collection('appointments');

  Future getAppointmentList(String phoneNumber) async {
    List itemsList = [];
    try {
      await appointmentList.where('doctor', isEqualTo: phoneNumber).get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          itemsList.add(element.data());
        });
      });
      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  final CollectionReference patientList =
      FirebaseFirestore.instance.collection('userDetail');

  Future getPatientList(String phoneNumber) async {
    List itemsList = [];
    try {
      await patientList.where('phonenumber', isEqualTo: phoneNumber).get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          itemsList.add(element.data());
        });
      });
      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  
}