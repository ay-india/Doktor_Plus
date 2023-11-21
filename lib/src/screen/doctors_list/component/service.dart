import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseManager {
  final CollectionReference doctorList =
      FirebaseFirestore.instance.collection('doctors');

  Future getUsersList() async {
    List itemsList = [];
    try {
      await doctorList.get().then((querySnapshot) {
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