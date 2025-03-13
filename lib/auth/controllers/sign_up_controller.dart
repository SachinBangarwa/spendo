import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:spendo/widgets/custom_snackbar_widget.dart';

class SignUpController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  RxBool visible = true.obs;
  RxBool agreeCheckPrivacy = false.obs;

  Future<User?> signUpCloud(String email, String password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      User? user = userCredential.user;
      showCustomSnackBar('Success', 'Account created successfully!', isSuccess: true);
      return user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'weak-password':
          showCustomSnackBar('Error', 'The password provided is too weak.', isSuccess: false);
          break;
        case 'email-already-in-use':
          showCustomSnackBar('Error', 'An account already exists for this email.', isSuccess: false);
          break;
        case 'invalid-email':
          showCustomSnackBar('Error', 'The email address is not valid.', isSuccess: false);
          break;
        default:
          showCustomSnackBar('Error', 'An error occurred: ${e.message}', isSuccess: false);
          break;
      }
    } catch (e) {
      showCustomSnackBar('Error', 'An unexpected error occurred: ${e.toString()}', isSuccess: false);
    }
    return null;
  }

  Future<User?> signWithGoogle() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

        AuthCredential authCredential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken);

        UserCredential? userCredential =
        await auth.signInWithCredential(authCredential);

        showCustomSnackBar('Success', 'Signed in with Google!', isSuccess: true);
        return userCredential.user;
      } else {
        showCustomSnackBar('Error', 'Google Sign-In was canceled.', isSuccess: false);
      }
    } catch (e) {
      showCustomSnackBar('Error', 'Google Sign-In failed: $e', isSuccess: false);
    }
    return null;
  }
}


