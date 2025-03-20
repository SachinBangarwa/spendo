import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendo/commons/common_styles.dart';
import 'package:spendo/profile/screens/account/account_screen.dart';
import 'package:spendo/widgets/custom_button_widget.dart';

import '../../theme/color_manager.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return  Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      body: Padding(
        padding: EdgeInsets.only(
          top: size.height/10,
          left: size.width * 0.05,
          right: size.width * 0.05,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                 CircleAvatar(
                  radius: size.width/8,
                  backgroundColor:  Color(0xFF7F3DFF),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: size.width/8.6,
                    child: Padding(
                      padding:  EdgeInsets.all(size.width/150),
                      child: CircleAvatar(
                        radius: size.width/8,
                        backgroundImage: AssetImage('assets/images/Dr_ Abdul Kalam.png'),
                      ),
                    ),
                  ),
                                   ),
                SizedBox(width: size.width * 0.05),
                Column(
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
                    const Text(
                      'Iriana Saliha',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.edit_outlined),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.06),
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      settingTile(Icons.account_circle, 'Account', Colors.purple, size,(){
                        Get.to(()=>AccountScreen());
                      }),
                      Divider(height: 0,color: Colors.black12.withOpacity(0.1),),
                      settingTile(Icons.settings, 'Settings', Colors.purple, size,(){}),
                      Divider(height: 0,color: Colors.black12.withOpacity(0.1),),

                      settingTile(Icons.upload, 'Export Data', Colors.purple, size,(){}),
                      Divider(height: 0,color: Colors.black12.withOpacity(0.1),),

                      settingTile(Icons.logout, 'Logout', Colors.red, size,(){}),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget settingTile(IconData icon, String title, Color color, Size size,VoidCallback onTab) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: size.height * 0.01,
        horizontal: size.width * 0.05,
      ),
      child: GestureDetector(
        onTap: onTab,
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
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
