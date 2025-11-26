import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:health_care_application/utils/utils.dart';

import '../../../../auth/data/models/end_user.dart';

class ProfileRemoteDataSource {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final String _collectionName = 'users';

  Future<void> saveUser({required EndUser endUser, required String uid}) async {
    final collectionRef = _fireStore.collection(_collectionName);
    try {
      endUser.id = uid;
      await collectionRef.doc(uid).set(endUser.toJson());
    } on FirebaseException catch (e) {
      if(kDebugMode) print(e.message);
      Utils.showSnackBar(e.message);
    } catch (e) {
      if (kDebugMode) print(e.toString());
      Utils.showSnackBar(e.toString());
    }
  }

  Future<EndUser?> fetchUser({required String uid}) async {
    try {
      final collectionRef = _fireStore.collection(_collectionName);
      final snapshot = await collectionRef.doc(uid).get();
      if(snapshot.exists) {
        return EndUser.fromJson(snapshot.data() as Map<String, dynamic>, uid);
      }
    } on FirebaseException catch (e) {
      if(kDebugMode) print(e.message);
      Utils.showSnackBar(e.message);
    } catch (e) {
      if (kDebugMode) print(e.toString());
      Utils.showSnackBar(e.toString());
    }
    return null;
  }
}
