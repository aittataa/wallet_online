import 'package:flutter/material.dart';

import '../../../config/app_constant.dart';
import '../../../config/app_function.dart';
import '../../../config/app_message.dart';
import '../../../config/app_theme.dart';
import '../../../data/models/categories.dart';
import '../../../shared/add_button.dart';
import '../../../shared/field_text.dart';
import '../controllers/categories_controller.dart';

class CategoriesAdd extends StatefulWidget {
  final CategoriesController controller;
  final bool status;
  final int index;
  final Categories category;
  const CategoriesAdd({Key? key, required this.controller, required this.index, this.status = false, required this.category}) : super(key: key);
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
          state ? AppMessage.newIncome : AppMessage.newExpenses,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppTheme.mainColor,
            fontWeight: FontWeight.w900,
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
              hintText: state ? AppMessage.typeNewIncome : AppMessage.typeNewExpenses,
              index: index,
            ),
            AddButton(
              title: widget.status ? AppMessage.labelUpdate : AppMessage.labelAdd,
              color: state ? AppTheme.incomeColor : AppTheme.expenseColor,
              onPressed: () async {
                try {
                  if (_controller.text.trim().isNotEmpty) {
                    final String title = _controller.text.trim();
                    final int color = AppFunction.getRandomColor;
                    if (widget.status) {
                      var data = await controller.updateCategory(
                        Categories(
                          title: title,
                          id: category.id,
                          color: category.color,
                          state: category.state,
                        ),
                      );
                      print(!(data == null));
                    } else {
                      var data = await controller.addCategory(
                        Categories(
                          title: title,
                          color: color,
                          state: index,
                        ),
                      );
                      print(!(data == null));
                    }
                  }
                  Navigator.pop(context);
                } catch (e) {
                  Navigator.pop(context);
                  AppFunction.snackBar(
                    title: AppMessage.errorTitle,
                    message: AppMessage.errorMessage_1,
                  );
                  throw Exception(AppMessage.errorMessage_1);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
