import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../config/app_constant.dart';
import '../../../config/app_function.dart';
import '../../../config/app_theme.dart';
import '../../../data/models/categories.dart';
import '../controllers/categories_controller.dart';
import '../widgets/categories_add.dart';

class CategoryShape extends StatelessWidget {
  final CategoriesController controller;
  final Categories category;
  final Function()? onPressed;
  const CategoryShape({
    Key? key,
    required this.controller,
    required this.category,
    this.onPressed,
  });

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
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: AppTheme.primaryTextColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: SizedBox(
          width: 100,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                color: AppTheme.primaryIconColor.withOpacity(.75),
                splashColor: AppTheme.transparentColor,
                highlightColor: AppTheme.transparentColor,
                icon: Icon(IconlyLight.edit),
                onPressed: () => AppFunction.lunchNew(
                  context,
                  builder: CategoriesAdd(
                    controller: controller,
                    index: AppConstant.pageIndex,
                    status: true,
                    category: category,
                  ),
                ),
              ),
              IconButton(
                onPressed: onPressed,
                icon: Icon(
                  IconlyBold.delete,
                  // color: Color(category.color!),
                  color: AppTheme.primaryIconColor.withOpacity(.75),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
