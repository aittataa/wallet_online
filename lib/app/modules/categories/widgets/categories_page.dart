import 'package:flutter/material.dart';
import 'package:wallet_online/app/data/models/categories.dart';
import 'package:wallet_online/app/modules/categories/controllers/categories_controller.dart';
import 'package:wallet_online/app/modules/categories/widgets/category_shape.dart';
import 'package:wallet_online/app/shared/empty_box.dart';

class CategoriesPage extends StatelessWidget {
  final CategoriesController controller;
  final List<Categories> myList;
  const CategoriesPage({
    Key? key,
    required this.controller,
    required this.myList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (myList.isNotEmpty) {
      return ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(10),
        physics: const BouncingScrollPhysics(),
        itemCount: myList.length,
        itemBuilder: (context, i) {
          final Categories category = myList[i];
          return CategoryShape(
            controller: controller,
            category: category,
          );
        },
      );
    } else {
      return EmptyBox();
    }
  }
}
