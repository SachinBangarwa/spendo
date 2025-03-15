
import 'package:flutter/material.dart';

class FinancialReportBudgetScreen extends StatelessWidget {
  const FinancialReportBudgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xFF7F3DFF),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: size.height / 6,
            ),
            Text(
              "This Month",
              style: TextStyle(
                fontSize: 24,
                color: Colors.white70,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: size.height / 8,
            ),
            Text(
              "2 of 12 Budget is \nexceeds the limit",
              style: TextStyle(
                color: Colors.white,
                fontSize: 33,
                fontWeight: FontWeight.w700,height: 0
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: size.height / 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildCategoryButton(
                 size,
                  Icons.shopping_bag,
                  "Shopping",
                  Colors.amber,
                ),
                SizedBox(
                  width: size.width / 20,
                ),
                _buildCategoryButton(
                 size,
                  Icons.restaurant,
                  "Food",
                  Colors.redAccent,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryButton(
     Size size,
      IconData icon,
      String label,
      Color color,
      ) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: size.height/55,
        horizontal: size.width/25,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          Icon(icon, color: color,size: 30,),
          SizedBox(width: size.width * 0.02),
          Text(
            label,
            style: TextStyle(
                fontWeight: FontWeight.w700, fontSize: 18
            ),
          ),
        ],
      ),
    );
  }
}