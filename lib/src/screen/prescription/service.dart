


import 'package:cloud_firestore/cloud_firestore.dart';

class UserDatabaseManager {
  final CollectionReference prescriptionList =
      FirebaseFirestore.instance.collection('appointments');

  Future getPrescriptionList(String id) async {
    List itemsList = [];
    try {
      await prescriptionList.where('id', isEqualTo: id).get().then((querySnapshot) {
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