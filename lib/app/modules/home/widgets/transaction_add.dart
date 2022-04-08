import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet_online/app/config/app_translation.dart';
import 'package:wallet_online/app/shared/empty_box.dart';

import '../../../config/app_constant.dart';
import '../../../config/app_theme.dart';
import '../../../data/models/categories.dart';
import '../../../shared/header_button.dart';
import '../controllers/home_controller.dart';
import '../widgets/transaction_form.dart';

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
    return FutureBuilder<List<Categories>>(
        future: controller.loadCategories,
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            final List<Categories> myList = snapshot.data!;
            return AlertDialog(
              contentPadding: EdgeInsets.zero,
              insetPadding: EdgeInsets.zero,
              titlePadding: EdgeInsets.zero,
              actionsPadding: EdgeInsets.zero,
              buttonPadding: EdgeInsets.zero,
              backgroundColor: AppTheme.primaryBackColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              title: Row(
                children: [
                  HeaderButton(
                    title: AppKey.incomes.name.tr,
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
                    title: AppKey.expenses.name.tr,
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
                height: 270,
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
          }
          return const EmptyBox();
        });
  }
}
