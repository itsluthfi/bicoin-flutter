import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FirestoreService {
  FirebaseApp secondaryApp;
  final FirebaseFirestore _db;

  FirestoreService()
      : secondaryApp = Firebase.app('dev-coinku'),
        _db = FirebaseFirestore.instanceFor(app: Firebase.app('dev-coinku'));

  Future<void> setData(
      String collectionPath, String docId, Map<String, dynamic> data) async {
    try {
      await _db.collection(collectionPath).doc(docId).set(data);
    } catch (e) {
      log('Error setting data: $e');
    }
  }

  Future<void> addData(String collectionPath, Map<String, dynamic> data) async {
    try {
      await _db.collection(collectionPath).add(data);
    } catch (e) {
      log('Error adding data: $e');
    }
  }

  Future<DocumentSnapshot> getData(String collectionPath, String docId) async {
    try {
      return await _db.collection(collectionPath).doc(docId).get();
    } catch (e) {
      log('Error getting data: $e');
      rethrow;
    }
  }

  Future<QuerySnapshot> getCollection(String collectionPath) async {
    try {
      return await _db.collection(collectionPath).get();
    } catch (e) {
      log('Error getting collection: $e');
      rethrow;
    }
  }

  Future<QuerySnapshot> getSubCollection(String collectionPath) async {
    try {
      return await _db.collection(collectionPath).get();
    } catch (e) {
      log('Error getting subcollection: $e');
      rethrow;
    }
  }

  Future<void> deleteData(String collectionPath, String docId) async {
    try {
      await _db.collection(collectionPath).doc(docId).delete();
    } catch (e) {
      log('Error deleting data: $e');
    }
  }

  Future<DocumentSnapshot> getDataByField({
    required String collection,
    required String field,
    required String value,
  }) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection(collection)
        .where(field, isEqualTo: value)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first;
    } else {
      throw Exception('Data tidak ditemukan');
    }
  }
}
