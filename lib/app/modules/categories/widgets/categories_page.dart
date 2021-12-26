import 'package:flutter/material.dart';
import 'package:wallet_online/app/data/models/categories.dart';
import 'package:wallet_online/app/modules/categories/controllers/categories_controller.dart';
import 'package:wallet_online/app/modules/categories/widgets/category_shape.dart';
import 'package:wallet_online/app/shared/empty_box.dart';

class CategoriesPage extends StatefulWidget {
  final CategoriesController controller;
  final List<Categories> myList;
  const CategoriesPage({
    Key? key,
    required this.controller,
    required this.myList,
  }) : super(key: key);
  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  @override
  Widget build(BuildContext context) {
    if (widget.myList.isNotEmpty) {
      return ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(10),
        physics: const BouncingScrollPhysics(),
        itemCount: widget.myList.length,
        itemBuilder: (context, i) {
          final Categories category = widget.myList[i];
          return CategoryShape(
            controller: widget.controller,
            category: category,
            onPressed: () async {
              final int id = category.id!;
              var data = await widget.controller.deleteCategory(id);
              setState(() {
                widget.myList.remove(category);
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
