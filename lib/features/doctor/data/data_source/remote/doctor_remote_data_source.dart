import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../../../../../utils/utils.dart';
import '../../models/doctor.dart';

class DoctorRemoteDataSource {
  final FirebaseFirestore _firebaseFireStore = FirebaseFirestore.instance;

  Future<List<Doctor>> fetchDoctors() async {
    try {
      final collectionRef = _firebaseFireStore.collection('doctors');
      final querySnapshot = await collectionRef.get();

      // Mapping the documents to Doctor objects
      final doctors = querySnapshot.docs.map((doc) {
        return Doctor.fromJson(doc.data());
      }).toList();

      return doctors;
    } catch (e) {
      if(kDebugMode) {
        print(e.toString());
      }
      Utils.showSnackBar(e.toString());
      throw Exception(e.toString());
    }
  }
}
