import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:spendo/widgets/custom_snackbar_widget.dart';

class ForgetPasswordController extends GetxController {
  final auth = FirebaseAuth.instance;

  Future forgetPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      showCustomSnackBar('Success', 'Password reset email has been sent!',
          isSuccess: true);
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        showCustomSnackBar('Error', 'No user found with this email.',
            isSuccess: false);
      } else {
        showCustomSnackBar('Error', e.code.toString(), isSuccess: false);
      }
    } catch (e) {
      showCustomSnackBar('Error', e.toString(), isSuccess: false);
    }
  }
}
