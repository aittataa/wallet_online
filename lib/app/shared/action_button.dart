import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../config/app_constant.dart';
import '../config/app_theme.dart';

class ActionButton extends StatelessWidget {
  final Function() onPressed;
  final Function()? onIncomeTap;
  final Function()? onExpensesTap;
  const ActionButton({
    Key? key,
    required this.onPressed,
    this.onIncomeTap,
    this.onExpensesTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      elevation: AppConstant.elevation,
      backgroundColor: AppTheme.mainColor,
      splashColor: AppTheme.transparentColor,
      foregroundColor: AppTheme.transparentColor,
      focusColor: AppTheme.transparentColor,
      hoverColor: AppTheme.transparentColor,
      child: Icon(
        CupertinoIcons.plus_app,
        color: AppTheme.secondaryIconColor,
      ),
    );
  }
}
