import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:spendo/widgets/custom_snackbar_widget.dart';

class LoginController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  RxBool visible = true.obs;
  RxBool agreeCheckPrivacy = false.obs;

  Future<User?> loginCloud(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      User? user = userCredential.user;
      showCustomSnackBar('Success', 'Login successful!', isSuccess: true);
      return user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          showCustomSnackBar('Error', 'No user found for this email.',
              isSuccess: false);
          break;
        case 'wrong-password':
          showCustomSnackBar('Error', 'Incorrect password. Please try again.',
              isSuccess: false);
          break;
        case 'invalid-email':
          showCustomSnackBar('Error', 'The email address is not valid.',
              isSuccess: false);
          break;
        case 'user-disabled':
          showCustomSnackBar('Error', 'This account has been disabled.',
              isSuccess: false);
          break;
        default:
          showCustomSnackBar('Error', 'An error occurred: ${e.message}',
              isSuccess: false);
          break;
      }
    } catch (e) {
      showCustomSnackBar(
          'Error', 'An unexpected error occurred: ${e.toString()}',
          isSuccess: false);
    }
    return null;
  }
}
