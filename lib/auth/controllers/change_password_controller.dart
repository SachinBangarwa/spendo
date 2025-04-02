import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:spendo/widgets/custom_snackbar_widget.dart';

class ChangePasswordController extends GetxController {
  User? user = FirebaseAuth.instance.currentUser;

  Future<void> changePassword(String currentPassword,
      String newPassword) async {
    if (user != null) {
      try {
        AuthCredential authCredential = EmailAuthProvider.credential(
          email: user!.email!,
          password: currentPassword,
        );

        await user!.reauthenticateWithCredential(authCredential);

        await user!.updatePassword(newPassword);

        showCustomSnackBar(
            'Success', 'Password changed successfully!', isSuccess: true);
      } on FirebaseAuthException catch (e) {
        String errorMessage;
        switch (e.code) {
          case 'wrong-password':
            errorMessage = 'The current password is incorrect.';
            break;
          case 'weak-password':
            errorMessage = 'The new password is too weak.';
            break;
          case 'requires-recent-login':
            errorMessage = 'Please log in again before changing the password.';
            break;
          default:
            errorMessage = 'Something went wrong. Please try again.';
        }

        showCustomSnackBar('Error', errorMessage, isSuccess: false);
      } catch (e) {
        showCustomSnackBar(
            'Error', 'An unexpected error occurred: $e', isSuccess: false);
      }
    }
  }
}


