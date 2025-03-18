import 'package:flutter/material.dart';

class CustomLinearProgressBarWidget extends StatelessWidget {
  CustomLinearProgressBarWidget({super.key});

  final List<Map> expense = [
    {'title': 'Category', 'amount': 200, 'color': Color(0xFFFCAC12)},
    {'title': 'Shopping', 'amount': 150, 'color': Color(0xFFFD3C4A)},
    {'title': 'Food', 'amount': 200, 'color': Color(0xFF7F3DFF)},
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView.builder(
      shrinkWrap: true,
        itemCount: expense.length,
        itemBuilder: (context, index) {
          double progress=expense[index]['amount']/1000;
      return Padding(
        padding:  EdgeInsets.symmetric(vertical: size.height/99),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(
                   horizontal:   size.width / 45,
                    vertical: 2
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFFFCFCFC),
                      border: Border.all(width: 2, color: Colors.black12),
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: [
                      Container(
                        width: size.width/25,
                        height: size.height/25,
                        decoration: BoxDecoration(
                          color: expense[index]["color"],
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: size.width/55,),
                      Text(
                        expense[index]['title'],
                        style: TextStyle(fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                ),
                Text(
                  '\$${expense[index]['amount']}',
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
            SizedBox(height: size.height/99,),
            LinearProgressIndicator(
              value:progress,
              minHeight: size.height/66,
              borderRadius: BorderRadius.circular(20),
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation( expense[index]['color'],),
            ),
          ],
        ),
      );
    });
  }
}
