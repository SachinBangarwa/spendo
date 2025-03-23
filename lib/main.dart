
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:spendo/auth/screens/sign_up_screen.dart';

import 'package:spendo/firebase_options.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
//sachin
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,color: Colors.red,
      theme: ThemeData.light(),
      home: SignUpScreen(),
    );
  }
}






// class PhoneAuthScreen extends StatefulWidget {
//   @override
//   _PhoneAuthScreenState createState() => _PhoneAuthScreenState();
// }
//
// class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   TextEditingController phoneController = TextEditingController();
//   TextEditingController otpController = TextEditingController();
//   String verificationId = "";
//   bool otpSent = false;
//
//   void sendOTP() async {
//     try {
//       await _auth.verifyPhoneNumber(
//         phoneNumber: "+91${phoneController.text}",
//         verificationCompleted: (PhoneAuthCredential credential) async {
//           await _auth.signInWithCredential(credential);
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text("Auto Verification Successful!")),
//           );
//         },
//         verificationFailed: (FirebaseAuthException e) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text("Verification Failed: ${e.message}")),
//           );
//         },
//         codeSent: (String verId, int? resendToken) {
//           setState(() {
//             verificationId = verId;
//             otpSent = true;
//           });
//         },
//         codeAutoRetrievalTimeout: (String verId) {
//           setState(() {
//             verificationId = verId;
//           });
//         },
//         timeout: Duration(seconds: 60),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Error: $e")),
//       );
//     }
//   }
//
//   Future<void> verifyOTP(String otp) async {
//     try {
//       PhoneAuthCredential credential = PhoneAuthProvider.credential(
//         verificationId: verificationId, // ✅ Fix: Correct variable name
//         smsCode: otp,
//       );
//
//       await _auth.signInWithCredential(credential);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("OTP Verified Successfully!")),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Invalid OTP: $e")),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Firebase OTP Authentication")),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: phoneController,
//               keyboardType: TextInputType.phone,
//               decoration: InputDecoration(labelText: "Enter Phone Number"),
//             ),
//             SizedBox(height: 10),
//             if (otpSent)
//               TextField(
//                 controller: otpController,
//                 keyboardType: TextInputType.number,
//                 decoration: InputDecoration(labelText: "Enter OTP"),
//               ),
//             SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: otpSent
//                   ? () => verifyOTP(otpController.text) // ✅ Fix: Function properly called
//                   : sendOTP,
//               child: Text(otpSent ? "Verify OTP" : "Send OTP"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
