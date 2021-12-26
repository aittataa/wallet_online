import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet_online/app/config/constants/app_constant.dart';
import 'package:wallet_online/app/config/functions/app_function.dart';
import 'package:wallet_online/app/config/messages/app_message.dart';
import 'package:wallet_online/app/config/themes/app_theme.dart';
import 'package:wallet_online/app/data/models/transactions.dart';
import 'package:wallet_online/app/modules/home/controllers/home_controller.dart';
import 'package:wallet_online/app/modules/home/widgets/transaction_add.dart';
import 'package:wallet_online/app/modules/home/widgets/transaction_shape.dart';
import 'package:wallet_online/app/shared/action_button.dart';
import 'package:wallet_online/app/shared/bounce_point.dart';
import 'package:wallet_online/app/shared/empty_box.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppMessage.appTitle)),
      floatingActionButton: ActionButton(
        onPressed: () => AppFunction.lunchNew(
          context,
          builder: TransactionAdd(controller: controller),
        ),
      ),
      body: Obx(() {
        final bool state = controller.state.value;
        if (state) {
          return BouncePoint();
        } else {
          final List<Transactions> myList = controller.transactions;
          final bool isEmpty = myList.isEmpty;
          if (isEmpty) {
            return EmptyBox();
          } else {
            final double incomes = AppFunction.loadCount(myList, 0);
            final double expenses = AppFunction.loadCount(myList, 1);
            final balance = incomes - expenses;
            final balanceState = balance >= 0;
            return ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(10),
              physics: const BouncingScrollPhysics(),
              children: [
                Container(
                  height: 250,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryBackColor,
                    boxShadow: [AppConstant.boxShadow],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: PieChart(
                          PieChartData(
                            sectionsSpace: 1,
                            borderData: FlBorderData(show: false),
                            pieTouchData: PieTouchData(enabled: true),
                            sections: List.generate(2, (i) {
                              switch (i) {
                                case 0:
                                  final bool state = incomes != 0;
                                  return PieChartSectionData(
                                    value: state ? incomes : 0,
                                    color: AppTheme.incomeColor,
                                    radius: 50,
                                    showTitle: state,
                                    title: "${incomes.toStringAsFixed(2)} ${AppConstant.appCurrency}",
                                    titleStyle: const TextStyle(
                                      color: AppTheme.primaryTextColor,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  );
                                case 1:
                                  final bool state = expenses != 0;
                                  return PieChartSectionData(
                                    value: state ? expenses : 0,
                                    color: AppTheme.expenseColor,
                                    radius: 50,
                                    showTitle: state,
                                    title: "${expenses.toStringAsFixed(2)} ${AppConstant.appCurrency}",
                                    titleStyle: const TextStyle(
                                      color: AppTheme.primaryTextColor,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  );

                                default:
                                  throw Exception(AppMessage.errorMessage_2);
                              }
                            }),
                          ),
                          swapAnimationDuration: AppConstant.durationSwap,
                          swapAnimationCurve: AppConstant.curve,
                        ),
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppMessage.balance,
                              style: TextStyle(
                                color: AppTheme.primaryTextColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${balance.toStringAsFixed(2)} ${AppConstant.appCurrency}",
                              style: TextStyle(
                                color: balanceState ? AppTheme.incomeColor : AppTheme.expenseColor,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: myList.length,
                  itemBuilder: (context, i) {
                    final Transactions transaction = myList[i];
                    return TransactionShape(
                      controller: controller,
                      transaction: transaction,
                      onPressed: () async {
                        final int id = transaction.id!;
                        var data = await controller.deleteTransaction(id);
                        setState(() {
                          myList.remove(transaction);
                          debugPrint(data);
                        });
                      },
                    );
                  },
                ),
              ],
            );
          }
        }
      }),
    );
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<HomeController>();
  }
}
