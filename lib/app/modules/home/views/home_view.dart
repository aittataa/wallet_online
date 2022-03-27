import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import '../../../config/app_constant.dart';
import '../../../config/app_enum.dart';
import '../../../config/app_function.dart';
import '../../../config/app_message.dart';
import '../../../config/app_theme.dart';
import '../../../data/models/settings.dart';
import '../../../data/models/transactions.dart';
import '../../../shared/bounce_point.dart';
import '../../../shared/empty_box.dart';
import '../../../shared/floating_button.dart';
import '../controllers/home_controller.dart';
import '../widgets/transaction_add.dart';
import '../widgets/transaction_shape.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeController controller = Get.put(HomeController());
  late bool visible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppMessage.appTitle),
      ),
      floatingActionButton: FloatingButton(
        visible: visible,
        onPressed: () {
          AppFunction.lunchNew(
            context,
            builder: TransactionAdd(controller: controller),
          );
        },
      ),
      body: Obx(() {
        final bool state = controller.state.value;
        if (!state) {
          final Settings appSettings = controller.settings.value;
          AppConstant.currency = appSettings.currency!;
          AppConstant.appCurrency = AppEnum.currencies[appSettings.currency]!;
          final List<Transactions> myList = controller.transactions;
          final bool isNotEmpty = myList.isNotEmpty;
          if (isNotEmpty) {
            final double incomes = AppFunction.loadCount(myList, 0);
            final double expenses = AppFunction.loadCount(myList, 1);
            final balance = incomes - expenses;
            final balanceState = balance >= 0;
            return NotificationListener<UserScrollNotification>(
              onNotification: (notification) {
                if (notification.direction == ScrollDirection.forward) {
                  if (!visible) setState(() => {visible = true});
                } else if (notification.direction == ScrollDirection.reverse) {
                  if (visible) setState(() => {visible = false});
                }
                return true;
              },
              child: ListView(
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
                      alignment: AlignmentDirectional.center,
                      children: [
                        PieChart(
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
                                      fontWeight: FontWeight.bold,
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
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );

                                default:
                                  throw Exception(AppMessage.errorMessage_1);
                              }
                            }),
                          ),
                          swapAnimationDuration: AppConstant.durationSwap,
                          swapAnimationCurve: AppConstant.curve,
                        ),
                        ListTile(
                          title: Text(
                            "${AppMessage.balance}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppTheme.primaryTextColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            "${balance.toStringAsFixed(2)} ${AppConstant.appCurrency}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: balanceState ? AppTheme.incomeColor : AppTheme.expenseColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //SizedBox(height: 5),
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
                            print(!(data == null));
                          });
                        },
                      );
                    },
                  ),
                ],
              ),
            );
          } else {
            return EmptyBox();
          }
        } else {
          return BouncePoint();
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

/*GroupedListView<dynamic, DateTime>(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  elements: myList,
                  order: GroupedListOrder.DESC,
                  groupComparator: (a, b) => a.compareTo(b),
                  itemComparator: (a, b) => a.date.compareTo(b.date),
                  groupBy: (transaction) {
                    final DateTime datetime = transaction.date;
                    return DateTime.utc(datetime.year, datetime.month, datetime.day);
                  },
                  groupSeparatorBuilder: (DateTime date) {
                    if (date.isAtSameMomentAs(DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day - 1))) {
                      return DateItem(label: AppMessage.labelYesterday, date: date);
                    } else if (date.isAtSameMomentAs(DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day))) {
                      return DateItem(label: AppMessage.labelToday, date: date);
                    } else if (date.isAtSameMomentAs(DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day + 1))) {
                      return DateItem(label: AppMessage.labelTomorrow, date: date);
                    } else {
                      return DateItem(label: AppFunction.dateShape(date), date: date);
                    }
                  },
                  itemBuilder: (context, transaction) {
                    return TransactionShape(
                      controller: controller,
                      transaction: transaction,
                      onPressed: () async {
                        final int id = transaction.id!;
                        var data = await controller.deleteTransaction(id);
                        setState(() {
                          myList.remove(transaction);
                          print(!(data == null));
                        });
                      },
                    );
                  },
                ),*/
