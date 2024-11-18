import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Add or update user data
  Future<void> updateUserData({
    required String fullName,
    required String nickname,
    required String phoneNumber,
    required String age,
  }) async {
    User? user = _auth.currentUser;
    if (user != null) {
      try {
        await _firestore.collection('users').doc(user.uid).set({
          'fullName': fullName,
          'nickname': nickname,
          'email': user.email ?? '',
          'phoneNumber': phoneNumber,
          'age': age,
        }, SetOptions(merge: true)); // Merge prevents overwriting existing fields
      } catch (e) {
        throw Exception('Failed to update user data: $e');
      }
    }
  }

  // Fetch user data
  Future<Map<String, dynamic>?> getUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot doc = await _firestore.collection('users').doc(user.uid).get();
      return doc.exists ? doc.data() as Map<String, dynamic>? : null;
    }
    return null;
  }
}
