import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet_online/app/config/constants/app_constant.dart';
import 'package:wallet_online/app/config/functions/app_function.dart';
import 'package:wallet_online/app/config/messages/app_message.dart';
import 'package:wallet_online/app/config/themes/app_theme.dart';
import 'package:wallet_online/app/data/models/categories.dart';
import 'package:wallet_online/app/modules/categories/controllers/categories_controller.dart';
import 'package:wallet_online/app/modules/initial/views/initial_view.dart';
import 'package:wallet_online/app/shared/add_button.dart';
import 'package:wallet_online/app/shared/field_text.dart';

class CategoriesAdd extends StatefulWidget {
  final CategoriesController controller;
  final int index;
  CategoriesAdd({Key? key, required this.controller, required this.index}) : super(key: key);

  @override
  State<CategoriesAdd> createState() => _CategoriesAddState();
}

class _CategoriesAddState extends State<CategoriesAdd> {
  final TextEditingController _controller = TextEditingController();
  late CategoriesController controller;
  late int index;
  late bool state;
  @override
  void initState() {
    super.initState();
    controller = widget.controller;
    index = widget.index;
    state = index == 0;
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
        height: 150,
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
                  if (_controller.text.isNotEmpty) {
                    String title = _controller.text.trim();
                    int color = AppFunction.getRandomColor;
                    final Categories category = Categories(
                      title: title,
                      color: color,
                      state: index,
                    );
                    var data = controller.addCategory(category);
                    print(data);
                    Get.offAll(() => InitialView(pageIndex: 1));
                  }
                  Navigator.pop(context);
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
