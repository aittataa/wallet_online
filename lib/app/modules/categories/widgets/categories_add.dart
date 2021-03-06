import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet_online/app/config/app_translation.dart';

import '../../../config/app_constant.dart';
import '../../../config/app_function.dart';
import '../../../config/app_theme.dart';
import '../../../data/models/categories.dart';
import '../../../shared/field_text.dart';
import '../../../shared/outline_button.dart';
import '../controllers/categories_controller.dart';

class CategoriesAdd extends StatefulWidget {
  final CategoriesController controller;
  final bool status;
  final int index;
  final Categories category;
  const CategoriesAdd({
    Key? key,
    required this.controller,
    required this.index,
    this.status = false,
    required this.category,
  }) : super(key: key);
  @override
  State<CategoriesAdd> createState() => _CategoriesAddState(controller, index, category);
}

class _CategoriesAddState extends State<CategoriesAdd> {
  final CategoriesController controller;
  final int index;
  final Categories category;
  _CategoriesAddState(this.controller, this.index, this.category);

  final TextEditingController _controller = TextEditingController();
  late bool state = false;
  @override
  void initState() {
    super.initState();
    state = index == 0;
    if (widget.status) {
      _controller.text = category.title!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(10),
      insetPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      buttonPadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      backgroundColor: AppTheme.primaryBackColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppTheme.mainColor, width: 2),
          ),
        ),
        child: Text(
          state ? AppKey.newIncome.name.tr : AppKey.newExpenses.name.tr,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppTheme.mainColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      content: SizedBox(
        width: AppConstant.screenWidth * 0.85,
        height: 125,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FieldText(
              controller: _controller,
              hintText: state ? AppKey.typeNewIncome.name.tr : AppKey.typeNewExpenses.name.tr,
              index: index,
            ),
            OutlineButton(
              title: widget.status ? AppKey.labelUpdate.name.tr : AppKey.labelAdd.name.tr,
              color: state ? AppTheme.incomeColor : AppTheme.expenseColor,
              onPressed: () async {
                try {
                  if (_controller.text.trim().isNotEmpty) {
                    final String title = _controller.text.trim();
                    final int color = AppFunction.getRandomColor;
                    if (widget.status) {
                      late Categories updatedCategory = Categories(id: category.id, title: title);
                      var data = await controller.updateCategory(updatedCategory);

                      print(!(data == null));
                    } else {
                      final Categories insertedCategory = Categories(title: title, color: color, state: index);
                      var data = await controller.addCategory(insertedCategory);
                      print(!(data == null));
                    }
                  }
                  print(AppConstant.pageIndex);
                  Navigator.pop(context);
                } catch (e) {
                  Navigator.pop(context);
                  AppFunction.snackBar(
                    title: AppKey.errorTitle.name.tr,
                    message: AppKey.errorMessage.name.tr,
                  );
                  throw Exception(AppKey.errorMessage.name.tr);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
