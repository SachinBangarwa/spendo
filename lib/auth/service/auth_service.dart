import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  static Future saveUserData(User user, String authMethod,
      {String userName = ''}) async {
    await fireStore.collection('users').doc(user.uid).set({
      'userId': user.uid,
      'email': user.email ?? '',
      'name': user.displayName ?? userName,
      "phone": user.phoneNumber ?? '',
      "authMethod": authMethod,
      "createdAt": FieldValue.serverTimestamp()
    }, SetOptions(merge: true));
  }

  static Future updatePhoneNumber(User user, String phoneNumber) async {
    fireStore.collection('users').doc(user.uid).update({
      "phone": phoneNumber,
    });
  }
}
