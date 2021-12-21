import 'package:flutter/material.dart';
import 'package:wallet_online/app/config/constants/app_constant.dart';
import 'package:wallet_online/app/config/themes/app_theme.dart';
import 'package:wallet_online/app/data/models/categories.dart';
import 'package:wallet_online/app/modules/categories/controllers/categories_controller.dart';

class CategoryShape extends StatelessWidget {
  final CategoriesController controller;
  final Categories category;
  const CategoryShape({Key? key, required this.controller, required this.category});

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
        contentPadding: EdgeInsets.zero,
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
          style: TextStyle(color: AppTheme.primaryTextColor, fontWeight: FontWeight.w900),
        ),
      ),
    );
  }
}
