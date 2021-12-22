import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wallet_online/app/config/constants/app_constant.dart';
import 'package:wallet_online/app/config/functions/app_function.dart';
import 'package:wallet_online/app/config/themes/app_theme.dart';
import 'package:wallet_online/app/data/models/transactions.dart';
import 'package:wallet_online/app/modules/home/controllers/home_controller.dart';

class TransactionShape extends StatelessWidget {
  final HomeController controller;
  final Transactions transaction;
  final Function()? onPressed;
  //final Function()? onTap;
  const TransactionShape({
    Key? key,
    required this.controller,
    required this.transaction,
    //this.onTap,
    this.onPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: AppTheme.primaryBackColor,
        boxShadow: [AppConstant.boxShadow],
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        dense: true,
        contentPadding: EdgeInsets.zero.copyWith(left: 10),
        horizontalTitleGap: 0,
        leading: SizedBox(
          width: MediaQuery.of(context).size.width * .25,
          child: Text(
            (transaction.state == 0 ? "+" : "-") + "${transaction.amount!.toStringAsFixed(2)} MAD",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: transaction.state == 0 ? AppTheme.incomeColor : AppTheme.expenseColor,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        title: Row(
          children: [
            Text(
              "${transaction.categoryTitle}",
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppTheme.primaryTextColor,
                fontWeight: FontWeight.w900,
              ),
            ),
            if (transaction.description!.isNotEmpty)
              Expanded(
                child: Text(
                  " - ${transaction.description}",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppTheme.primaryTextColor.withOpacity(.75),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
        subtitle: Text(
          AppFunction.dateShape(transaction.date!),
          //"${transaction.date}",
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: AppTheme.primaryTextColor.withOpacity(.5),
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: IconButton(
          onPressed: onPressed,
          padding: EdgeInsets.zero,
          color: AppTheme.mainColor,
          splashColor: AppTheme.transparentColor,
          highlightColor: AppTheme.transparentColor,
          icon: const Icon(CupertinoIcons.trash_fill),
        ),
      ),
    );
  }
}
