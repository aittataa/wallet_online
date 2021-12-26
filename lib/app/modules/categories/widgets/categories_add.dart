import 'package:flutter/material.dart';
import 'package:wallet_online/app/config/constants/app_constant.dart';
import 'package:wallet_online/app/config/functions/app_function.dart';
import 'package:wallet_online/app/config/messages/app_message.dart';
import 'package:wallet_online/app/config/themes/app_theme.dart';
import 'package:wallet_online/app/data/models/categories.dart';
import 'package:wallet_online/app/modules/categories/controllers/categories_controller.dart';
import 'package:wallet_online/app/shared/add_button.dart';
import 'package:wallet_online/app/shared/field_text.dart';

class CategoriesAdd extends StatefulWidget {
  final CategoriesController controller;
  final bool status;
  final int index;
  final Categories category;
  CategoriesAdd({
    Key? key,
    required this.controller,
    required this.index,
    this.status = false,
    required this.category,
  }) : super(key: key);

  @override
  State<CategoriesAdd> createState() => _CategoriesAddState();
}

class _CategoriesAddState extends State<CategoriesAdd> {
  final TextEditingController _controller = TextEditingController();
  late CategoriesController controller;
  late int index;
  late bool state;
  late Categories category;
  @override
  void initState() {
    super.initState();
    controller = widget.controller;
    index = widget.index;
    state = index == 0;
    category = widget.category;

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
      backgroundColor: AppTheme.backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Container(
        padding: const EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppTheme.mainColor, width: 2),
          ),
        ),
        child: Text(
          state ? AppMessage.newIncome : AppMessage.newExpenses,
          style: const TextStyle(
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
              title: AppMessage.labelAdd,
              color: state ? AppTheme.incomeColor : AppTheme.expenseColor,
              onPressed: () async {
                try {
                  if (_controller.text.trim().isNotEmpty) {
                    String title = _controller.text.trim();

                    var data;
                    if (widget.status) {
                      data = await controller.updateCategory(
                        Categories(
                          title: title,
                          id: widget.category.id,
                          color: widget.category.color,
                          state: widget.category.state,
                        ),
                      );
                    } else {
                      int color = AppFunction.getRandomColor;
                      data = await controller.addCategory(
                        Categories(
                          title: title,
                          color: color,
                          state: index,
                        ),
                      );
                    }
                    setState(() {
                      print(data);
                      Navigator.pop(context);
                      //Get.offAll(() => InitialView(pageIndex: 1));
                    });
                  } else {
                    Navigator.pop(context);
                    AppFunction.snackBar(title: "Error", message: "Please Type Some Category");
                  }
                } catch (e) {
                  Navigator.pop(context);
                  AppFunction.snackBar(title: "Error", message: "Something Went Wrong");
                  throw Exception("Something Went Wrong");
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
