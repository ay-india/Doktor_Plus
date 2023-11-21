


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class PatientDatabaseManager {
  

  final CollectionReference appointmentList =
      FirebaseFirestore.instance.collection('appointments');

  Future getAppointmentList(String id) async {
    List itemsList = [];
    try {
      await appointmentList.where('id', isEqualTo: id).get().then((querySnapshot) {
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

  final CollectionReference appointmentUpdateList = FirebaseFirestore.instance.collection('appointments');

Future<void> updateAppointmentDetails(String appointmentId, String diagnosis,List<Map<String, String>> medicine) async {
  try {
    await appointmentUpdateList.doc(appointmentId).update({
      'completed': true,
      'medicine':medicine,
      'diagnosis': diagnosis, 
    });
    print('Appointment details updated successfully.');
  } catch (e) {
    print('Error updating appointment details: $e');
  }
}

final CollectionReference appointmenAddNewtList = FirebaseFirestore.instance.collection('appointments');

Future<void> createNewAppointment(String appointmentId, String diagnosis, List<Map<String, String>> medicine) async {
  try {
    await appointmenAddNewtList.doc(appointmentId).set({
      'completed': true,
       'isOnline': false,
      'diagnosis': diagnosis,
      'medicine': medicine,
    },SetOptions(merge: true));
    print('Appointment created successfully.');
  } catch (e) {
    print('Error creating appointment: $e');
  }
}

  final CollectionReference liveUpdateList = FirebaseFirestore.instance.collection('appointments');

Future<void> liveUpdate(String appointmentId, bool isOnline) async {
  try {
    await appointmentUpdateList.doc(appointmentId).update({
      'isOnline': true,
      
    });
    print('Appointment details updated successfully.');
  } catch (e) {
    print('Error updating appointment details: $e');
  }
}


}
int calculateAgeFromDateOfBirth(String dob) {
  DateTime parsedDate = DateFormat('dd/MM/yyyy').parse(dob);
  DateTime currentDate = DateTime.now();
  int age = currentDate.year - parsedDate.year;
  if (currentDate.month < parsedDate.month ||
      (currentDate.month == parsedDate.month && currentDate.day < parsedDate.day)) {
    age--;
  }
  return age;
}
