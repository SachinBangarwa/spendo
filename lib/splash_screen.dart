import 'package:flutter/material.dart';
import 'package:spendo/theme/color_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xFF7F3DFF),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(right: size.width/10),
              width: size.width /6,
              height: size.height / 6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF6A0AE4),
                boxShadow: [
                  BoxShadow(
                    color: Colors.transparent,
                    blurRadius: 20,
                    spreadRadius: 0,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
            ),
            const Text(
              'spendo',
              style: TextStyle(
                fontSize: 50,
                color: ColorManager.lightBackground,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
