import 'package:flutter/material.dart';

import '../config/app_constant.dart';
import '../config/app_theme.dart';

class AddButton extends StatelessWidget {
  final String title;
  final Color color;
  final Function()? onPressed;
  const AddButton({
    Key? key,
    required this.title,
    required this.color,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      minWidth: double.infinity,
      elevation: AppConstant.elevation,
      highlightElevation: AppConstant.elevation,
      color: color,
      splashColor: AppTheme.transparentColor,
      highlightColor: AppTheme.transparentColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.all(15),
      child: Text(
        title,
        style: TextStyle(
          color: AppTheme.secondaryTextColor,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
