import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../config/app_constant.dart';
import '../../../config/app_theme.dart';
import '../../../data/models/categories.dart';
import '../../../shared/empty_box.dart';
import '../controllers/statistic_controller.dart';
import '../widgets/statistic_shape.dart';

class StatisticPage extends StatelessWidget {
  final StatisticController controller;
  final List<Categories> myList;
  const StatisticPage({
    Key? key,
    required this.controller,
    required this.myList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (myList.isNotEmpty) {
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
            child: PieChart(
              PieChartData(
                sectionsSpace: 1,
                borderData: FlBorderData(show: false),
                sections: List.generate(myList.length, (i) {
                  final Categories category = myList[i];
                  return PieChartSectionData(
                    value: category.total,
                    color: Color(category.color!),
                    radius: 115,
                    titlePositionPercentageOffset: .75,
                    title: "${category.total!.toStringAsFixed(2)} ${AppConstant.appCurrency}",
                    titleStyle: const TextStyle(
                      color: AppTheme.primaryTextColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 12,
                    ),
                  );
                }),
              ),
              swapAnimationDuration: AppConstant.durationSwap,
              swapAnimationCurve: AppConstant.curve,
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(vertical: 5),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: myList.length,
            itemBuilder: (context, i) {
              final Categories category = myList[i];
              return StatisticShape(
                controller: controller,
                category: category,
              );
            },
          ),
        ],
      );
    } else {
      return const EmptyBox();
    }
  }
}
