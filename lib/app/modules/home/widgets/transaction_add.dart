import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet_online/app/config/constants/app_constant.dart';
import 'package:wallet_online/app/config/messages/app_message.dart';
import 'package:wallet_online/app/config/themes/app_theme.dart';
import 'package:wallet_online/app/data/models/categories.dart';
import 'package:wallet_online/app/modules/home/controllers/home_controller.dart';
import 'package:wallet_online/app/modules/home/widgets/transaction_form.dart';
import 'package:wallet_online/app/shared/header_button.dart';

class TransactionAdd extends StatefulWidget {
  final HomeController controller;
  const TransactionAdd({Key? key, required this.controller}) : super(key: key);
  @override
  State<TransactionAdd> createState() => _TransactionAddState(controller);
}

class _TransactionAddState extends State<TransactionAdd> {
  final HomeController controller;
  _TransactionAddState(this.controller);

  @override
  void initState() {
    super.initState();
    AppConstant.pageController = PageController(initialPage: AppConstant.pageIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final List<Categories> myList = controller.categories;
      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.zero,
        titlePadding: EdgeInsets.zero,
        actionsPadding: EdgeInsets.zero,
        buttonPadding: EdgeInsets.zero,
        backgroundColor: AppTheme.backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Row(
          children: [
            HeaderButton(
              title: AppMessage.incomes,
              icon: CupertinoIcons.square_arrow_down_fill,
              state: AppConstant.pageIndex == 0,
              onPressed: () {
                setState(() {
                  AppConstant.pageIndex = 0;
                  AppConstant.pageController.jumpToPage(AppConstant.pageIndex);
                });
              },
            ),
            HeaderButton(
              title: AppMessage.expenses,
              icon: CupertinoIcons.square_arrow_up_fill,
              state: AppConstant.pageIndex == 1,
              onPressed: () {
                setState(() {
                  AppConstant.pageIndex = 1;
                  AppConstant.pageController.jumpToPage(AppConstant.pageIndex);
                });
              },
            ),
          ],
        ),
        content: SizedBox(
          width: AppConstant.screenWidth * 0.95,
          height: 300,
          child: PageView(
            controller: AppConstant.pageController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              TransactionForm(
                controller: controller,
                pageIndex: AppConstant.pageIndex,
                myList: myList.where((category) => category.state == 0).toList()..sort((a, b) => b.id!.compareTo(a.id!)),
              ),
              TransactionForm(
                controller: controller,
                pageIndex: AppConstant.pageIndex,
                myList: myList.where((category) => category.state == 1).toList()..sort((a, b) => b.id!.compareTo(a.id!)),
              ),
            ],
          ),
        ),
      );
    });
  }
}
