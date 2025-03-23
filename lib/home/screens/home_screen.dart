import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:spendo/home/controllers/transaction_controller.dart';
import 'package:spendo/home/screens/common_transaction_screen.dart';
import 'package:spendo/profile/controllers/total_balance_controller.dart';
import 'package:spendo/theme/color_manager.dart';
import 'package:spendo/widgets/custom_spend_frequency_chart_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TransactionController transactionController =
      Get.put(TransactionController());

  final TotalBalanceController totalBalanceController =
      Get.put(TotalBalanceController());
  int selectIndex = 0;
  List days = [
    'Today',
    'Week',
    'Month',
    'Year',
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    transactionController.fetchFilteredTransactions(days[selectIndex]);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: size.height / 2.7,
              width: size.width,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(44),
                  bottomLeft: Radius.circular(44),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFFFFF6E6),
                    const Color(0xFFF8EDD8).withOpacity(0.3),
                  ],
                  stops: const [0.0956, 1.0],
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                    top: size.height / 25,
                    left: size.width / 22,
                    right: size.width / 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: ColorManager.primary, width: 2),
                          ),
                          child: Container(
                            height: size.height / 9,
                            width: size.width / 9,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/Dr_ Abdul Kalam.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const Row(
                          children: [
                            Icon(
                              Icons.keyboard_arrow_down_sharp,
                              size: 35,
                              color: ColorManager.primary,
                            ),
                            Text(
                              'October',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black54),
                            )
                          ],
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.notifications_sharp,
                              size: 35,
                            ))
                      ],
                    ),
                    Transform.translate(
                      offset: const Offset(0, -10),
                      child: const Text(
                        'Account Balance',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF91919F)),
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(0, -10),
                      child: Obx(() => Text(
                            '₹${totalBalanceController.totalBalance.value + transactionController.totalBalance.value}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color:
                                  totalBalanceController.totalBalance.value < 0
                                      ? const Color(0xFFFD3C4A)
                                      : Colors.black,
                            ),
                          )),
                    ),
                    Obx(
                      () => Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: _buildCard(
                              size: size,
                              title: 'Income',
                              amount: transactionController.totalIncome.value
                                  .toString(),
                              color: const Color(0xFF00A86B),
                              icon: 'assets/icons/Income.png',
                              onTab: () => Get.to(() =>
                                  const CommonTransactionScreen(
                                      type: 'Income')),
                            ),
                          ),
                          SizedBox(width: size.width / 30),
                          Flexible(
                            child: _buildCard(
                              size: size,
                              title: 'Expense',
                              amount: transactionController.totalExpense.value
                                  .toString(),
                              color: const Color(0xFFFD3C4A),
                              icon: 'assets/icons/Income.png',
                              onTab: () => Get.to(() =>
                                  const CommonTransactionScreen(
                                      type: 'Expense')),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                physics: const BouncingScrollPhysics(),
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width / 22,
                        vertical: size.height / 70),
                    child: const Text(
                      'Spend Frequency',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const CustomSpendFrequencyChartWidget(),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width / 22,
                        vertical: size.width / 111),
                    child: Row(
                      children: List.generate(4, (index) {
                        return Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectIndex = index;
                                transactionController
                                    .fetchFilteredTransactions(days[index]);
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: size.height / 19,
                              width: size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: selectIndex == index
                                    ? ColorManager.primary.withOpacity(0.2)
                                    : ColorManager.lightBackground,
                              ),
                              child: Text(
                                days[index],
                                style: TextStyle(
                                    color: selectIndex == index
                                        ? ColorManager.primary
                                        : Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width / 22,
                        vertical: size.height / 75),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Recent Transaction',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width / 25,
                              vertical: size.height / 100),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xFF8F57FB).withOpacity(0.2),
                          ),
                          child: const Text(
                            'See All',
                            style: TextStyle(
                                color: Color(0xFF7F3DFF),
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                  transactionController.transactionsList.isEmpty
                      ? Padding(
                          padding: EdgeInsets.only(top: size.height / 20),
                          child: const Center(
                            child: Text(
                              'No transactions available',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        )
                      : Obx(
                          () => ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount:
                                transactionController.transactionsList.length,
                            itemBuilder: (context, index) {
                              Map<String, dynamic> data =
                                  transactionController.transactionsList[index];

                              String formattedAmount =
                                  '${data['amount'] ?? '0'}';

                              String formattedTime = '';
                              DateTime dateTime = DateTime.parse(data['date']);
                              formattedTime = DateFormat.jm().format(dateTime);

                              bool isNegative = false;
                              if (data['type'] == 'Expense' ||
                                  data['type'] == 'Transfer') {
                                isNegative = true;
                              }

                              Color amountColor = isNegative
                                  ? const Color(0xFFFD3C4A)
                                  : const Color(0xFF00A86B);

                              return Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: size.width / 22,
                                    vertical: size.height / 150),
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width / 35,
                                    vertical: size.height / 50),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFAFAFA),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: size.height / 16,
                                      width: size.height / 16,
                                      decoration: BoxDecoration(
                                        color: ColorManager.primary
                                            .withOpacity(0.2),
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
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data['category'] == ''
                                                ? 'Transfer'
                                                : data['category'],
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            data['description'] == ''
                                                ? 'Buy some grocery'
                                                : data['description'],
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13,
                                              color: Color(0xFF91919F),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          isNegative
                                              ? '-₹$formattedAmount'
                                              : "₹$formattedAmount",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: amountColor,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          formattedTime,
                                          style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF91919F),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        )
                ],
              ),
            )
          ],
        ));
  }

  Widget _buildCard({
    required Size size,
    required String title,
    required String amount,
    required Color color,
    required String icon,
    required VoidCallback onTab,
  }) {
    return GestureDetector(
      onTap: onTab,
      child: Container(
        height: size.height / 10,
        padding: EdgeInsets.symmetric(horizontal: size.width / 30),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: size.height / 17,
              width: size.height / 17,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: Padding(
                  padding: EdgeInsets.all(size.width / 34),
                  child: Image.asset(
                    icon,
                    fit: BoxFit.cover,
                    color: color,
                  )),
            ),
            SizedBox(
              width: size.width / 40,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                Text(
                  amount,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
