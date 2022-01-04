import 'package:flutter/material.dart';

import '../../../data/models/categories.dart';
import '../../../shared/empty_box.dart';
import '../controllers/categories_controller.dart';
import '../widgets/category_shape.dart';

class CategoriesPage extends StatefulWidget {
  final CategoriesController controller;
  final List<Categories> myList;
  const CategoriesPage({
    Key? key,
    required this.controller,
    required this.myList,
  }) : super(key: key);
  @override
  State<CategoriesPage> createState() => _CategoriesPageState(controller, myList);
}

class _CategoriesPageState extends State<CategoriesPage> {
  final CategoriesController controller;
  final List<Categories> myList;
  _CategoriesPageState(this.controller, this.myList);
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
            onPressed: () async {
              final int id = category.id!;
              var data = await controller.deleteCategory(id);
              setState(() {
                myList.remove(category);
                print(data);
              });
            },
          );
        },
      );
    } else {
      return const EmptyBox();
    }
  }
}
