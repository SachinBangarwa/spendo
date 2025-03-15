import 'package:flutter/material.dart';

class FinancialReportExpenseScreen extends StatefulWidget {
  const FinancialReportExpenseScreen({super.key});

  @override
  State<FinancialReportExpenseScreen> createState() =>
      _FinancialReportExpenseScreenState();
}

class _FinancialReportExpenseScreenState
    extends State<FinancialReportExpenseScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFFD3C4A),
      body: Column(
        children: [
          SizedBox(
            height: size.height / 6,
          ),
          Center(
              child: Text(
            "This Month",
            style: TextStyle(
              fontSize: 24,
              color: Colors.white70,
              fontWeight: FontWeight.w600,
            ),
          )),
          SizedBox(
            height: size.height / 8,
          ),
          Text(
            'You Spend💸',
            style: TextStyle(
                fontSize: 36, fontWeight: FontWeight.w700, color: Colors.white),
          ),
          Text(
            '332 ',
            style: TextStyle(
                fontSize: 64, fontWeight: FontWeight.w700, color: Colors.white),
          ),
          Spacer(),
          Container(
            margin: EdgeInsets.only(
                left: size.width / 22,
                right: size.width / 22,
                bottom: size.height / 22),
            padding: EdgeInsets.all(size.height / 45),
            width: double.infinity,

            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                )),
            child: Column(
              children: [
                Text(
                  'and your biggest \nspending is from',
                  style: TextStyle(
                      fontSize: 24, fontWeight: FontWeight.w700, height: 0),
                ),
                SizedBox(
                  height: size.height / 66,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: size.height/77),
                  margin: EdgeInsets.only(left: 40, right: 40),
                  decoration: BoxDecoration(
                    color: Color(0xFFE3E5E5),
                      border: Border.all(color: Color(0xffcac0dd), width: 1),
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.shopping_cart_rounded,
                        color: Colors.black,
                      ),
                      SizedBox(width: size.width/77,),
                      Text(
                        'Shopping',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 18),
                      )
                    ],
                  ),
                ),
                SizedBox(height: size.height/180,),
                Text(
                  "\$220",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
