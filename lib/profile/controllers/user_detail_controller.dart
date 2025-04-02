import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserDetailController extends GetxController {
  User? user = FirebaseAuth.instance.currentUser;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  RxString userName = ''.obs;
  RxString pin = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserDetail();
  }

  Future fetchUserDetail() async {
    try {
      if (user != null) {
        fireStore
            .collection('users')
            .doc(user!.uid)
            .snapshots()
            .listen((snapShot) {
          dynamic data = snapShot.data();
          userName.value = data['name'] ?? '';
          pin.value = data['pin'] ?? '';
        });
      }
    } catch (e) {
    }
  }

  Future updateUserName(String name) async {
    try {
      if (user != null) {
        fireStore
            .collection('users')
            .doc(user!.uid)
            .update({'name': name});
      }
    } catch (e) {
    }
  }

  Future<bool> lockAccount(String password) async {
    try {
      if (user != null) {
        await fireStore.collection('users').doc(user!.uid).set({
          'pin': password,
        }, SetOptions(merge: true));
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> removePin() async {
    try {
      if (user != null) {
        await fireStore.collection('users').doc(user!.uid).update({
          'pin': FieldValue.delete(),
        });
        pin.value = '';
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
