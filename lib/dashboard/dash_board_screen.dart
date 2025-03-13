import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:spendo/budget/screens/budget_screen.dart';
import 'package:spendo/dashboard/controllers/dash_board_controller.dart';
import 'package:spendo/home/screens/home_screen.dart';
import 'package:spendo/profile/screens/profile_screen.dart';
import 'package:spendo/theme/color_manager.dart';
import 'package:spendo/transaction/screens/transaction_screen.dart';

class DashBoardScreen extends StatelessWidget {
  DashBoardScreen({super.key});

  final DashBoardController controller = Get.put(DashBoardController());

  final List<Widget> screens = [
    const HomeScreen(),
    const TransactionScreen(),
    const BudgetScreen(),
    const ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorManager.lightBackground,
      floatingActionButton: _buildSpeedDial(size),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: SizedBox(
        height: size.height / 11.5 + 15,
        width: double.infinity,
        child: Stack(
          children: [
            Image.asset(
              'assets/icons/Subtract.png',
              width: double.infinity,
              fit: BoxFit.cover,
              color: Color(0xFFFCFCFC),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width / 40,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildNavItem(0, 'home', 'Home', () {}, size),
                  _buildNavItem(1, 'transaction', 'Transaction', () {}, size),
                  SizedBox(width: size.width / 10),
                  _buildNavItem(2, 'budget', 'Budget', () {}, size),
                  _buildNavItem(3, 'profile', 'Profile', () {}, size),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Obx(() => screens[controller.selectedIndex.value]),
    );
  }

  Widget _buildNavItem(
      int index, String icon, String label, VoidCallback onTap, Size size) {
    return GestureDetector(
      onTap: () {
        controller.selectedIndex.value = index;
        onTap();
      },
      child: Obx(() => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Transform.translate(
                offset: Offset(0, size.height / -200),
                child: SizedBox(
                  height: size.height * 0.080,
                  width: size.width * 0.080,
                  child: Image.asset(
                    'assets/icons/$icon.png',
                    color: controller.selectedIndex.value == index
                        ? Color(0xFF7F3DFF)
                        : const Color(0xFFC6C6C6),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Transform.translate(
                offset: const Offset(0, -20),
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: controller.selectedIndex.value == index
                        ? Color(0xFF7F3DFF)
                        : Color(0xFFA49F9F),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  Widget _buildSpeedDial(Size size) {
    return Transform.translate(
      offset: Offset(0, size.height / 45),
      child: SizedBox(
        height: size.height / 14,
        child: SpeedDial(
          backgroundColor: Color(0xFF7F3DFF),
          icon: Icons.add,
          activeIcon: Icons.close,
          iconTheme: const IconThemeData(
              color: ColorManager.lightBackground, size: 35),
          overlayColor: ColorManager.lightBackground,
          overlayOpacity: 0.0,
          spaceBetweenChildren: 5,
          children: [
            SpeedDialChild(
              backgroundColor: Colors.red,
              child: Container(
                width: 56,
                height: 56,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'assets/icons/expense.png',
                  fit: BoxFit.contain,
                  color: Colors.white,
                ),
              ),
              onTap: () => print('Send Clicked'),
            ),
            SpeedDialChild(
              backgroundColor: Color(0xFF0077FF),
              child: Container(
                width: 56,
                height: 56,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'assets/icons/currency-exchange.png',
                  fit: BoxFit.contain,
                ),
              ),
              onTap: () => print('Currency Exchange Clicked'),
            ),
            SpeedDialChild(
              backgroundColor: Colors.green,
              child: Container(
                width: 56,
                height: 56,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'assets/icons/Income.png',
                  fit: BoxFit.contain,
                ),
              ),
              onTap: () => print('Receive Clicked'),
            ),
          ],
        ),
      ),
    );
  }
}
