import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendo/auth/screens/sign_up_screen.dart';
import 'package:spendo/profile/controllers/user_detail_controller.dart';
import 'package:spendo/profile/screens/account/account_screen.dart';
import 'package:spendo/profile/screens/account/enter_pin_screen.dart';
import 'package:spendo/profile/screens/setting/setting_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final UserDetailController userDetailController =
      Get.put(UserDetailController());
  final TextEditingController userNameController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool isTextField = false;

  void toggleTextField() async {
    setState(() {
      isTextField = !isTextField;
    });

    if (isTextField) {
      Future.delayed(const Duration(milliseconds: 100), () {
        FocusScope.of(context).requestFocus(_focusNode);
      });
    } else {
      String name = userNameController.text.trim();
      if (name.isNotEmpty) {
        await userDetailController.updateUserName(name);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFF6F6F6),
      body: Padding(
        padding: EdgeInsets.only(
          top: size.height / 10,
          left: size.width * 0.05,
          right: size.width * 0.05,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: size.width / 8,
                  backgroundColor: const Color(0xFF7F3DFF),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: size.width / 8.6,
                    child: Padding(
                      padding: EdgeInsets.all(size.width / 150),
                      child: CircleAvatar(
                        radius: size.width / 8,
                        child: userDetailController.user?.photoURL != null &&
                                userDetailController.user!.photoURL!.isNotEmpty
                            ? ClipOval(
                                child: Image.network(
                                  userDetailController.user!.photoURL!,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                              )
                            : Icon(
                                Icons.person,
                                size: size.width / 6,
                                color: Colors.black,
                              ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: size.width * 0.05),
                Expanded(
                  flex: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Username',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      isTextField
                          ? TextField(
                              style:
                                  const TextStyle(fontWeight: FontWeight.w700),
                              controller: userNameController,
                              keyboardType: TextInputType.name,
                              textCapitalization: TextCapitalization.words,
                              focusNode: _focusNode,
                              decoration: const InputDecoration(
                                hintText: 'Enter your name',
                              ),
                            )
                          : Obx(() {
                              String userName =
                                  userDetailController.userName.value;
                              double fontSize = userName.length > 15 ? 18 : 20;
                              return Text(
                                userName,
                                style: TextStyle(
                                  fontSize: fontSize,
                                  fontWeight: FontWeight.w600,
                                ),
                                overflow: TextOverflow.ellipsis,
                              );
                            }),
                    ],
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: toggleTextField,
                  icon: Icon(isTextField ? Icons.check : Icons.edit_outlined),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.06),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  settingTile(
                      Icons.account_circle, 'Account', Colors.purple, size, () {
                    Get.to(userDetailController.pin.isEmpty
                        ? AccountScreen()
                        : EnterPinScreen());
                  }),
                  Divider(height: 0, color: Colors.black12.withOpacity(0.1)),
                  settingTile(Icons.settings, 'Settings', Colors.purple, size,
                      () {
                    Get.to(() => SettingScreen());
                  }),
                  Divider(height: 0, color: Colors.black12.withOpacity(0.1)),
                  settingTile(
                      Icons.upload, 'Export Data', Colors.purple, size, () {}),
                  Divider(height: 0, color: Colors.black12.withOpacity(0.1)),
                  settingTile(Icons.logout, 'Logout', Colors.red, size, () {
                    _removeAccountButton(context, size);
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget settingTile(
      IconData icon, String title, Color color, Size size, VoidCallback onTap) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: size.height * 0.01,
        horizontal: size.width * 0.05,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(size.width * 0.03),
              margin: EdgeInsets.symmetric(vertical: size.height * 0.01),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: color,
              ),
            ),
            SizedBox(width: size.width * 0.05),
            Expanded(
              child: Text(
                title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _removeAccountButton(BuildContext context, Size size) {
    showModalBottomSheet(
        context: context,
        builder: (index) {
          return Container(
            height: size.height / 3.8,
            width: size.width,
            padding: EdgeInsets.symmetric(horizontal: size.width / 22),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(6),
                  width: size.width / 8,
                  height: 5,
                  decoration: BoxDecoration(
                      color: const Color(0xFFA5BBB3),
                      borderRadius: BorderRadius.circular(8)),
                ),
                SizedBox(height: size.height / 55),
                const Text(
                  'Logout?',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: size.height / 55),
                const Text(
                  'Are you sure do you wanna logout?',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: size.height / 16,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color(0xFFEFEDED)),
                          child: const Text(
                            'No',
                            style: TextStyle(
                                color: Color(0xFF7F3DFF),
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width / 25,
                    ),
                    Flexible(
                      child: GestureDetector(
                        onTap: () async {
                          await FirebaseAuth.instance.signOut();
                          Get.offAll(() => SignUpScreen());
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: size.height / 16,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color(0xFFEFEDED)),
                          child: const Text(
                            'Yes',
                            style: TextStyle(
                                color: Color(0xFF7F3DFF),
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height / 35),
              ],
            ),
          );
        });
  }
}
