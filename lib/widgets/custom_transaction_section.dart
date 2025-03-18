import 'package:flutter/material.dart';
import '../theme/color_manager.dart';

class CustomTransactionSection extends StatelessWidget {
  const CustomTransactionSection({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Container(

          margin: EdgeInsets.symmetric(
              // horizontal: size.width / 22,
              vertical: size.height / 150),
          padding: EdgeInsets.symmetric(
              horizontal: size.width / 34, vertical: size.height / 50),
          decoration: BoxDecoration(
            color: const Color(0xFFFAFAFA),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: size.height / 16,
                width: size.height / 16,
                decoration: BoxDecoration(
                  color: ColorManager.primary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Image.asset(
                    'assets/icons/profile.png',
                    width: size.height / 22,
                    height: size.height / 22,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(width: size.width / 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Shopping',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Buy some grocery',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      color: Color(0xFF91919F),
                    ),
                  ),
                ],
              ),
              Spacer(),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '- Rs120',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '10:00 AM',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF91919F),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
