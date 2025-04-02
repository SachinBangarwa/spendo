import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendo/theme/color_manager.dart';
import 'package:spendo/widgets/common_app_bar%20_widget.dart';

class CurrencyScreen extends StatelessWidget {
  CurrencyScreen({super.key});

  final List<String> currencyList = [
    'United States (USD)',
    'Indonesia (IDR)',
    'Japan (JPY)',
    'Russia (RUB)',
    'Germany (EUR)',
    'Korea (WON)'
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ColorManager.lightBackground,
      appBar: CommonAppBar(
        title: 'Currency',
        onBack: () {
          Get.back();
        },
      ),
      body: Column(
        children: [
          Divider(color: Colors.black12,height: size.height/88,),
          ListView.builder(
            shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: currencyList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: EdgeInsets.only(left:  size.width / 22,),
                  onTap: () {},
                  title: Text(
                    currencyList[index],
                    style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
