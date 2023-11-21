


import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentDatabaseManager {
  final CollectionReference appointmentList =
      FirebaseFirestore.instance.collection('appointments');

  Future getAppointmentList(String phoneNumber) async {
    List itemsList = [];
    try {
      await appointmentList.where('patient', isEqualTo: phoneNumber).orderBy('id',descending: true).get().then((querySnapshot) {
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

  final CollectionReference closedAppointmentList =
      FirebaseFirestore.instance.collection('appointments');

  Future getClosedAppointmentList(String phoneNumber) async {
    List itemsList = [];
    try {
      await closedAppointmentList.where('patient', isEqualTo: phoneNumber ).where('completed', isEqualTo: true).get().then((querySnapshot) {
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