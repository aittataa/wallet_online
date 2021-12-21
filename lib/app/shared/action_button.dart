import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:wallet_online/app/config/messages/app_message.dart';
import 'package:wallet_online/app/config/themes/app_theme.dart';

class ActionButton extends StatelessWidget {
  final Function()? onIncomeTap;
  final Function()? onExpensesTap;
  const ActionButton({
    Key? key,
    this.onIncomeTap,
    this.onExpensesTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      visible: true,
      backgroundColor: AppTheme.mainColor,
      foregroundColor: Colors.white,
      overlayOpacity: 0.25,
      overlayColor: AppTheme.primaryBackColor,
      icon: CupertinoIcons.plus_app,
      activeIcon: CupertinoIcons.xmark,
      curve: Curves.linearToEaseOut,
      animationSpeed: 250,
      children: [
        SpeedDialChild(
          label: AppMessage.incomes,
          labelStyle: TextStyle(color: AppTheme.primaryTextColor.withOpacity(.75), fontWeight: FontWeight.w900),
          child: Icon(CupertinoIcons.square_arrow_down_fill, color: AppTheme.incomeColor),
          onTap: onIncomeTap,
        ),
        SpeedDialChild(
          label: AppMessage.expenses,
          labelStyle: TextStyle(color: AppTheme.primaryTextColor.withOpacity(.75), fontWeight: FontWeight.w900),
          child: Icon(CupertinoIcons.square_arrow_up_fill, color: AppTheme.expenseColor),
          onTap: onExpensesTap,
        ),
      ],
    );
  }
}
