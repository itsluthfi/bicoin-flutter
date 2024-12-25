import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Fungsi untuk mendapatkan data user dari Firestore berdasarkan email
  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.data() as Map<String, dynamic>;
      } else {
        print('User not found with email: $email');
        return null;
      }
    } catch (e) {
      print('Error fetching user by email: $e');
      throw e;
    }
  }

  /// Fungsi untuk logout
  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      print('Logout Error: $e');
      throw e;
    }
  }

  /// Fungsi untuk mendapatkan user saat ini
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }
}
