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
  State<TransactionAdd> createState() => _TransactionAddState();
}

class _TransactionAddState extends State<TransactionAdd> {
  late HomeController controller;
  late PageController pageController = PageController();
  late int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    pageIndex = 0;
    pageController = PageController(initialPage: pageIndex);
    controller = widget.controller;
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
              state: pageIndex == 0,
              onPressed: () {
                setState(() {
                  pageIndex = 0;
                  pageController.jumpToPage(pageIndex);
                });
              },
            ),
            HeaderButton(
              title: AppMessage.expenses,
              icon: CupertinoIcons.square_arrow_up_fill,
              state: pageIndex == 1,
              onPressed: () {
                setState(() {
                  pageIndex = 1;
                  pageController.jumpToPage(pageIndex);
                });
              },
            ),
          ],
        ),
        content: SizedBox(
          width: AppConstant.screenWidth * 0.95,
          height: 300,
          child: PageView(
            onPageChanged: (index) {
              setState(() {
                pageIndex = index;
                pageController.jumpToPage(pageIndex);
              });
            },
            controller: pageController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              TransactionForm(
                controller: controller,
                pageIndex: pageIndex,
                myList: myList.where((category) => category.state == 0).toList(),
              ),
              TransactionForm(
                controller: controller,
                pageIndex: pageIndex,
                myList: myList.where((category) => category.state == 1).toList(),
              ),
            ],
          ),
        ),
      );
    });
  }
}
