import 'package:flutter/material.dart';

import '../../../config/app_constant.dart';
import '../../../config/app_theme.dart';
import '../../../data/models/categories.dart';
import '../controllers/statistic_controller.dart';

class StatisticShape extends StatelessWidget {
  final StatisticController controller;
  final Categories category;
  const StatisticShape({Key? key, required this.controller, required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: AppTheme.primaryBackColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [AppConstant.boxShadow],
      ),
      child: ListTile(
        dense: true,
        contentPadding: EdgeInsets.zero.copyWith(right: 10),
        horizontalTitleGap: 0,
        leading: Container(
          width: 25,
          decoration: BoxDecoration(
            color: Color(category.color!),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              bottomLeft: Radius.circular(5),
            ),
          ),
        ),
        title: Text(
          "${category.title}",
          style: TextStyle(color: AppTheme.primaryTextColor, fontWeight: FontWeight.bold),
        ),
        trailing: Text(
          "${category.total!.toStringAsFixed(2)} ${AppConstant.appCurrency}",
          style: TextStyle(color: AppTheme.primaryTextColor, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
