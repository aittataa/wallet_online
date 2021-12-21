import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet_online/app/config/themes/app_theme.dart';
import 'package:wallet_online/app/data/models/categories.dart';
import 'package:wallet_online/app/modules/home/controllers/home_controller.dart';
import 'package:wallet_online/app/modules/home/widgets/transaction_form.dart';

class TransactionAdd extends StatefulWidget {
  final HomeController controller;
  const TransactionAdd({Key? key, required this.controller}) : super(key: key);

  @override
  State<TransactionAdd> createState() => _TransactionAddState();
}

class _TransactionAddState extends State<TransactionAdd> {
  late HomeController controller;

  @override
  void initState() {
    super.initState();
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
        backgroundColor: AppTheme.backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        /*
      title: Row(
        children: [
          HeaderButton(
            index: 0,
            title: AppMessage.incomes,
            icon: CupertinoIcons.square_arrow_down_fill,
            onPressed: () {},
          ),
          HeaderButton(
            index: 1,
            title: AppMessage.expenses,
            icon: CupertinoIcons.square_arrow_up_fill,
            onPressed: () {},
          ),
        ],
      ),
      */
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.95,
          height: 300,
          child: Expanded(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                TransactionForm(
                  myList: myList.where((category) => category.state == 0).toList(),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
